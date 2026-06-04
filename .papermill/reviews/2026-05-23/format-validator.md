# Format validator

## Method

Built the paper (verified prior build output); checked for label resolution; counted pages; tested JAMIA conformance markers (margins, font, abstract length, references); checked figures and tables.

## Findings

### CRITICAL: page count not aligned with conference target

The PDF builds to 20 pages. main.tex header comment says "Conference-format draft (target: 12 pages incl. references)". The state file P4 flagged "12-page conference compression" as deferred.

For JAMIA: research articles are ~5000 words plus figures/tables/references; 20 pages with current word count of around 8000 words plus front matter is at the long end but acceptable.

For AMIA Annual Symposium: full paper format is around 10 pages; current 20 pages would need significant compression.

For CHIL / ML4H workshop: typical formats allow 8 to 15 pages.

Suggested fix: keep current length for JAMIA submission; defer conference compression. If submitting to AMIA first (state file's plan B), compress before submission. Compression candidates:
- background.tex (83 lines): could be 40 lines.
- translation.tex existing-methods paragraphs: could collapse.
- proofs in identifiability.tex: are necessary for the contribution.
- discussion.tex: dense, could be tightened.

### CRITICAL: abstract is 311 words; JAMIA limit is 250

See prose-auditor for the suggested 250-word structured abstract draft. Format-wise, JAMIA requires headings (Objective, Materials and Methods, Results, Discussion, Conclusion). Current abstract is unstructured.

### MAJOR: hyperref Token warnings

Build log shows 4 warnings:
> Package hyperref Warning: Token not allowed in a PDF string (Unicode):
>   removing `\new@ifnextchar' on input line 26 / 59 / 104 / 123.

These occur in the bookmark/title strings, probably from `\cref` or `\Cref` in chapter/section headings. State file I7 flagged this as cosmetic / deferred. They do not affect the PDF body content; only the PDF bookmarks. For JAMIA submission these are acceptable.

Suggested fix (deferred): wrap problematic strings in `\texorpdfstring{...}{...}`. Cosmetic.

### MAJOR: no Title, Author, Keywords metadata in PDF

`pdfinfo main.pdf` reports:
```
Title:           
Subject:         
Keywords:        
Author:          
```

JAMIA submission portals often extract metadata from the PDF. Set these via hyperref:
```
\hypersetup{
  pdftitle={Electronic phenotyping as coarsening at random},
  pdfauthor={Alexander Towell},
  pdfsubject={Identifiability of clinical states from diagnosis codes},
  pdfkeywords={electronic phenotyping, coarsening at random, identifiability, masked data, EHR}
}
```

### MAJOR: figures are not labeled with subfigure references properly

`\Cref{fig:glass}A` and `\Cref{fig:glass}B` rely on the caption text "(A)" and "(B)". This is OK but cleveref would prefer the subcaption package for proper subfigure references. JAMIA copy-editors may flag this. Cosmetic.

### MINOR: bibliography style

`\bibliographystyle{plainnat}` is fine for arXiv but JAMIA uses Vancouver style (numbered references). The submission will require re-styling. Not a content issue; flag for submission preparation.

### MINOR: no line numbers

JAMIA submission may require line numbers for reviewer reference. Add `\usepackage{lineno}` and `\linenumbers` after `\begin{document}` before submission.

### MINOR: orcidlink missing

The ORCID is currently a `\href` to orcid.org. JAMIA accepts this. Consider the `orcidlink` package for a proper ORCID-marked link with the official icon. Cosmetic.

### MINOR: section labels

All section labels (sec:intro, sec:background, ..., sec:conclusion) are defined and referenced. Build log shows no undefined cross-references. Good.

### Build verification

```
Output written on main.pdf (20 pages, 334864 bytes).
```

Build succeeds. No undefined references. No bad boxes (no Overfull/Underfull warnings in log). Em-dash free (verified).

### Theorem environment consistency

All theorems use the AMS `\newtheorem{theorem}{Theorem}` environment with `[theorem]` counter for prop, lemma, corollary, definition, remark. Crefname/Crefname defined for `condition`. Consistent. Good.

## JAMIA-specific recommendations

To prepare for JAMIA submission:

1. Compress abstract to 250 words; add structured abstract headings.
2. Set PDF metadata via hypersetup.
3. Add line numbers (\linenumbers).
4. Re-style bibliography to Vancouver (or whatever JAMIA's current style is; check the JAMIA author instructions).
5. The 20-page length is within range; no compression required.
6. Add Rogan-Gladen 1978, Begg-Greenes 1983, Hubbard 2020 to refs.bib (see citation-verifier).
7. Address the T4 proof Jensen step (see logic-checker).
8. Complete MIMIC-IV application before JAMIA submission (see methodology-auditor).
