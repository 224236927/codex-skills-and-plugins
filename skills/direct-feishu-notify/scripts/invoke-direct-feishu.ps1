param(
  [string]$Message,
  [string]$FilePath,
  [switch]$AsAudioBubble,
  [switch]$AsCard,
  [string]$CardTitle,
  [string]$CardMarkdown,
  [string]$Target,
  [ValidateSet("open_id", "chat_id", "user_id", "union_id", "email")]
  [string]$ReceiveIdType = "open_id",
  [string]$ConfigPath,
  [string]$FfmpegPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.Net.Http

function Get-DefaultConfigPath {
  $skillRoot = Split-Path -Parent $PSScriptRoot
  return Join-Path $skillRoot "config\\feishu-config.local.json"
}

function Read-FeishuConfig {
  param([Parameter(Mandatory = $true)][string]$Path)

  if (-not (Test-Path -LiteralPath $Path)) {
    throw "Config file not found: $Path"
  }

  $raw = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
  if (-not $raw.app_id -or -not $raw.app_secret) {
    throw "Failed to read Feishu app credentials from $Path"
  }

  [pscustomobject]@{
    AppId = [string]$raw.app_id
    AppSecret = [string]$raw.app_secret
    DefaultTarget = [string]$raw.default_target
    DefaultReceiveIdType = [string]$raw.default_receive_id_type
    FfmpegPath = [string]$raw.ffmpeg_path
  }
}

function Invoke-FeishuJson {
  param(
    [Parameter(Mandatory = $true)][string]$Method,
    [Parameter(Mandatory = $true)][string]$Uri,
    [Parameter(Mandatory = $true)][string]$Token,
    [Parameter(Mandatory = $false)]$Body
  )

  $headers = @{
    Authorization = "Bearer $Token"
  }

  if ($null -eq $Body) {
    return Invoke-RestMethod -Method $Method -Uri $Uri -Headers $headers
  }

  $json = $Body | ConvertTo-Json -Depth 10 -Compress
  return Invoke-RestMethod -Method $Method -Uri $Uri -Headers $headers -ContentType "application/json; charset=utf-8" -Body $json
}

function Get-FeishuTenantToken {
  param(
    [Parameter(Mandatory = $true)][string]$AppId,
    [Parameter(Mandatory = $true)][string]$AppSecret
  )

  $resp = Invoke-RestMethod -Method Post -Uri "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal" -ContentType "application/json; charset=utf-8" -Body (@{
      app_id     = $AppId
      app_secret = $AppSecret
    } | ConvertTo-Json -Compress)

  if ($resp.code -ne 0 -or -not $resp.tenant_access_token) {
    throw ("Failed to get tenant token: " + (($resp | ConvertTo-Json -Depth 8 -Compress)))
  }

  return $resp.tenant_access_token
}

function Invoke-FeishuMultipartUpload {
  param(
    [Parameter(Mandatory = $true)][string]$Uri,
    [Parameter(Mandatory = $true)][string]$Token,
    [Parameter(Mandatory = $true)][hashtable]$Fields,
    [Parameter(Mandatory = $true)][string]$FileFieldName,
    [Parameter(Mandatory = $true)][string]$UploadPath,
    [string]$ContentType = "application/octet-stream"
  )

  $client = New-Object System.Net.Http.HttpClient
  $client.DefaultRequestHeaders.Authorization = New-Object System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", $Token)
  $multipart = New-Object System.Net.Http.MultipartFormDataContent
  $stream = $null

  try {
    foreach ($key in $Fields.Keys) {
      $multipart.Add((New-Object System.Net.Http.StringContent([string]$Fields[$key])), $key)
    }

    $stream = [System.IO.File]::OpenRead($UploadPath)
    $fileContent = New-Object System.Net.Http.StreamContent($stream)
    $fileContent.Headers.ContentType = New-Object System.Net.Http.Headers.MediaTypeHeaderValue($ContentType)
    $multipart.Add($fileContent, $FileFieldName, [System.IO.Path]::GetFileName($UploadPath))

    $response = $client.PostAsync($Uri, $multipart).GetAwaiter().GetResult()
    $body = $response.Content.ReadAsStringAsync().GetAwaiter().GetResult()
    if (-not $response.IsSuccessStatusCode) {
      throw "Upload failed: HTTP $([int]$response.StatusCode) $body"
    }

    return $body | ConvertFrom-Json
  }
  finally {
    if ($stream) {
      $stream.Dispose()
    }
    $multipart.Dispose()
    $client.Dispose()
  }
}

function Get-FileTypeFromExtension {
  param([Parameter(Mandatory = $true)][string]$Path)

  switch ([System.IO.Path]::GetExtension($Path).ToLowerInvariant()) {
    ".pdf" { return "pdf" }
    ".doc" { return "doc" }
    ".docx" { return "doc" }
    ".xls" { return "xls" }
    ".xlsx" { return "xls" }
    ".ppt" { return "ppt" }
    ".pptx" { return "ppt" }
    ".mp4" { return "mp4" }
    ".opus" { return "opus" }
    default { return "stream" }
  }
}

function Get-SendMode {
  param(
    [Parameter(Mandatory = $true)][string]$Path,
    [switch]$AudioBubble
  )

  if ($AudioBubble) {
    return "audio"
  }

  switch ([System.IO.Path]::GetExtension($Path).ToLowerInvariant()) {
    ".png" { return "image" }
    ".jpg" { return "image" }
    ".jpeg" { return "image" }
    ".gif" { return "image" }
    ".webp" { return "image" }
    ".bmp" { return "image" }
    ".mp4" { return "media" }
    default { return "file" }
  }
}

function Resolve-FfmpegPath {
  param([string]$Candidate)

  if ($Candidate) {
    if (-not (Test-Path -LiteralPath $Candidate)) {
      throw "ffmpeg not found at: $Candidate"
    }
    return $Candidate
  }

  $cmd = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue
  if ($cmd) {
    return $cmd.Source
  }

  $cmd = Get-Command ffmpeg -ErrorAction SilentlyContinue
  if ($cmd) {
    return $cmd.Source
  }

  throw "ffmpeg was not found in PATH. Provide -FfmpegPath explicitly."
}

function Convert-ToOpusIfNeeded {
  param(
    [Parameter(Mandatory = $true)][string]$SourcePath,
    [string]$PreferredFfmpegPath
  )

  if ([System.IO.Path]::GetExtension($SourcePath).ToLowerInvariant() -eq ".opus") {
    return [pscustomobject]@{
      UploadPath = $SourcePath
      ConvertedPath = $null
    }
  }

  $ffmpeg = Resolve-FfmpegPath -Candidate $PreferredFfmpegPath
  $tempDir = Join-Path $env:TEMP "codex-direct-feishu"
  if (-not (Test-Path -LiteralPath $tempDir)) {
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null
  }

  $convertedPath = Join-Path $tempDir (([System.IO.Path]::GetFileNameWithoutExtension($SourcePath)) + "-" + [guid]::NewGuid().ToString("N") + ".opus")
  $stdoutPath = Join-Path $tempDir ([guid]::NewGuid().ToString("N") + ".stdout.log")
  $stderrPath = Join-Path $tempDir ([guid]::NewGuid().ToString("N") + ".stderr.log")
  $proc = Start-Process -FilePath $ffmpeg -ArgumentList @("-y", "-i", $SourcePath, "-c:a", "libopus", "-b:a", "32k", $convertedPath) -Wait -PassThru -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath
  if ($proc.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $convertedPath)) {
    throw "ffmpeg failed to convert audio to opus."
  }

  return [pscustomobject]@{
    UploadPath = $convertedPath
    ConvertedPath = $convertedPath
  }
}

