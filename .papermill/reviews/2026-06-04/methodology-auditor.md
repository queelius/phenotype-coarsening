# Methodology Auditor: phenotype-coarsening

## Verdict: simulation design is sound, statistically careful (MCSE reported), and matches the theory; the deployable-vs-oracle distinction is handled well. MIMIC-IV real-data application is honestly deferred.

## Reproducibility
- All four simulation studies driven by scripts/run.R (seed 20260521); results.rds loads and contains exp1_glass_ceiling, exp2_chart_review, exp3_code_freq, exp4a_informative_coding, exp4b_casemix_gap, matching the four validation subsections. Separate results_oracle_check.rds and results_table4a_deployable.rds support the deployable-reference analysis.
- I loaded results_oracle_check.rds directly: cohort-oracle bias +0.0002 (sd 0.0172), biased-review subsample bias -0.0043 (sd 0.0162), weighted-deployable bias +0.0004 (sd 0.0173). These match the methodology.tex claims ("+0.0002 vs +0.0004 ... while the convenience subsample reference is biased (-0.0043)") exactly. Good: the numbers in the text are the numbers in the artifact.

## Statistical rigor (a strength here)
- Table 4 (informative coding) reports an MCSE column (sample SD across 200 replicates / sqrt(200)) and the text explicitly reasons in MCSE units: "the code-only bias is ... many MCSEs from zero at every b1; the deployable calibrated estimator's bias sits within roughly two MCSEs of zero." This is the right way to make a "near-unbiased" claim and is more rigorous than the DP sibling, which omits MCSE.
- The glass-ceiling enumeration reports residuals to machine precision (3e-17) confirming every triple on the surface reproduces Cbar, which is the correct operationalization of T1 + T3 together.
- Chart-review study shows the calibrated RMSE shrinking at m^{-1/2} while the code-only RMSE stays flat (bias, not variance), the correct signature of T2.

## The deployable-reference subtlety (handled correctly)
The "A deployable reference, not an oracle" paragraph addresses a real trap: marginalizing code sensitivity over {S : Y=1} in the full cohort uses the latent label Y, which is unavailable at deployment. The fix (marginalize over all observed severities weighted by an estimated P(Y=1 | S) fit on the adjudicated subsample) is sound, and the oracle-check simulation confirms the deployable estimator matches the oracle (bias +0.0004 vs +0.0002). This is exactly the kind of leakage that a careless validation would hide; the paper catches and neutralizes it, and reports the result in the Table 4 caption. Strong.

## Case-mix-gap study
exp4b confirms cor:casemix: subsample-reference bias grows in magnitude with the sensitivity gap (-0.0007 at gap 0.001 to -0.006 at gap 0.036), cohort-reference bias stays within +/-0.001. The saturation of the gap near 0.036 (because the per-case logistic is bounded above by 1) is correctly explained rather than left as an anomaly.

## Minor methodology notes
1. Replicate count is 200 per cell throughout. For the small-m chart-review rows (m=50), the calibrated RMSE (0.097) is variance-dominated and the bias estimate (+0.0129) is within a couple MCSE of the larger-m values; 200 replicates is adequate but a referee may ask for more at the noisiest cells. MINOR.
2. The single-binary-code focus is a modeling simplification (multi-code/temporal structure deferred). This is disclosed in both the proofs ("multi-code extension follows by the same argument ... we omit the algebra") and the limitations. The omission is acknowledged, not hidden, but the multi-code consistency claim is asserted rather than shown; a referee might want the one-paragraph multi-code argument made explicit. MINOR.
3. MIMIC-IV: the real-data plan is detailed and preregistered in spirit (AKI with KDIGO stage >= 1 as chart-proxy, stratified subsample to estimate the case-mix gap), but not executed (credentialing is the blocker). The paper is explicit that "the simulation is the core validation for the present version." Appropriate and honest for the scaffold stage; the absence is a known gap, not a defect.

## Confidence: HIGH (results files loaded and cross-checked against the text; oracle-check independently inspected).
