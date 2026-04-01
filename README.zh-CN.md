# Codex Skills 与 Plugins

[English](./README.md)

这个仓库用于存放可复用的 Codex skills，以及未来可扩展的插件目录。

## 当前包含的 Skills

### `skills/document-ingestion-and-recovery`

- 对 `markitdown` 支持的格式优先使用 `markitdown`
- 按文件类型做提取结果验收
- 在提取质量下降时，按需走 OCR 或更低层的补救路径

### `skills/markitdown-docx-extraction`

- 专注于 `.docx` 文档的 `markitdown` 提取流程
- 避免过早进入 ZIP/XML 低层解析

## 仓库结构

```text
skills/   可复用的 Codex skills
plugins/  未来预留的 Codex 插件目录
```

## 使用方式

将本仓库中的 skill 目录复制到 `$CODEX_HOME/skills` 或 `~/.codex/skills` 下即可使用。

## 说明

- 当前 `plugins/` 目录为空，作为后续扩展预留。
- 这个仓库当前重点围绕文档摄取、提取与恢复流程。
