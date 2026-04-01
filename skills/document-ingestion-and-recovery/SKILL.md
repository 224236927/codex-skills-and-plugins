---
name: document-ingestion-and-recovery
description: Use when Codex needs to read, extract, or recover content from reference documents such as docx, pdf, xlsx, txt, md, html, csv, or image files. Use when document text may be missing, garbled, scanned, layout-dependent, or otherwise unreliable and a format-specific extraction path with fallback recovery is needed.
---

# Document Ingestion and Recovery

## Overview

Use `markitdown` first for formats it supports, then validate the result according to the file type in front of you. Do not confuse "the converter ran" with "the extraction is trustworthy."

## Core Workflow

1. Identify the file type from extension and actual content when needed.
2. Preserve the source file and write extracted content to a sibling `.md` or `.txt` file.
3. Check whether `markitdown` supports the format in front of you.
4. If `markitdown` supports the format, use it as the first extraction pass.
5. If `markitdown` does not support the format, use the format's preferred extractor instead.
6. Run a quick acceptance check:
   - Output is non-empty.
   - Key headings, examples, tables, or fields are present.
   - Text is readable and not dominated by replacement glyphs, mojibake, or broken layout.
7. Apply the file-type-specific checks from the routing reference before trusting the result.
8. If the acceptance check fails, switch to the format's fallback recovery path.
9. In downstream analysis, state whether the working text came from direct extraction or recovery.

## Format Routing

Read [format-routing.md](C:\Users\Mine\.codex\skills\document-ingestion-and-recovery\references\format-routing.md) and follow the route for the file type in front of you.

## DOCX First-Pass Rules

For `.docx` files, treat `markitdown` as the default first extractor unless it is unavailable or clearly unusable.

1. Keep the original `.docx` untouched.
2. Check that `markitdown` is available with `Get-Command markitdown` or `python -m pip show markitdown`.
3. Convert to a sibling Markdown file such as `<input>.extracted.md` using `markitdown <input.docx> -o <output.md>` or shell redirection.
4. Read the generated Markdown before trusting it.
5. Only use the Markdown as the working source if it passes the acceptance checks below.
6. If `markitdown` is missing or the Markdown fails acceptance, switch to the fallback recovery path and say why.

### DOCX Acceptance Checks

- Output is non-empty.
- Headings, examples, and key fields are present.
- Mixed Chinese and English text remains readable.
- There is no obvious truncation or severe encoding corruption.

### DOCX Fallback Boundary

- Do not start with ZIP, OOXML, or ad hoc XML parsing for a normal `.docx`.
- Only use low-level DOCX inspection after stating why `markitdown` could not be used or why its output was not trustworthy.

## Recovery Rules

- For any format that `markitdown` supports, prefer `markitdown` as the required first pass.
- Prefer structured extraction over OCR when the source format supports it cleanly.
- Prefer OCR over ad hoc low-level parsing when the visible rendering is correct but extracted text is garbled.
- Treat manual ZIP/XML parsing as a last-resort recovery path, not a default workflow.
- If a document is multi-page or layout-sensitive, keep page boundaries and section order explicit in the recovered output.

## Quick Checks For Bad Extraction

- Repeated `�`, `��`, or obviously garbled Chinese text.
- Empty output from a non-empty source document.
- Tables flattened into unreadable text when table structure is important.
- Missing example blocks, field definitions, or section titles visible in the source.

## Common Mistakes

- Assuming `markitdown` success means the extracted text is automatically correct.
- Using one tool for every file format without format-specific checks.
- Trusting the first extraction result without a readability check.
- Replacing the original source file instead of creating a sidecar text file.
- Using OCR first on structured files like CSV or clean XLSX.
