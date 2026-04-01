# Codex Skills and Plugins

This repository packages reusable Codex skills and a placeholder area for future plugins.

## Included Skills

- `skills/document-ingestion-and-recovery`
  - Use `markitdown` first for supported formats.
  - Validate extraction quality by file type.
  - Recover degraded output with OCR or lower-level fallback only when needed.

- `skills/markitdown-docx-extraction`
  - Focused workflow for `.docx` extraction with `markitdown`.
  - Prevents premature ZIP/XML parsing.

## Layout

```text
skills/   Reusable Codex skills
plugins/  Placeholder for future Codex plugins
```

## Notes

- Skills in this repository were created for local Codex usage and can be copied into `$CODEX_HOME/skills` or `~/.codex/skills`.
- The `plugins/` directory is intentionally empty right now.
