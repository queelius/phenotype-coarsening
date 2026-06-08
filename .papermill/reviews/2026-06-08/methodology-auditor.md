# Methodology Auditor: phenotype-coarsening (2026-06-08)

## Verdict: simulation design is sound, statistically careful (MCSE reported and reasoned-in), and every number in the manuscript matches the artifacts. The deployable-vs-oracle distinction is handled correctly. MIMIC-IV real-data application is honestly deferred (PhysioNet credentialing blocker).

## Reproducibility (re-verified this pass)

I loaded all three artifacts and cross-checked them against the section
sources of this build.

- results.rds (seed 20260521, matching the text) contains
  exp1_glass_ceiling, exp2_chart_review, exp3_code_freq,
  exp4a_informative_coding, exp4b_casemix_gap, one per validation
  subsection.
- exp1: pi_true 0.12, sens_true 0.776, spec_true 0.95, q_observed
  0.138, n_solutions 160, pi_range [0.06, 0.40], max_qcheck_dev
  2.78e-17. Matches the glass-ceiling subsection ("160 admissible
  triples", "within 3e-17", "0.06 to 0.40") exactly.
- exp2 (Table tab:chart): m = 50/100/200/500/1000/2000 with calibrated
  RMSE 0.0971/0.0389/0.0255/0.0144/0.0102/0.0073 and code-only RMSE
  ~0.0177 flat. Matches the table to the printed digits.
- exp3: resid_calibrated_median 0, max 2.78e-17; resid_wrongpi_median
  and max both 0. Matches "median 0 and maximum 3e-17" and the
  wrong-prevalence "median and maximum residual both 0."
- exp4b (Table tab:casemix): sens_gap 0.001/0.026/0.034/0.037/0.036,
  subsample-ref bias -0.0007/-0.0039/-0.0046/-0.0064/-0.0060, cohort-ref
  bias -0.0005/+0.0003/+0.0005/-0.0008/-0.0003. Matches the table.
- results_oracle_check.rds: cohort-oracle bias +0.0002 (sd 0.0172),
  biased-review subsample -0.0043 (sd 0.0162), weighted-deployable
  +0.0004 (sd 0.0173). Matches methodology.tex ("+0.0002 vs +0.0004 ...
  while the convenience subsample reference is biased (-0.0043)")
  exactly.

## Table tab:informative provenance (verified; a potential confusion resolved)

The "calibrated bias" column of Table tab:informative does NOT match the
bias_calibrated field of results.rds (which is the oracle-calibrated
variant: +0.0019, +0.0011, +0.0006, +0.0011, -0.0001, +0.0008). It
matches results_table4a_deployable.rds field cal_deploy_bias (+0.0030,
+0.0008, +0.0010, +0.0015, -0.0002, +0.0001) and cal_deploy_mcse
(0.0013, 0.0009, 0.0008, 0.0007, 0.0006, 0.0006) exactly. The caption
states this explicitly ("The calibrated column uses the deployable
weighted-by-P(Y|S) estimator"), so the table is sourced correctly. The
code-only bias column (-0.0161 ... +0.0322) matches both artifacts and
the prose. No discrepancy: the table draws from the deployable artifact
by design.

## Statistical rigor (a strength)

- Table tab:informative reports an MCSE column (sample SD / sqrt(200))
  and the text reasons in MCSE units. I checked the "within roughly two
  MCSEs of zero" claim for the deployable calibrated bias: the largest
  |bias/MCSE| is 0.0030/0.0013 = 2.3 at b1=0, the rest below 1.6. The
  "within roughly two MCSEs" wording is honest (one cell at 2.3). The
  code-only bias is many MCSEs from zero. This is the right way to make
  a near-unbiased claim.
- The glass-ceiling enumeration reports residuals to machine precision,
  the correct operationalization of T1 and T3 together.
- The chart-review study shows calibrated RMSE shrinking at ~m^{-1/2}
  while code-only RMSE stays flat (bias, not variance), the correct
  signature of T2.
- The T4 bound eq:meth-bound is itself validated numerically here (LHS
  below |b1|sigma/4 at every b1), so the analytic and simulation halves
  agree.

## Deployable-reference subtlety (handled correctly)

The "oracle-free reference" paragraph addresses a real trap:
marginalizing code sensitivity over {S : Y=1} in the full cohort uses
the latent label Y, unavailable at deployment. The fix (marginalize over
all observed severities weighted by an estimated P(Y=1|S) fit on the
adjudicated subsample) is sound, and the oracle-check confirms the
deployable estimator matches the oracle (+0.0004 vs +0.0002) while the
convenience-subsample reference is biased (-0.0043). The Table
tab:informative caption also reports that the oracle reference lands
within 0.003 of the deployable column at every b1. This is exactly the
kind of leakage a careless validation would hide; the paper catches and
neutralizes it.

## Case-mix-gap saturation (explained, not left anomalous)

exp4b shows the sens gap saturating near 0.036 for selection slopes
1.0 to 2.0. The paper explains this correctly: the per-case logistic is
bounded above by 1, so once severity-biased selection concentrates the
subsample at the top of the severity distribution the subsample-marginal
sensitivity approaches the logistic ceiling and the gap stops growing.
This addresses the prior round's I5.

## Minor methodology notes (carried)

1. Replicate count is 200 per cell throughout. For the small-m
   chart-review rows (m=50) the calibrated RMSE (0.097) is
   variance-dominated; 200 replicates is adequate and the MCSE is
   reported, but a referee may ask for more at the noisiest cells.
   MINOR.
2. The single-binary-code focus is a modeling simplification; the
   multi-code consistency claim is asserted ("we omit the algebra")
   rather than shown. Disclosed in both the proof and the limitations,
   but a referee may want the explicit one-paragraph argument. MINOR
   (shared with logic-checker).
3. MIMIC-IV: the plan is detailed and preregistered in spirit (AKI with
   KDIGO stage >= 1 as chart-proxy, stratified subsample to estimate the
   case-mix gap), but not executed; credentialing is the blocker. The
   paper is explicit that "the simulation is the core validation for the
   present version." Honest for the scaffold stage; a known gap, not a
   defect.

## Confidence: HIGH

All three results files loaded and cross-checked against the text this
pass; the Table tab:informative provenance question resolved; the T4
bound and Rogan-Gladen recovery independently reproduced in base R.