function Send-FeishuMessage {
  param(
    [Parameter(Mandatory = $true)][string]$Token,
    [Parameter(Mandatory = $true)][string]$ReceiveIdType,
    [Parameter(Mandatory = $true)][string]$ReceiveId,
    [Parameter(Mandatory = $true)][string]$MsgType,
    [Parameter(Mandatory = $true)][hashtable]$Content
  )

  return Invoke-FeishuJson -Method Post -Uri ("https://open.feishu.cn/open-apis/im/v1/messages?receive_id_type=" + $ReceiveIdType) -Token $Token -Body @{
    receive_id = $ReceiveId
    msg_type = $MsgType
    content = ($Content | ConvertTo-Json -Depth 20 -Compress)
  }
}

function Send-FeishuCard {
  param(
    [Parameter(Mandatory = $true)][string]$Token,
    [Parameter(Mandatory = $true)][string]$ReceiveIdType,
    [Parameter(Mandatory = $true)][string]$ReceiveId,
    [Parameter(Mandatory = $true)][string]$Title,
    [Parameter(Mandatory = $true)][string]$Markdown,
    [string]$Template = "blue"
  )

  $card = @{
    config = @{
      wide_screen_mode = $true
      enable_forward = $true
    }
    header = @{
      template = $Template
      title = @{
        tag = "plain_text"
        content = $Title
      }
    }
    elements = @(
      @{
        tag = "div"
        text = @{
          tag = "lark_md"
          content = $Markdown
        }
      }
    )
  }

  return Send-FeishuMessage -Token $Token -ReceiveIdType $ReceiveIdType -ReceiveId $ReceiveId -MsgType "interactive" -Content $card
}

