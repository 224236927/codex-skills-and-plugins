<p align="center">
  <img src="./assets/repo-hero.svg" alt="Codex Skills and Plugins banner" width="100%" />
</p>

<p align="center">
  <a href="./README.zh-CN.md">简体中文</a> ·
  <a href="./CONTRIBUTING.md">Contributing</a> ·
  <a href="./plugins/codex-starter/.codex-plugin/plugin.json">Starter Plugin</a>
</p>

<p align="center">
  <img alt="skills" src="https://img.shields.io/badge/Codex-Skills-1f6feb?style=flat-square" />
  <img alt="plugins" src="https://img.shields.io/badge/Starter-Plugin_Template-ff8c42?style=flat-square" />
  <img alt="docs" src="https://img.shields.io/badge/Docs-Bilingual-2da44e?style=flat-square" />
</p>

# Codex Skills and Plugins

A mixed-style maintainer homepage for reusable Codex skills, starter plugin scaffolds, and beginner-friendly project docs.

This repo is meant to feel halfway between a polished documentation hub and a personal toolbox shelf: practical, reusable, and easy to browse even if someone is new to Codex.

## Start Here

| I want to... | Go here |
| --- | --- |
| Install ready-to-use skills | [`skills/`](./skills) |
| Understand the doc ingestion workflow | [`skills/document-ingestion-and-recovery`](./skills/document-ingestion-and-recovery) |
| Extract `.docx` safely with `markitdown` | [`skills/markitdown-docx-extraction`](./skills/markitdown-docx-extraction) |
| Use a publishable plugin skeleton | [`plugins/codex-starter`](./plugins/codex-starter) |
| Publish plugins in a repo marketplace | [`.agents/plugins/marketplace.json`](./.agents/plugins/marketplace.json) |
| Contribute or adapt this repo | [`CONTRIBUTING.md`](./CONTRIBUTING.md) |

## What Makes This Repo Different

- It ships real skills, not just placeholders.
- It includes a starter plugin structure that matches Codex plugin conventions.
- It treats documentation as part of the product, with English and Simplified Chinese entry points.
- It is built to be copied, remixed, and expanded by maintainers who want a more personal GitHub project style.

## Repository Layout

```text
.agents/plugins/   Marketplace metadata for repo-local plugins
assets/            Visual assets for the repository
plugins/           Starter and future Codex plugins
skills/            Reusable Codex skills
```

## Included Skills

### `document-ingestion-and-recovery`

- Use `markitdown` first for formats it supports.
- Validate extraction quality by file type.
- Recover degraded output with OCR or lower-level fallback only when needed.

### `markitdown-docx-extraction`

- Focused workflow for `.docx` extraction.
- Prevents premature ZIP/XML parsing.
- Encourages readable Markdown sidecar files before analysis work begins.

## Included Starter Plugin

### `plugins/codex-starter`

This starter plugin is intentionally lightweight:

- Includes `.codex-plugin/plugin.json`
- Includes optional folders for `skills`, `scripts`, `hooks`, and `assets`
- Includes placeholder companion files for `.mcp.json` and `.app.json`
- Is already listed in the local marketplace manifest

Use it as the baseline for your own plugin instead of scaffolding from scratch every time.

## Quick Setup

### Use the skills locally

Copy the folders under [`skills/`](./skills) into `$CODEX_HOME/skills` or `~/.codex/skills`.

### Use the starter plugin locally

Copy [`plugins/codex-starter`](./plugins/codex-starter) into a Codex plugin directory and then replace the placeholder metadata in [`plugin.json`](./plugins/codex-starter/.codex-plugin/plugin.json).

## Friendly Notes For Beginners

- On GitHub, people usually say `author`, `developer`, or `maintainer` rather than a platform-specific term like Bilibili's `UP主`.
- If you are new to Codex, start with the skills first. The plugin starter is the next step after you are comfortable with the basics.
- If terminal output on Windows shows garbled Chinese, check the file in a UTF-8-aware editor before assuming the file itself is broken.

## License

This repository is available under the [MIT License](./LICENSE).
