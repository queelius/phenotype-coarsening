# Format Validator: phenotype-coarsening (2026-06-08)

## Verdict: clean build, all references and labels resolve, formatting internally consistent. One venue-fit item (abstract word count, page length for JAMIA) carries.

## Build

- `make paper` succeeds (exit 0). Recipe runs the full pdflatex; bibtex;
  pdflatex; pdflatex sequence.
- main.log: LC_ALL=C grep -ai undefined returns 0 lines (both raw and
  after excluding any "Font shape ... undefined" lines; none of the
  latter are present either). Zero undefined references, zero undefined
  citations.
- No citation/reference/label/multiply-defined warnings in main.log.
- Document class: article, 11pt, letterpaper, 1in margins. Standard
  amsmath / amsthm / mathtools / bm / booktabs / cleveref / natbib
  (plainnat) / hyperref / microtype stack; loads cleanly.
- PDF page count: 23 pages including references (pdfinfo).

## Labels and cross-references

- cleveref used throughout and all targets resolve: thm:glass-ceiling,
  thm:identifiability-chart, thm:code-total, thm:bias-informative,
  cor:casemix, thm:bg-id, cond:c1/c2/c3, eq:code-freq, eq:admissible,
  eq:glass-sens, eq:deconvolve, eq:code-total, eq:meth-sens,
  eq:meth-rho, eq:meth-codebias, eq:meth-codebias2, eq:meth-bound,
  eq:meth-residual, tab:translation, tab:chart, tab:informative,
  tab:casemix, fig:glass, fig:informative, plus the section labels. No
  dangling labels in the log.
- Theorem environments use a SHARED counter ([theorem]) so
  theorem/proposition/lemma/corollary/definition/condition/remark
  interleave; condition has its own counter via \newtheorem{condition}.
  Internally consistent; \cref renders the correct shared numbers. No
  collisions.

## Figures and tables

- figures/glass_ceiling.pdf and figures/informative_coding.pdf present;
  \graphicspath{{figures/}} resolves them; both \includegraphics succeed.
- Four booktabs tables (translation, chart, informative, casemix) render
  and are referenced. Numeric content matches the validation prose and
  the simulation artifacts (cross-checked tab:chart, tab:informative,
  tab:casemix against results.rds and results_table4a_deployable.rds).

## Venue formatting (carried)

- Generic article form. The structured abstract already matches JAMIA
  conventions, but it runs about 278 words against JAMIA's ~250-word
  structured-abstract limit, and the document is 23 pages, long for a
  JAMIA research article (~5000 words) and slightly over the stated
  ~12-page conference target. Neither is a build defect; both are
  venue-fit items for the camera-ready (abstract trim; conference
  compression). Consistent with the venue_strategy in state.md (AMIA
  full-paper length is the closer interim fit).

## Hook constraints

- No U+2014 em-dashes in section sources, main.tex, or refs.bib. No
  vanity counts (numeric figures are simulation-design facts).
  Compliant.

## Confidence: HIGH
