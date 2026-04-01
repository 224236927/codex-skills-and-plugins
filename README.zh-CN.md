<p align="center">
  <img src="./assets/repo-hero.svg" alt="Codex Skills and Plugins 横幅" width="100%" />
</p>

<p align="center">
  <a href="./README.md">English</a> |
  <a href="./CONTRIBUTING.zh-CN.md">贡献说明</a> |
  <a href="./plugins/codex-starter/.codex-plugin/plugin.json">插件模板</a>
</p>

<p align="center">
  <img alt="skills" src="https://img.shields.io/badge/Codex-Skills-1f6feb?style=flat-square" />
  <img alt="plugins" src="https://img.shields.io/badge/Starter-Plugin_Template-ff8c42?style=flat-square" />
  <img alt="docs" src="https://img.shields.io/badge/Docs-Bilingual-2da44e?style=flat-square" />
</p>

# Codex Skills and Plugins

这是一个围绕真实 Codex 工作流整理出来的开源项目集合，把可复用的 skills、可继续扩展的 starter plugin，以及配套的双语文档放在同一个仓库里。

它面向想要直接使用、改造或发布 Codex 工作流组件的人，尽量把结构保持清楚，把入口做得直接，也让第一次接触这类项目的人能够顺着上手。

## 先挑一格开始看

| 如果你想... | 从这里开始 |
| --- | --- |
| 直接看看可复用的 skills | [`skills/`](./skills) |
| 了解文档摄取与恢复流程 | [`skills/document-ingestion-and-recovery`](./skills/document-ingestion-and-recovery) |
| 先用 `markitdown` 提取 `.docx` | [`skills/markitdown-docx-extraction`](./skills/markitdown-docx-extraction) |
| 从一个可发布的插件骨架开始 | [`plugins/codex-starter`](./plugins/codex-starter) |
| 看仓库内插件如何挂到 marketplace | [`.agents/plugins/marketplace.json`](./.agents/plugins/marketplace.json) |
| 继续改造或参与贡献 | [`CONTRIBUTING.zh-CN.md`](./CONTRIBUTING.zh-CN.md) |

## 这里收了什么

这个仓库主要把三类东西放在一起：

- 能直接解决实际流程问题的 skills，而不是只摆一个空壳。
- 一个足够轻、但已经能作为发布起点的 starter plugin。
- 中英双语文档，让日常使用和新手入门都不至于太吃力。

## 仓库结构

```text
.agents/plugins/   仓库内插件的 marketplace 元数据
assets/            仓库视觉资源
plugins/           插件模板与后续插件
skills/            可复用的 Codex skills
```

## 当前收录的 Skills

### `document-ingestion-and-recovery`

- 对支持的格式优先走 `markitdown`。
- 先检查提取质量，再决定是否继续处理。
- 只有在简单路径不够用时，才退回到 OCR 或更底层的补救方案。

### `markitdown-docx-extraction`

- 专门处理 `.docx` 提取。
- 避免过早钻进 ZIP/XML 级别的解析。
- 先产出可读的 Markdown sidecar，再进入审阅或分析流程。

## 当前收录的插件模板

### `plugins/codex-starter`

这个模板刻意保持简单，但已经把那些每次都要重复搭的东西先放好了：

- `.codex-plugin/plugin.json`
- `skills`、`scripts`、`hooks`、`assets` 等可选目录
- `.mcp.json` 和 `.app.json` 的占位文件
- 对应的本地 marketplace 清单入口

它更适合被复制、改名、继续长成真正的插件，而不是每次都从空目录重新搭结构。

## 快速开始

### 本地使用 skills

把 [`skills/`](./skills) 下的目录复制到 `$CODEX_HOME/skills` 或 `~/.codex/skills`。

### 本地使用插件模板

把 [`plugins/codex-starter`](./plugins/codex-starter) 复制到你的 Codex 插件目录，然后按需替换 [`plugin.json`](./plugins/codex-starter/.codex-plugin/plugin.json) 里的占位信息。

## 如果你刚开始接触 Codex

- 先从 skills 看起。这里最容易上手，也最能看出这个仓库的工作方式。
- 等你准备把自己的流程打包出来时，再去用 starter plugin。
- 如果 Windows 终端里中文显示乱码，先用支持 UTF-8 的编辑器确认文件内容，再判断是不是文件本身有问题。

## 许可协议

本仓库采用 [MIT License](./LICENSE)。