if (-not $ConfigPath) {
  $ConfigPath = Get-DefaultConfigPath
}

if (-not $Message -and -not $FilePath -and -not $CardMarkdown) {
  throw "Provide -Message and/or -FilePath."
}

$config = Read-FeishuConfig -Path $ConfigPath
if (-not $PSBoundParameters.ContainsKey("ReceiveIdType") -and $config.DefaultReceiveIdType) {
  $ReceiveIdType = $config.DefaultReceiveIdType
}
if (-not $FfmpegPath -and $config.FfmpegPath) {
  $FfmpegPath = $config.FfmpegPath
}
$receiveId = if ($Target) { $Target } else { $config.DefaultTarget }
if (-not $receiveId) {
  throw "No target was provided and no default_target was found in $ConfigPath"
}

$token = Get-FeishuTenantToken -AppId $config.AppId -AppSecret $config.AppSecret
$sent = New-Object System.Collections.Generic.List[object]
$convertedAudioPath = $null

$shouldSendCard = $AsCard -or [bool]$CardTitle -or [bool]$CardMarkdown

if ($Message -or $CardMarkdown) {
  if ($shouldSendCard) {
    $resolvedTitle = if ($CardTitle) { $CardTitle } else { "Codex Notification" }
    $resolvedMarkdown = if ($CardMarkdown) { $CardMarkdown } else { $Message }
    $resp = Send-FeishuCard -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -Title $resolvedTitle -Markdown $resolvedMarkdown
    $sent.Add([pscustomobject]@{
        kind = "message"
        msg_type = "interactive"
        title = $resolvedTitle
        message_id = $resp.data.message_id
        chat_id = $resp.data.chat_id
      })
  } else {
    $resp = Send-FeishuMessage -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -MsgType "text" -Content @{ text = $Message }
    $sent.Add([pscustomobject]@{
        kind = "message"
        msg_type = "text"
        message_id = $resp.data.message_id
        chat_id = $resp.data.chat_id
      })
  }
}

