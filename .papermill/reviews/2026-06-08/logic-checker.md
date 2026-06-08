# Logic Checker: phenotype-coarsening (2026-06-08)

Scope: the four headline results (glass-ceiling T1, chart-review
identifiability T2, code-frequency consistency T3, informative-coding
bias bound T4) plus the case-mix-gap corollary. All load-bearing steps
re-derived; the key ones re-checked numerically in base R against this
build's section sources.

## Verdict: SOUND

All four results hold as stated, and every algebraic step I re-derived
matches the manuscript. The T1 admissibility region is correct, the
sens+spec>1 informative condition is used consistently and correctly,
and the T4 two-Jensen chain is valid.

## T1 Glass ceiling (thm:glass-ceiling) -- SOUND

q = pi*sens + (1-pi)(1-spec) is one scalar equation in three unknowns;
fix (pi, spec) in the admissibility region and solve for sens. The
region is max(0, 1 - q/(1-pi)) <= spec <= min(1, (1-q)/(1-pi)). I
re-derived both bounds:
- sens <= 1  <=>  spec <= (1-q)/(1-pi)   [UPPER bound]
- sens >= 0  <=>  spec >= 1 - q/(1-pi)   [LOWER bound]
The prose attributes the upper bound to sens<=1 and the lower bound to
sens>=0, which matches. The inadmissible-triple counterexample in the
proof (q=0.5, pi=0.1, spec=0.99 gives sens=4.91) is numerically
reproduced (sens = 4.910), and spec=0.99 does exceed the upper bound
(1-q)/(1-pi) = 0.5556, so the worked example is internally consistent.
The two-dimensional-surface conclusion is valid. The build's exp1
enumerates 160 admissible triples reproducing the observed code
frequency to max deviation 2.78e-17.

## T2 Identifiability with chart review (thm:identifiability-chart) -- SOUND

Two-stage argument. Stage 1: on the chart-reviewed subsample both Y and
C are observed, so the coding model (sens, spec, severity dependence) is
identified by regression given condition (i) coverage of both classes.
Stage 2: with sens, spec known, the cohort code frequency q gives one
equation in pi, solved by the Rogan-Gladen plug-in pi_hat = (q -
(1-spec))/(sens+spec-1), well-defined iff sens+spec>1. I verified the
deconvolution numerically: at the exp1 truth (pi=0.12, sens=0.776,
spec=0.95) the plug-in recovers pi=0.12 exactly, with sens+spec-1 =
0.726 > 0. The "reviewing only code-positive patients identifies
sensitivity but not specificity" remark is correct, as is condition
(ii) as the transportability bridge.

## T3 Code-frequency consistency (thm:code-total) -- SOUND

The marginal log-likelihood of a single binary code depends on (pi,
sens, spec) only through q; the Bernoulli log-likelihood has unique
interior stationary point q = Cbar; at any interior MLE in the
informative regime (sens+spec>1, nonzero gradient) the fitted q equals
Cbar. The build's exp3 confirms: calibrated code-frequency residual
median 0, max 2.78e-17; a deliberately-wrong-prevalence (2x truth) model
re-solved for sensitivity reproduces Cbar with median and max residual
both 0. The marginal-fit-blindness consequence is the correct and sharp
practical point. The informative-regime qualifier is exactly the right
one to exclude the degenerate-gradient corner.

## T4 Bias bound under informative coding (thm:bias-informative) -- SOUND

1. E[pi_hat_code] = pi*sens_coh + (1-pi)(1-spec); subtracting pi gives
   the bias. Correct (Bernoulli mixture expectation).
2. The key bound |sens_coh - g(mu_{S,1})| <= |b1| sigma_{S,1}/4, with
   g(s)=logit^{-1}(b0+b1 s). Chain: |g'| = |b1| g(1-g) <= |b1|/4;
   MVT gives |g(s)-g(mu)| <= (|b1|/4)|s-mu| pointwise; Jensen on |.|
   (|E X|<=E|X|) gives |sens_coh - g(mu)| <= (|b1|/4) E|S-mu|; Jensen on
   the concave sqrt gives E|S-mu| <= sigma. Both inequalities go the
   right way. Numerically verified across b1 in {0,0.5,1,1.5,2,3} with
   mu=1.5, sigma=1: LHS below |b1|sigma/4 at every point (e.g. b1=1:
   0.039 <= 0.25; b1=2: 0.082 <= 0.50). Tight in the C2-holds direction
   (b1=0: both sides 0). The bound is a valid (loose) upper bound, as
   intended.

## cor:casemix (residual bias from case-mix gap) -- SOUND (first order)

Differentiating pi_hat(sens) = (q-(1-spec))/(sens+spec-1) w.r.t. the
plugged-in sensitivity at the truth (using q = pi*sens_coh +
(1-pi)(1-spec)) gives d pi_hat/d sens = -pi/(sens_coh+spec-1); a
perturbation delta = sens_rev - sens_coh yields Bias ~ -pi*delta /
(sens_coh+spec-1) + O(delta^2). The derivative and the O(delta^2)
labeling are correct. exp4b confirms the sign and growth: subsample-ref
bias grows in magnitude with the sens gap, cohort-ref bias stays within
+/- 0.001.

## sens+spec>1 informative condition -- USED CORRECTLY

Appears in T2 (deconvolution well-defined), T3 (nonzero gradient
excludes the degenerate corner), and cor:casemix (the denominator). The
denominator sens+spec-1 is positive iff sens+spec>1. Consistently and
correctly used as "the code is informative about Y."

## rho non-monotonicity -- HANDLED CORRECTLY

The descriptive correlation rho is explicitly NOT used as the
violation-severity index (the paper uses |b1|), and the saturation that
makes rho non-monotone (rises to 0.994 at b1=0.5, falls to 0.743 at
b1=3.0) is explained. exp4a's rho column matches the table.

## Open logic item (carried, not a defect)

The multi-code extension of T3 is asserted ("we omit the algebra here")
rather than shown. The single-binary-code result is fully proven and the
multi-code claim is plausible (the same Bernoulli-stationarity argument
applied to the joint code-frequency vector), but a referee may want the
one-paragraph argument or a softening to "we conjecture." Minor.

## Confidence: HIGH

All four results re-derived; T1 counterexample, T2 deconvolution, T3
consistency (incl. wrong-prevalence check), and the T4 Jensen bound
reproduced in base R against this build.
