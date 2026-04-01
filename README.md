# Codex Skills and Plugins

[简体中文](./README.zh-CN.md)

This repository packages reusable Codex skills and a placeholder area for future plugins.

## Included Skills

### `skills/document-ingestion-and-recovery`

- Use `markitdown` first for supported formats.
- Validate extraction quality by file type.
- Recover degraded output with OCR or lower-level fallback only when needed.

### `skills/markitdown-docx-extraction`

- Focused workflow for `.docx` extraction with `markitdown`.
- Prevents premature ZIP/XML parsing.

## Layout

```text
skills/   Reusable Codex skills
plugins/  Placeholder for future Codex plugins
```

## Usage

Copy the skill folders in this repository into `$CODEX_HOME/skills` or `~/.codex/skills`.

## Notes

- The `plugins/` directory is intentionally empty right now.
- The current repository focuses on document ingestion and extraction workflows.