if ($FilePath) {
  if (-not (Test-Path -LiteralPath $FilePath)) {
    throw "File not found: $FilePath"
  }

  $mode = Get-SendMode -Path $FilePath -AudioBubble:$AsAudioBubble

  switch ($mode) {
    "image" {
      $upload = Invoke-FeishuMultipartUpload -Uri "https://open.feishu.cn/open-apis/im/v1/images" -Token $token -Fields @{ image_type = "message" } -FileFieldName "image" -UploadPath $FilePath
      if ($upload.code -ne 0 -or -not $upload.data.image_key) {
        throw ("Image upload failed: " + ($upload | ConvertTo-Json -Depth 8 -Compress))
      }

      $resp = Send-FeishuMessage -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -MsgType "image" -Content @{ image_key = $upload.data.image_key }
      $sent.Add([pscustomobject]@{
          kind = "attachment"
          file_path = $FilePath
          msg_type = "image"
          message_id = $resp.data.message_id
          chat_id = $resp.data.chat_id
        })
    }
    "media" {
      $upload = Invoke-FeishuMultipartUpload -Uri "https://open.feishu.cn/open-apis/im/v1/files" -Token $token -Fields @{
          file_type = "mp4"
          file_name = [System.IO.Path]::GetFileName($FilePath)
        } -FileFieldName "file" -UploadPath $FilePath
      if ($upload.code -ne 0 -or -not $upload.data.file_key) {
        $fileKey = $upload.file_key
      } else {
        $fileKey = $upload.data.file_key
      }
      if (-not $fileKey) {
        throw ("Video upload failed: " + ($upload | ConvertTo-Json -Depth 8 -Compress))
      }

      $resp = Send-FeishuMessage -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -MsgType "media" -Content @{ file_key = $fileKey }
      $sent.Add([pscustomobject]@{
          kind = "attachment"
          file_path = $FilePath
          msg_type = "media"
          message_id = $resp.data.message_id
          chat_id = $resp.data.chat_id
        })
    }
    "audio" {
      $audio = Convert-ToOpusIfNeeded -SourcePath $FilePath -PreferredFfmpegPath $FfmpegPath
      $convertedAudioPath = $audio.ConvertedPath
      $upload = Invoke-FeishuMultipartUpload -Uri "https://open.feishu.cn/open-apis/im/v1/files" -Token $token -Fields @{
          file_type = "opus"
          file_name = [System.IO.Path]::GetFileName($audio.UploadPath)
        } -FileFieldName "file" -UploadPath $audio.UploadPath
      if ($upload.code -ne 0 -or -not $upload.data.file_key) {
        $fileKey = $upload.file_key
      } else {
        $fileKey = $upload.data.file_key
      }
      if (-not $fileKey) {
        throw ("Audio upload failed: " + ($upload | ConvertTo-Json -Depth 8 -Compress))
      }

      $resp = Send-FeishuMessage -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -MsgType "audio" -Content @{ file_key = $fileKey }
      $sent.Add([pscustomobject]@{
          kind = "attachment"
          file_path = $FilePath
          upload_path = $audio.UploadPath
          msg_type = "audio"
          message_id = $resp.data.message_id
          chat_id = $resp.data.chat_id
        })
    }
    default {
      $fileType = Get-FileTypeFromExtension -Path $FilePath
      $upload = Invoke-FeishuMultipartUpload -Uri "https://open.feishu.cn/open-apis/im/v1/files" -Token $token -Fields @{
          file_type = $fileType
          file_name = [System.IO.Path]::GetFileName($FilePath)
        } -FileFieldName "file" -UploadPath $FilePath
      if ($upload.code -ne 0 -or -not $upload.data.file_key) {
        $fileKey = $upload.file_key
      } else {
        $fileKey = $upload.data.file_key
      }
      if (-not $fileKey) {
        throw ("File upload failed: " + ($upload | ConvertTo-Json -Depth 8 -Compress))
      }

      $resp = Send-FeishuMessage -Token $token -ReceiveIdType $ReceiveIdType -ReceiveId $receiveId -MsgType "file" -Content @{ file_key = $fileKey }
      $sent.Add([pscustomobject]@{
          kind = "attachment"
          file_path = $FilePath
          msg_type = "file"
          message_id = $resp.data.message_id
          chat_id = $resp.data.chat_id
        })
    }
  }
}

[pscustomobject]@{
  target = $receiveId
  receive_id_type = $ReceiveIdType
  config_path = $ConfigPath
  converted_audio_path = $convertedAudioPath
  sent = $sent
} | ConvertTo-Json -Depth 8
