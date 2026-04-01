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
3. If `markitdown` supports the format, use it as the first extraction pass.
4. If `markitdown` is not appropriate for that format, use the format's preferred extractor instead.
4. Run a quick acceptance check:
   - Output is non-empty.
   - Key headings, examples, tables, or fields are present.
   - Text is readable and not dominated by replacement glyphs, mojibake, or broken layout.
5. Apply the file-type-specific checks from the routing reference before trusting the result.
6. If the acceptance check fails, switch to the format's fallback recovery path.
7. In downstream analysis, state whether the working text came from direct extraction or recovery.

## Format Routing

Read [format-routing.md](C:\Users\Mine\.codex\skills\document-ingestion-and-recovery\references\format-routing.md) and follow the route for the file type in front of you.

## Recovery Rules

- Prefer `markitdown` as the default first pass for supported formats.
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
