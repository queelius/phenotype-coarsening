# Methodology Auditor Report (2026-05-27)

## Scope

Re-evaluate the simulation evidence and the MIMIC-IV plan after the 2026-05-23 pass. Focus areas: (a) does the corrected T4 Jensen bound now align quantitatively with the simulation; (b) is the MIMIC-IV pending-step framing sufficient for AMIA/conference submission; (c) any new robustness gaps.

## Verification of T4 bound against simulation

Location: methodology.tex eq (11); validation.tex tab:informative.

The fix re-anchors the bound at g(mu_{S,1}). With mu_{S,1} = 1.5 and sigma_{S,1} = 1, the anchor and bound become:
- At b_1 = 1: g(0 + 1 * 1.5) = logit^{-1}(1.5) = 0.818; bound width = 1 * 1 / 4 = 0.250; sens_{coh} should lie in [0.568, 1.000].
- Simulation reports marginal sens = 0.779 at b_1 = 1: within bound, distance from anchor = 0.039. Consistent.
- At b_1 = 3: g(0 + 3 * 1.5) = logit^{-1}(4.5) = 0.989; bound width = 3 * 1 / 4 = 0.750; sens_{coh} should lie in [0.239, 1.000].
- Simulation reports marginal sens = 0.902 at b_1 = 3: within bound, distance from anchor = 0.087. Consistent.

The previous (incorrect) anchoring at g(0) would give 0.500 +/- 0.250 at b_1 = 1, which catches 0.779 only at the upper edge and breaks at b_1 = 3 (0.500 +/- 0.750 is vacuous). The new anchoring gives sharp bounds in both regimes. Quantitatively the fix is real.

Status: T4 numerical alignment is now meaningful. Consistent.

## Synthesis conclusion vs discussion (P2 from 2026-05-23)

Locations: conclusion.tex; discussion.tex section "What is new here" and "Sibling applications".

The conclusion has been rewritten and is now genuinely forward-looking synthesis, not theorem recap. Key new content:
- Reframes the practitioner's question from method-specific ("PheCAP vs PheNorm") to assumption-specific ("does my coding mechanism violate C2"). This is the synthesis claim and it is novel relative to the discussion's "What is new here" paragraph.
- Names the cross-domain applications (claims-based comorbidity, registry case-finding, cause-of-death, adverse-event surveillance). These are net-new (the discussion's sibling-applications paragraph is about transcriptomics, DP, weak supervision, not about healthcare-data siblings).
- Calls out three concrete extensions (multi-code/temporal, chart-review error, propagation into downstream causal estimands).
- Tightens the contribution claim: "positioning... names the failing assumption, supplies the remedy, quantifies the residual."

Status: P2 from 2026-05-23 is genuinely closed. The conclusion now complements rather than duplicates the discussion.

## MIMIC-IV pending-step framing

Location: validation.tex lines 243 to 267.

The MIMIC-IV plan is unchanged from 2026-05-23: a five-step protocol (code-only prevalence, lab-defined chart proxy, fit coding model on subsample, deconvolve, check code-frequency consistency). The framing is identical to the 2026-05-22 version: "described here and left as the principal pending item."

This framing is acceptable for AMIA Annual Symposium (rank 2) and for CHIL/ML4H (ranks 3/4) where simulation-only papers are routine. It is not sufficient for JAMIA (rank 1), as the 2026-05-23 C4 flagged.

The state file notes MIMIC-IV is gated on PhysioNet credentialed access. If the PhysioNet credential is in motion, the AMIA route is the right move; the paper should not block on JAMIA gating before submission feedback is in hand.

The pending-step framing itself reads honestly. The five-step protocol is concrete enough that a JAMIA reviewer can see the methodological work has been thought through. The remaining task is execution.

### M1 (Major, new): MIMIC-IV plan should preregister the chart-proxy definition.

The plan describes "a structured rule over labs and physiology" as the chart-proxy without committing to a specific rule. For acute kidney injury (the example), KDIGO criteria are standard; for sepsis, the Sepsis-3 SOFA criteria are standard. Specifying the proxy rule preregisters the analysis and forecloses the post-hoc reviewer concern "the chart proxy was chosen to make the code look worse." This is also a methodological asymmetry the paper itself addresses (the chart proxy is the "ground truth" the deconvolution corrects toward, so its definition is consequential).

Suggestion: add a one-sentence preregistration for the AKI example, e.g. "We will use KDIGO 2012 stage-1+ defined by serum creatinine rise >= 0.3 mg/dL within 48 hours or 1.5x baseline within 7 days as the chart-proxy definition for AKI."

Severity: Major for JAMIA, Minor for AMIA/CHIL/ML4H.

## Simulation robustness sweep (was M7 2026-05-23)

The 2026-05-23 report flagged that the simulation uses one prevalence (pi = 0.12), one severity gap (mu_{S,1} = 1.5), one selection mechanism. The author did not address this in the 2026-05-27 fix list. The state file does not mention an ablation.

Re-flagging as outstanding M2 (major). This is a JAMIA-level concern and can be deferred for the conference route, but for JAMIA the bias-bound interpretation needs the robustness ablation to be persuasive.

## New findings

### M2 (Major, carryover from 2026-05-23 M7): Simulation robustness still absent.

Add an ablation table (1 to 2 paragraphs) varying pi in {0.05, 0.12, 0.30}, mu_{S,1} in {0.5, 1.5, 3.0}, and the selection mechanism (random vs encounter-weighted vs code-conditional). Show the qualitative bias-sign-change conclusion holds across the grid. The current simulation supports the central claim; the ablation supports the bias-bound interpretation.

### M3 (Minor, new): Bias columns in tab:informative do not include Monte Carlo standard errors.

The chart-review-calibrated estimator's bias magnitudes (0.0019, 0.0011, ..., 0.0008) are all very small. Are they statistically distinguishable from zero? Without an MCSE column the reader cannot tell whether "near-unbiased throughout" is a finite-sample artifact or a robust claim.

Suggestion: add an MCSE column or report bias +/- MCSE in each cell. With 200 replicates, MCSE on bias is roughly sigma_{boot} / sqrt(200), which for these magnitudes is informative.

### M4 (Minor, new): Sensitivity-gap saturation is now in methodology.tex.

The 2026-05-23 m3 flagged that rho saturation explanation should appear in methodology, not only validation. The current draft has the explanation only in validation.tex line 198 to 209, not methodology.tex. Still outstanding.

Suggestion: add a one-line remark after eq (11) noting that as |b_1| grows the logistic saturates and rho approaches 0 from above, even though the bound width |b_1| sigma_{S,1}/4 grows linearly. The simulation will see correlation decrease while bound width increases; both behaviors are predicted.

## Summary

T4 numerical fix is genuine; the synthesis conclusion is genuine. The MIMIC-IV plan reads honestly but would benefit from preregistering the chart-proxy definition. The simulation robustness sweep from 2026-05-23 M7 is still outstanding and remains the main methodology gap for a JAMIA push. The four new methodology findings are one major (MIMIC-IV preregistration), one carryover major (robustness sweep), and two minor.

Severity: 0 critical, 2 major, 2 minor.
