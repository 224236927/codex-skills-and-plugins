<p align="center">
  <img src="./assets/repo-hero.svg" alt="Codex Skills and Plugins banner" width="100%" />
</p>

<p align="center">
  <a href="./README.zh-CN.md">简体中文</a> |
  <a href="./CONTRIBUTING.md">Contributing</a> |
  <a href="./plugins/codex-starter/.codex-plugin/plugin.json">Starter Plugin</a>
</p>

<p align="center">
  <img alt="skills" src="https://img.shields.io/badge/Codex-Skills-1f6feb?style=flat-square" />
  <img alt="plugins" src="https://img.shields.io/badge/Starter-Plugin_Template-ff8c42?style=flat-square" />
  <img alt="docs" src="https://img.shields.io/badge/Docs-Bilingual-2da44e?style=flat-square" />
</p>

# Codex Skills and Plugins

This repository is an open-source collection built around real Codex workflows, bringing together reusable skills, a starter plugin, and bilingual documentation in one place.

It is designed for people who want to use, adapt, or publish Codex workflow building blocks without starting from scratch. The project keeps the structure straightforward, the entry points visible, and the learning curve manageable for newcomers.

## Start With One Shelf

| If you want to... | Go here |
| --- | --- |
| Browse reusable skills | [`skills/`](./skills) |
| Read the document ingestion workflow | [`skills/document-ingestion-and-recovery`](./skills/document-ingestion-and-recovery) |
| Extract `.docx` with `markitdown` first | [`skills/markitdown-docx-extraction`](./skills/markitdown-docx-extraction) |
| Start from a publishable plugin skeleton | [`plugins/codex-starter`](./plugins/codex-starter) |
| See how repo-local plugins are listed | [`.agents/plugins/marketplace.json`](./.agents/plugins/marketplace.json) |
| Adapt or contribute to this repo | [`CONTRIBUTING.md`](./CONTRIBUTING.md) |

## What Lives Here

This repo keeps three kinds of building blocks together:

- Skills that solve a real workflow instead of acting as placeholders.
- A starter plugin that is small enough to understand and solid enough to publish from.
- Bilingual documentation so the repo stays approachable for both everyday use and first-time setup.

## Repository Layout

```text
.agents/plugins/   Marketplace metadata for repo-local plugins
assets/            Visual assets for the repository
plugins/           Starter and future Codex plugins
skills/            Reusable Codex skills
```

## Included Skills

### `document-ingestion-and-recovery`

- Starts with `markitdown` when the format supports it.
- Checks extraction quality before moving on.
- Falls back to OCR or lower-level recovery only when the simpler route is not enough.

### `markitdown-docx-extraction`

- A focused path for `.docx` extraction.
- Avoids jumping into ZIP/XML parsing too early.
- Encourages producing a readable Markdown sidecar before review or analysis work.

## Included Starter Plugin

### `plugins/codex-starter`

This starter is intentionally plain, but it already covers the parts that are annoying to rebuild every time:

- `.codex-plugin/plugin.json`
- Optional folders for `skills`, `scripts`, `hooks`, and `assets`
- Placeholder companion files for `.mcp.json` and `.app.json`
- A matching entry in the local marketplace manifest

It is meant to be copied, renamed, and shaped into a real plugin without needing to scaffold the same structure from scratch.

## Quick Setup

### Use the skills locally

Copy the folders under [`skills/`](./skills) into `$CODEX_HOME/skills` or `~/.codex/skills`.

### Use the starter plugin locally

Copy [`plugins/codex-starter`](./plugins/codex-starter) into a Codex plugin directory, then replace the placeholder metadata in [`plugin.json`](./plugins/codex-starter/.codex-plugin/plugin.json).

## If You Are New To Codex

- Start with the skills. They are the easiest entry point and show the working style of the repo.
- Move on to the starter plugin when you want to package your own workflow instead of only using local skills.
- If Chinese text looks garbled in a Windows terminal, check the file in a UTF-8 aware editor before assuming the file itself is broken.

## License

This repository is available under the [MIT License](./LICENSE).
