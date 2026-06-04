# Methodology auditor

## Method

Read sim.R, run.R, validation.tex; cross-checked simulation parameters against reported numbers; reviewed claim-evidence linkage for each of the four theorems.

## Findings

### MAJOR: simulation has no real-data validation; MIMIC-IV section is a plan, not an analysis

Location: validation.tex lines 241 to 265.

Quoted text:
> "This real-data application is described here and left as the principal pending item; the simulation is the core validation for the present version."

The paper acknowledges this honestly. The honesty is good. However, JAMIA reviewers will discount a methodology paper with no real-data validation, especially when the methodology centers on a real-data phenomenon (EHR coding). The current "plan" section is one paragraph (lines 252 to 264) describing a hypothetical AKI analysis. This is too thin to publish in JAMIA.

Recommended path: do not submit to JAMIA without the MIMIC-IV application. Either:
- submit to AMIA Annual Symposium (rank 2) first as a methods paper with simulation only and the MIMIC-IV plan as future work,
- or delay JAMIA submission until MIMIC-IV is in place.

The state file notes JAMIA submission is gated on MIMIC-IV; the document agrees.

### MAJOR: simulation seed and replicate count adequate but only one seed

Location: scripts/run.R line 28 (set.seed(20260521)).

Single seed, 200 replicates per cell. This is adequate for the main bias / RMSE claims (Monte Carlo SE around 0.001 to 0.002 at this replicate count). For methodology paper standards, repeating across 3 to 5 seeds would strengthen reproducibility. Not strictly necessary; the simulation results are interpreted qualitatively (signs and trends), which are robust.

Suggested fix: in validation.tex around line 6, state "Monte Carlo standard errors at 200 replicates are below 0.002 for all reported quantities; running across additional seeds (10000 to 99999, increments of 7) leaves all sign conclusions unchanged" or similar, if true.

### MAJOR: severity distribution choice is arbitrary

Location: scripts/sim.R line 50-51; validation.tex line 12-13.

The DGP draws severity $S | Y$ Normal with $\mu_{S,0} = 0$ and $\mu_{S,1} = 1.5$, sd 1. This is one specific severity gap. The size of the bias bound depends on $\sigma_S$ and on the case-mix gap $\delta$, which both scale with this choice. The paper does not vary the severity gap to test robustness of the bias-bound calibration.

Recommended: add a brief sensitivity sub-experiment varying $\mu_{S,1}$ over say $\{0.5, 1.0, 1.5, 2.0\}$ and reporting that the qualitative conclusions hold. One additional table or paragraph.

### MAJOR: case-mix-gap study uses a hand-chosen selection mechanism

Location: scripts/sim.R lines 161-164 (biased_review_idx).

The biased review selects with probability proportional to $\mathrm{logit}^{-1}(\mathrm{bias} \cdot S)$. This is one specific selection mechanism. Real chart review is triggered by encounters or codes, not by latent severity directly. The simulation conflates severity-triggered review (rare) with encounter-triggered review (common). Realistic selection would use C or a code-count proxy, not S.

Suggested fix: add a second selection mechanism (probability proportional to code presence or to a per-patient encounter count) to show the case-mix gap is robust to the selection rule.

### MAJOR: code-only estimator interpretation

Location: validation.tex line 75-78; methodology.tex line 38-39.

Quoted text:
> "The code-only estimator, by contrast, has RMSE essentially constant near $0.0177$"

This is correct in the sim (study 2). But the "RMSE = bias = constant near 0.0177" interpretation in the prose conflates root-MSE with bias. At n=20000, the Monte Carlo SE of the code-only estimator's mean across 200 replicates is roughly $\sqrt{(0.137 \cdot 0.863) / 20000} \approx 0.0024$, so the bias is around 0.0177 with MC SE 0.0024 on the mean. The RMSE includes both bias and across-replicate sampling variation. The phrase "its error is bias, not sampling noise" is correct in the n -> infinity limit but is slightly imprecise at finite n.

Suggested fix: in validation.tex line 75-78, state "the code-only RMSE is dominated by bias (constant near 0.018) rather than by sampling error".

### MAJOR: only one prevalence is studied

All simulations use $\pi = 0.12$. The framework results should hold across prevalence, but the bias bound formula is linear in $\pi$. Vary $\pi$ across say $\{0.05, 0.10, 0.20, 0.50\}$ in a single short table to demonstrate the scaling. A simple ablation would strengthen the bias-bound interpretation.

### MINOR: deconvolution is clamped to [0, 1] silently

Location: scripts/sim.R line 89.

`min(max(pi_hat, 0), 1)` clamps deconvolution output to the unit interval. This is reasonable but the paper does not mention clamping. A clamped estimator is biased on the boundary; if any replicates clamp, this could matter. Likely no replicates clamp at the studied parameter values, but the paper should state the behavior.

Suggested fix: add a sentence to validation.tex noting "across all replicates the deconvolved prevalence estimate fell strictly in $(0, 1)$; no clamping was triggered".

### MINOR: simulation does not test the multi-code extension claim

T3 proof and T1 proof both promise multi-code extensions in "this paper, full version" (a citation to itself). The simulation uses only single-code data. The single-code restriction is honest, but the cited future-version reference creates an expectation. The paper should either drop the multi-code reference or add a short multi-code simulation (eg combining code + procedure code with their own sens/spec).

Suggested fix: drop the multi-code-promise text in T1 proof (line 60-63) and T3 proof (line 173). The single-code result is sufficient for the paper's claims; the multi-code extension can stay as "left for future work" in discussion.

### MINOR: reproducibility instructions

The paper says "All results are reproducible from scripts/run.R (seed 20260521)" (validation.tex line 6). Verified: the simulation runs and produces matching outputs. Good. Suggest adding a Makefile target "make sim" that runs run.R, since the existing Makefile only builds the PDF. Minor convenience.

### MINOR: figure quality

`figures/glass_ceiling.pdf` and `figures/informative_coding.pdf` exist. The state file P3 flagged "enlarge red marker in glass-ceiling figure" as deferred. Worth addressing before JAMIA submission.

## Cross-verification notes

- All numerical values in validation.tex tables and prose match the simulation output exactly (verified by reading results.rds).
- The code-frequency residual at machine precision (3e-17 max) is reproduced.
- The case-mix gap of 0.036 saturation in study 4b is reproduced and is explained in the paper (validation.tex line 198 to 207). Good fix from prior review pass.
