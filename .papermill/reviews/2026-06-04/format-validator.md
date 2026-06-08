# Format Validator: phenotype-coarsening

## Verdict: clean build, all references resolve, formatting consistent.

## Build
- `make paper` artifact main.pdf present and current. main.log shows zero undefined references and zero undefined citations (grep count 0 for both). No substantive rerun warnings.
- Document class: article, 11pt, letterpaper, 1in margins. Standard amsmath/amsthm/mathtools/cleveref/natbib(plainnat)/hyperref stack; loads.
- PDF page count: confirmed via pdfinfo (~21 pages incl. references, consistent with the stated ~21-page draft).

## Labels and cross-references
- cleveref used throughout and resolves: thm:glass-ceiling, thm:identifiability-chart, thm:code-total, thm:bias-informative, cor:casemix, thm:bg-id, cond:c1/c2/c3, eq:code-freq, eq:admissible, eq:glass-sens, eq:deconvolve, eq:code-total, eq:meth-bound, eq:meth-residual, tab:translation, tab:chart, tab:informative, tab:casemix, fig:glass, fig:informative. All defined and referenced; no dangling labels in the log.
- Theorem environments use a SHARED counter ([theorem]) so theorem/proposition/lemma/corollary/definition/remark interleave in one sequence. This differs from the DP sibling's independent-counter scheme but is internally consistent and standard; cross-references via \cref render the correct shared numbers. No collisions.

## Figures and tables
- figures/glass_ceiling.pdf and figures/informative_coding.pdf present; \graphicspath{{figures/}} resolves them.
- Four booktabs tables (translation, chart, informative, casemix) render and are referenced. Numeric content matches the validation prose (spot-checked tab:informative rho/bias columns against the text).

## Venue formatting
- Generic article form. The structured abstract already matches JAMIA conventions. A JAMIA/AMIA camera-ready would need the venue template and word-count trimming (the draft is long for a JAMIA research article at ~5000 words; AMIA full-paper length is closer). Not a defect at scaffold stage; noted as a venue-fit consideration.

## Hook constraints
- No U+2014 em-dashes in section sources. No vanity counts (numeric figures are simulation-design facts). Compliant.

## Confidence: HIGH.
