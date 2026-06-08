# Logic Checker: phenotype-coarsening

Scope: the four headline results (glass-ceiling T1, chart-review identifiability T2, code-frequency consistency T3, informative-coding bias bound T4) plus the case-mix-gap corollary. All load-bearing steps re-derived; several checked numerically in base R.

## Verdict: SOUND

All four results hold as stated. The previously-fixed T4 Jensen-step algebra is correct, the glass-ceiling admissibility region (including the previously-added upper bound) is correct, and the sens+spec>1 informative condition is used correctly throughout.

## T1 Glass ceiling (thm:glass-ceiling) -- SOUND, admissibility region correct

The construction: q = pi*sens + (1-pi)(1-spec) is one scalar equation in three unknowns; fix (pi, spec) in the admissibility region and solve for sens. The admissibility region is
  max(0, 1 - q/(1-pi)) <= spec <= min(1, (1-q)/(1-pi)).
I re-derived both bounds from scratch:
- sens <= 1  <=>  (1-pi)(1-spec) >= q - pi  <=>  spec <= (1-q)/(1-pi)  [UPPER bound]
- sens >= 0  <=>  (1-pi)(1-spec) <= q        <=>  spec >= 1 - q/(1-pi)  [LOWER bound]
The manuscript's prose attributes the upper bound to sens<=1 and the lower bound to sens>=0, which MATCHES my derivation exactly. The previously-added upper bound is correct and the cited counterexample (q=0.5, pi=0.1, spec=0.99 gives the inadmissible sens=4.91) is numerically confirmed (sens = 4.910). The two-dimensional-surface conclusion is valid: the admissible region is a nonempty open subset of the unit square for every q in (0,1), so the solution set is a 2-D surface in the unit cube. NOTE: an earlier reviewer pass might worry the prose swaps which constraint yields which bound; I checked carefully and it does NOT swap. Proof is clean.

## T2 Identifiability with chart review (thm:identifiability-chart) -- SOUND

Two-stage argument: (stage 1) on the chart-reviewed subsample both Y and C are observed, so the coding model (sens, spec, and the severity dependence) is identified by regression given condition (i) coverage of both classes and enough design points; (stage 2) with sens, spec known, the cohort code frequency q gives one equation in pi, solved by the Rogan-Gladen plug-in
  pi_hat = (q - (1 - spec)) / (sens + spec - 1),
which is well-defined iff sens + spec > 1. This is correct, and the paper correctly identifies this denominator condition as "the code is informative about Y." Condition (ii) (case-mix representativeness) is correctly flagged as the bridge that makes subsample sens transportable to the cohort, with the residual quantified in cor:casemix. The "reviewing only code-positive patients identifies sensitivity but not specificity" remark is correct.

## T3 Code-frequency consistency (thm:code-total) -- SOUND

The marginal log-likelihood of a single binary code depends on (pi, sens, spec) only through the implied code frequency q; the Bernoulli log-likelihood Cbar log q + (1-Cbar) log(1-q) has unique interior stationary point q = Cbar; at any interior MLE in the informative regime (sens+spec>1, so the gradient of q in the parameters is nonzero) the fitted q equals Cbar. Numerically confirmed: with sens=0.776, spec=0.95 the plug-in pi_hat reproduces qbar to 0e+00. The "every point on the glass-ceiling surface reproduces qbar, so a marginal-fit check cannot detect prevalence bias" consequence is correct and is the sharp practical point. The informative-regime qualifier (sens+spec>1) is exactly the right one to exclude the degenerate gradient case.

## T4 Bias bound under informative coding (thm:bias-informative) -- SOUND; the FIXED Jensen step is correct

Two pieces:
1. E[pi_hat_code] = pi*sens_coh + (1-pi)(1-spec), giving Bias = -pi(1 - sens_coh) + (1-pi)(1-spec). Correct (Bernoulli mixture expectation).
2. The key bound |sens_coh - g(mu_{S,1})| <= |b1| sigma_{S,1} / 4, where g(s) = logit^{-1}(b0 + b1 s). The proof chain:
   - |g'(s)| = |b1| g(1-g) <= |b1|/4 since x(1-x) <= 1/4 on [0,1]. Correct.
   - MVT: |g(s) - g(mu)| <= (|b1|/4)|s - mu| pointwise. Correct.
   - Take E[. | Y=1]; apply Jensen to |.| (|E X| <= E|X|): |sens_coh - g(mu)| <= (|b1|/4) E[|S - mu|]. Correct (this is the step whose algebra was previously fixed).
   - Apply Jensen to the concave sqrt: E[|S - mu|] <= sqrt(E[(S-mu)^2]) = sigma. Correct.
   Numerically verified across (b1, sigma) in {(0.5,1),(1,1),(2,1),(3,1.5),(1.5,2)}: the LHS is below |b1|sigma/4 in every case (e.g., b1=2, sigma=1: LHS=0.082 <= 0.50). The bound is not tight (it is a valid upper bound, as intended) and is tight in the C2-holds direction (b1=0 gives both sides zero). SOUND.

The two-Jensen structure is the subtle part and it is now correct: the first Jensen pulls the absolute value outside the expectation, the second bounds the mean absolute deviation by the standard deviation. Both inequalities go the right way.

## cor:casemix (residual bias from case-mix gap) -- SOUND (first-order)

Differentiating the deconvolution pi_hat(sens) = (q - (1-spec))/(sens + spec - 1) with respect to the plugged-in sensitivity at the truth gives d pi_hat / d sens = -pi/(sens_coh + spec - 1) (using q = pi sens_coh + (1-pi)(1-spec) at the truth), so a perturbation delta = sens_rev - sens_coh gives Bias ~ -pi delta/(sens_coh + spec - 1) + O(delta^2). The derivative is correct (I verified the algebra: numerator derivative is -(q-(1-spec))/(sens+spec-1)^2 = -pi sens_coh.../... ; substituting q at truth yields -pi/(sens+spec-1)). First-order claim is sound; the O(delta^2) labeling is appropriate.

## sens+spec>1 informative condition -- USED CORRECTLY

The condition appears in T2 (deconvolution well-defined), T3 (nonzero gradient excludes the degenerate corner), and implicitly in cor:casemix (the denominator). Numerically: denominator sens+spec-1 is positive iff sens+spec>1, zero at the boundary, negative below (sign flip = uninformative code). The paper uses it consistently and correctly as "the code is informative about Y."

## Minor logic note
- The non-monotonicity of rho (the descriptive severity-coding correlation) in |b1| is correctly handled: the paper explicitly does NOT use rho as the violation-severity index (it uses |b1|), and explains the saturation that makes rho non-monotone (rises to 0.994 at b1=0.5, falls to 0.743 at b1=3.0). This is a place a careless paper would have erroneously equated rho with violation strength; this one gets it right.

## Confidence: HIGH (all four results re-derived; T4 Jensen chain and T1 admissibility region numerically reproduced).
