# Format Routing

## Default Rule

If `markitdown` supports the format, use it first. Then decide whether the output is trustworthy by applying the format-specific checks below.

## DOCX

- First pass: `markitdown`
- Trust the output when headings, examples, and mixed Chinese/English text remain readable.
- Fall back when the result is empty, heavily garbled, or visibly loses important structure.
- Preferred fallback: rendered PDF or page screenshots plus OCR or visual recovery.
- Last resort: low-level ZIP/XML inspection.

## PDF

- First pass: `markitdown`
- Trust the output when paragraph order, headings, and tables remain usable.
- Fall back when the PDF is scanned, the text comes out empty, or layout order is broken.
- Preferred fallback: page-level OCR.

## XLSX / XLS

- First pass: `markitdown`
- Extra checks:
  - Sheet names are preserved.
  - Headers are readable.
  - Rows and columns are not obviously shifted.
- Fall back when sheet structure, merged-cell meaning, or table layout is critical and the markdown flattening loses too much information.
- Preferred fallback: structured spreadsheet reading or OCR only for image-like sheets.

## CSV

- First pass: `markitdown`
- Extra checks:
  - Delimiter handling is correct.
  - Header row is intact.
  - Column counts are consistent.
- Fall back when encoding or delimiter parsing is broken.

## TXT

- First pass: `markitdown`
- Extra checks:
  - Encoding is correct.
  - No mojibake from UTF-8, GBK, or UTF-16 mismatch.
- Fall back by re-reading with alternate encodings.

## MD

- First pass: `markitdown`
- Extra checks:
  - Headings, code blocks, and tables remain intact.
- Usually no recovery is needed unless the file encoding is wrong.

## HTML

- First pass: `markitdown`
- Trust the output when headings, lists, tables, and main body text are preserved.
- Fall back when the page depends on rendering or script-generated content.
- Preferred fallback: rendered-page capture plus OCR or DOM-aware extraction.

## Images

- First pass: OCR or visual recognition.
- Extra checks:
  - Text order matches the layout.
  - Tables or multi-column regions are reconstructed clearly enough for the task.
- Fall back by manually segmenting the image into smaller regions if needed.
