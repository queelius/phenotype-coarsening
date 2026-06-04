# Prose auditor

## Method

Read all sections; checked narrative arc, notation consistency, abstract structure, and JAMIA stylistic fit. Compared abstract length against the JAMIA 250-word limit.

## Findings

### CRITICAL: abstract exceeds JAMIA 250-word limit (311 words)

Location: main.tex lines 67 to 106.

The abstract is 311 words; JAMIA's structured abstract limit is 250 words. The current abstract is also unstructured (no Objective / Materials and Methods / Results / Discussion / Conclusion headings), which JAMIA usually requires for research articles.

Two paths:
1. Compress to 250 words and add structured-abstract headings (Objective, Materials and Methods, Results, Discussion, Conclusion). This is the JAMIA-conformant path.
2. Submit to a venue with looser abstract requirements first (CHIL, ML4H, Biometrics).

Suggested fix for path 1: a 250-word structured abstract draft:

```
Objective: To formalize identifiability conditions for electronic
phenotyping when diagnosis codes are informative of latent severity.

Materials and Methods: We embed code-based phenotyping in the
coarsening-at-random framework: the true clinical state is the latent
cause, the code set is the candidate set, the coding process is the
masking mechanism, and a chart-reviewed patient is a singleton
candidate set. We characterize the failure of the non-informative
masking condition (C2) when sicker patients are coded more.

Results: We prove four results. A glass-ceiling theorem shows
(prevalence, sensitivity, specificity) is jointly non-identifiable
from code data alone. An identifiability theorem shows a chart-reviewed
subsample covering both classes identifies the coding model. A
code-frequency consistency theorem shows that the fitted model
reproduces the empirical code frequency exactly at any interior MLE,
so marginal-fit diagnostics are blind to prevalence bias. A bias bound
shows the code-only estimator's bias is controlled by the severity-coding
correlation, and the chart-review-calibrated estimator's residual bias
is controlled by the case-mix gap. Simulation confirms all four results;
the bias sign can flip depending on whether sensitivity deficit or
false-positive inflation dominates.

Discussion: The framework places latent-class phenotyping (Hui-Walter,
Dawid-Skene) inside a unified coarsening vocabulary that names the
failing assumption (C2: non-informative coding) and quantifies the bias.

Conclusion: Chart review is a necessity rather than a luxury; its
identifying value is bounded by case-mix representativeness.
```

This is approximately 250 words. Adjust as needed.

### CRITICAL: bias-sign framing in abstract is buried; should be the headline

Location: main.tex abstract lines 86 to 99.

The four-result list in the abstract treats the bias-sign-change finding as a sub-clause of T4. The simulation shows the bias goes from -0.016 to +0.032 as $b_1$ varies. This is the load-bearing surprise: prevalence under-/over-estimation depends on the contest. The abstract should foreground this, since "naive code counts can over OR under-estimate prevalence depending on coding behavior" is the take-home for a clinician.

Suggested fix: add to the abstract a single sentence after T4's introduction: "The sign of the bias is not predetermined; depending on coding behavior, code-only prevalence can understate, overstate, or cross zero." This makes the contribution memorable.

### MAJOR: conclusion section is a recap rather than a synthesis

Location: sections/conclusion.tex (all 42 lines).

The conclusion repeats the four theorems verbatim. State file P2 flagged this. A 2026 methodology paper should use the conclusion to synthesize the broader implication, not re-list the theorems. The discussion's "broader implications" subsection (discussion.tex line 107 to 127) is actually the natural conclusion.

Suggested fix: move discussion.tex line 107 to 127 ("Broader implications") into conclusion.tex and replace the current conclusion. The new conclusion would say something like: code-based phenotyping has been refined methodologically but its bias structure has not been classified. The masked-data framework gives the classification (C1, C2, C3) and the remedy (singleton candidate sets). The same structure recurs across health-data measurement problems. The contribution is positioning the existing literature within a unified vocabulary.

### MAJOR: "this paper, full version" self-citation is awkward

Location: refs.bib (towell2026phenotypecoarsening entry); references in identifiability.tex line 63 and line 173.

Quoted bib entry:
> "title = {Electronic phenotyping as coarsening at random: identifiability of clinical states from diagnosis codes (this paper, full version)}"

The paper cites itself as "the full version" in the proofs of T1 and T3. This is awkward at best and may not survive editorial scrutiny. JAMIA reviewers will be confused.

Suggested fix: drop the "full version" framing entirely. The single-code result is what this paper proves; the multi-code extension is future work. Remove the self-citations in T1 proof line 63 and T3 proof line 173 (about 2 sentences total). The proofs are stronger without the dangling future-work promise.

### MAJOR: notation overlap between $S$ as severity and $S$ as sensitivity

Location: throughout.

The paper uses $S$ for latent severity and "sens" (typeset as $\mathrm{sens}$) for code sensitivity. The macro $\mathrm{sens}$ disambiguates well, but the prose occasionally refers to "sensitivity" alongside "severity" in the same sentence and reading is harder than it should be.

Suggested fix: in methodology.tex around line 18 and 36, use bolded labels or italics consistently to keep the reader's attention on which quantity is which. Cosmetic.

### MAJOR: introduction "contributions" list is bulky

Location: sections/introduction.tex line 88 to 130.

The contributions list has 6 bullets that span 42 lines. The introduction would read better with a 4-bullet list matching the four theorems plus a single sentence on the framework contribution and the simulation.

Suggested fix: compress the contributions list to 4 bullets matching the theorems. Move the "translation table" and "simulation validation" to a single closing sentence: "These are validated by simulation with a MIMIC-IV application outlined as future work."

### MINOR: section title "Identifiability and code-frequency consistency"

Location: identifiability.tex line 1.

Section title runs together two semantically distinct concepts. JAMIA prefers short, descriptive section titles. Consider splitting into "Identifiability" and "Code-frequency consistency" subsections under a parent "Theoretical results" section, or simply rename to "Identifiability of cohort prevalence".

### MINOR: discussion has a long "what is new here" paragraph

Location: discussion.tex line 52 to 69.

The paragraph is 18 lines of dense single-paragraph prose listing four contributions. A reader scanning the discussion will skip it. Break into four shorter bullet-style sub-paragraphs (one per contribution), each 2 to 3 sentences. Improves readability.

### MINOR: equation labels could be shorter

Equations like `eq:meth-codebias`, `eq:meth-codebias2`, `eq:meth-residual` could be `eq:bias`, `eq:bias-exp`, `eq:residual`. JAMIA copy-editors may renumber, so internal labels matter less. Cosmetic.

### MINOR: figures referenced without colon convention consistency

The figure caption (validation.tex line 49 to 56) uses "(A) ... (B) ..." style. Good. The figure is referenced as `\Cref{fig:glass}A` and `\Cref{fig:glass}B`. The capital `\Cref` plus the subpanel letter may not produce the expected output (cleveref renders "Figure 1" then "A" follows). Verify the PDF output reads "Figure 1A" rather than "Fig. 1 A". Minor.

## Cross-verification notes

- Em-dash check: no em-dashes (U+2014) in any section file or main.tex. The 2026-05-22 review pass result holds. Conforms to project conventions.
- Sibling cross-references (scrna, spatial, dp, weaksup) are present in introduction (line 56), discussion (line 132 to 140). Good.
- Reading flow: the paper reads cleanly from introduction through validation. The discussion is the weakest section; the conclusion is the weakest in proportion to its position. Both deserve a rewrite pass.
