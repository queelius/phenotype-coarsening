# Prose Auditor: phenotype-coarsening

## Verdict: clearly written, well-structured for a methodology venue; structured abstract is appropriate; a few minor nits.

The manuscript reads cleanly for a mixed informatics/biostatistics audience. The structured abstract (Objective / Materials and Methods / Results / Discussion / Conclusion) matches JAMIA conventions, which is the right call given the rank-1 target venue. The translation table and the "Existing phenotyping methods in this language" subsection are pedagogically effective: they recast PheKB rules, PheWAS, anchor-and-learn, and latent-class phenotyping each as a candidate-set statement, which makes the unification concrete rather than abstract.

## Strengths
- The central message is stated once and reinforced without bloat: informative coding = C2 failure; chart review = singleton candidate set; Rogan-Gladen = the deconvolution; marginal-fit blindness = the identifiability cost; case-mix gap = the limit.
- The sign-of-the-bias discussion is unusually careful prose: it walks the reader through the contest between sensitivity deficit and false-positive inflation and explicitly warns that the bias direction "is not a useful heuristic on its own."
- The rho non-monotonicity is explained in plain language (the logistic saturates and loosens the linear association), preempting a natural reader confusion.
- Notation (pi, sens, spec, S, b0, b1, Y, C, q/Cbar, delta) is consistent across sections.

## Nits (minor)
1. Two distinct symbols for the code frequency: the identifiability section uses q := P(C=1) (eq:code-freq) while the methodology and validation use Cbar / qbar for the empirical version and q for the population version. The relationship (Cbar estimates q) is clear from context, but a one-line "we write q for the population code frequency and Cbar for its empirical counterpart" near eq:code-freq would remove any ambiguity. Cosmetic.
2. discussion.tex uses sens_coh in cor:casemix's denominator while the corollary statement writes "sens_coh + spec - 1"; consistent, but the methodology setup earlier sometimes writes just "sens" for the cohort marginal. Standardize on sens_coh wherever the cohort marginal is meant. Cosmetic.
3. The "deployable reference, not an oracle" paragraph is dense and arrives late in methodology.tex; consider a forward pointer to it from the chart-review theorem so a reader who worries about the latent-label leakage is reassured at the point the worry arises. Cosmetic / readability.
4. validation.tex line on marginal sensitivity "rises from 0.500 at b1=0 toward (but not reaching) 0.902 at b1=3" reuses the b1 sweep description twice (once for the gap saturation, once for the sensitivity); minor redundancy. Cosmetic.

## Hook-constraint compliance
No em-dashes detected in the section sources; the prose uses commas/colons/parentheses. No vanity counts (the "160 admissible triples" and "200 replicates" are simulation-design facts, not achievement filler). Compliant.

## Confidence: HIGH.
