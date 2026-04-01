---
name: markitdown-docx-extraction
description: Use when Codex needs to extract or inspect content from a .docx document, especially before protocol review, requirements review, or any task where a readable Markdown copy is needed. Use when a DOCX should be converted safely with markitdown first instead of jumping to zip/XML parsing.
---

# Markitdown DOCX Extraction

## Overview

Prefer `markitdown` as the first extraction path for `.docx` files. Do not start with manual ZIP unpacking, OOXML parsing, or ad hoc XML scraping unless `markitdown` is unavailable or its output is clearly unusable.

## Workflow

1. Confirm the source file path and keep the original `.docx` untouched.
2. Check that `markitdown` is available with `Get-Command markitdown` or `python -m pip show markitdown`.
3. Convert the document with `markitdown <input.docx> > <output.md>` or `markitdown <input.docx> -o <output.md>`.
4. Read the generated Markdown and perform a quick acceptance check:
   - Output is non-empty.
   - Headings, examples, and key fields are readable.
   - No obvious truncation or severe encoding corruption is present.
5. Use the generated Markdown as the working source for review, comparison, or implementation checks.
6. Fall back to lower-level extraction only if `markitdown` is missing or the Markdown output fails the acceptance check.

## Commands

```powershell
markitdown "C:\path\spec.docx" > "C:\path\spec_extracted.md"
Get-Content "C:\path\spec_extracted.md"
```

## Fallback Rule

Only use ZIP or XML-level extraction after stating why `markitdown` could not be used or why its output was not acceptable. Treat low-level parsing as recovery work, not the default path.

## Common Mistakes

- Assuming a `.docx` must be unpacked manually because it is a ZIP container.
- Treating an empty or unreadable extraction as success without checking the generated Markdown.
- Overwriting the source document instead of writing a sibling Markdown file.
