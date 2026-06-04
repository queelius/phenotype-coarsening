# Logic Checker Report (2026-05-27)

## Scope

Re-verify the four theorems with focus on the items the 2026-05-23 pass flagged as critical/major and that the author reports as fixed: (a) T4 Jensen step re-anchored at g(mu_{S,1}); (b) Rogan-Gladen reframing at eq (10); (c) T1 rank-deficiency tail deletion.

## Verification of T4 Jensen step (was C2 2026-05-23)

Location: methodology.tex lines 74 to 108.

The new derivation is:
1. Bound on logistic derivative: |g'(s)| <= |b_1|/4. Correct (x(1-x) <= 1/4 on [0,1]).
2. MVT pointwise: |g(s) - g(mu_{S,1})| <= (|b_1|/4) |s - mu_{S,1}|. Correct.
3. Take E[. | Y=1] of both sides; on the LHS use |E[X]| <= E[|X|] to obtain |E[g(S)|Y=1] - g(mu_{S,1})| <= (|b_1|/4) E[|S - mu_{S,1}| | Y=1]. The proof attributes the LHS step to "the triangle inequality"; this is technically Jensen on |.|, but the standard-textbook label is acceptable.
4. Jensen on concave sqrt: E[|S - mu_{S,1}|] <= sqrt(E[(S - mu_{S,1})^2]) = sigma_{S,1}. Correct.

The bound (eq 11) |sens_{coh} - logit^{-1}(b_0 + b_1 mu_{S,1})| <= |b_1| sigma_{S,1} / 4 is algebraically tight. The previous error (anchoring at g(0) and treating E[|S| | Y=1] <= sigma_S) is fully fixed. The leading constant in the bias bound is now the miss rate at average severity, 1 - g(mu_{S,1}), which is the intended semantics.

Status: C2 from 2026-05-23 is genuinely closed.

## Verification of Rogan-Gladen reframing (was C1 2026-05-23)

Location: identifiability.tex lines 112 to 120.

The new prose reads as the genuine ancestor: "Equation (10) is the Rogan-Gladen prevalence correction estimator with sens and spec supplied by the chart-reviewed subsample instead of being assumed known. The contribution of this paper at this step is structural (placing the estimator inside the masked-cause framework and exhibiting the chart-reviewed singleton as the identifying mechanism), not a new estimator."

This is the correct historical attribution and the correct delineation of contribution. The discussion at lines 11 to 28 of discussion.tex says the same thing and ties it to Hui-Walter explicitly.

Status: C1 from 2026-05-23 is genuinely closed.

## Verification of T1 surface-construction (was M1 2026-05-23)

Location: identifiability.tex lines 35 to 58.

The rank-deficiency tail that referenced an undefined matrix C-tilde has been removed. The proof is now exclusively the surface construction, which is rigorous and self-contained. The admissibility region is open (the constraint spec >= max(0, 1 - q/(1 - pi)) is an inequality), and "the admissibility region is a two-dimensional open subset of the unit square" is correct.

Status: M1 from 2026-05-23 is genuinely closed.

## New findings (not in 2026-05-23 report)

### L1 (Minor): The triangle-inequality label in the T4 proof is informal.

Location: methodology.tex line 93 to 94: "Taking expectations conditional on Y = 1 and applying the triangle inequality."

The step in question is actually |E[g(S) - g(mu_{S,1}) | Y=1]| <= E[|g(S) - g(mu_{S,1})| | Y=1], which is Jensen's inequality applied to the convex function |.|, not the triangle inequality. The triangle inequality applies to sums of absolute values, not to expectations.

Suggestion: replace "triangle inequality" with "the inequality |E[X]| <= E[|X|]" or "Jensen's inequality applied to the absolute-value function". This is a wording fix only; the math is correct.

### L2 (Minor): Re-anchor argument should state that mu_{S,1} is determined.

Location: methodology.tex line 84.

The proof says "Re-anchor at the conditional mean" but does not note that mu_{S,1} is a fixed quantity of the underlying DGP (it is the conditional severity mean among Y=1 in the cohort, not an estimated quantity). For the bound to be useful in practice the reader needs to know that mu_{S,1} and sigma_{S,1} are population quantities that the calibrated estimator can recover from the chart-reviewed subsample under condition (ii) of T2.

Suggestion: one sentence after "Re-anchor at the conditional mean": "where mu_{S,1} is the cohort-level conditional mean of severity among true cases, which is estimable from the chart-reviewed subsample under case-mix representativeness."

### L3 (Minor): Code-frequency consistency proof multi-code claim still self-cites.

Location: identifiability.tex line 172 to 173: "The multi-code extension is in (towell2026phenotypecoarsening)."

The 2026-05-23 report flagged this self-cite (M10) and the author reports the self-cite was retained "intentionally". The cite to "this paper, full version" was not removed from refs.bib (line 55) and the in-text use at identifiability.tex:173 remains. A reader cannot consult the cited extension; the claim is unanchored.

Suggestion: either deliver the multi-code statement as a brief corollary in this paper, or rewrite as "the multi-code extension follows by the same argument applied to the joint code-frequency vector; we omit the algebra here." The latter is the lighter touch.

### L4 (Minor): T3 proof "parameter-to-q map has full rank in at least one coordinate" is a strong qualifier.

Location: identifiability.tex line 165 to 168.

The full-rank-in-at-least-one-coordinate condition is informal. For a single binary code the map (pi, sens, spec) -> q is C^infinity with gradient (sens - (1 - spec), pi, (1 - pi)), which has full rank (i.e. nonzero) on the interior of (0,1)^3 except at the measure-zero set sens + spec = 1. This is automatic at any interior MLE that uses the code informatively (which is the only case of interest).

Suggestion: rewrite as "Any interior MLE in the regime sens + spec > 1 (i.e. the code is informative about Y) satisfies q(pi-hat, sens-hat, spec-hat) = C-bar, which is (12)."

## Summary

All three load-bearing claims of the 2026-05-23 fix list (T4 Jensen, Rogan-Gladen, T1 rank-tail) are genuinely closed. The four new logic findings are all minor wording or anchoring fixes; none are blockers. The proofs are otherwise tight.

Severity: 0 critical, 0 major, 4 minor.
