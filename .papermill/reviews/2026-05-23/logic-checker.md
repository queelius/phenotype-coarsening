# Logic checker

## Method

Read all proofs in identifiability.tex and methodology.tex; checked each step against standard probability and the simulation outputs. Cross-checked the deconvolution formula against the Rogan-Gladen 1978 literature.

## Findings

### CRITICAL: T4 proof has an incorrect Jensen step

Location: methodology.tex lines 86 to 88.

Quoted text:
> "Taking expectations among diseased patients gives $|\E[g(S) \mid Y=1] - g(0)| \le |b_1| \E[|S| | Y=1]/4 \le |b_1| \sigma_S/4$ by Jensen."

Problem: the second inequality $\E[|S| | Y=1] \le \sigma_S$ holds only if $S$ has mean zero conditional on $Y=1$. In the DGP, $\E[S | Y=1] = \mu_{S,1} = 1.5$ (not zero), so this step is incorrect as written. The correct bound via Jensen-Cauchy-Schwarz is $\E[|S|| Y=1] \le \sqrt{\E[S^2 | Y=1]} = \sqrt{\sigma_S^2 + \mu_{S,1}^2}$. To recover a clean $\sigma_S$, the proof should either:

- Replace $g(0)$ with $g(\mu_{S,1})$ as the reference point and apply MVT to $g(S) - g(\mu_{S,1}) = g'(\xi)(S - \mu_{S,1})$, then $\E|S - \mu_{S,1}| \le \sigma_S$ by Jensen.
- Or state the bound in terms of $\sqrt{\E[S^2 | Y=1]}$ rather than $\sigma_S$.

The first fix is cleaner because it preserves the result; the inflation factor becomes $1 - g(\mu_{S,1})$ rather than $1 - g(0)$, which is the natural quantity (the miss rate at average severity).

Suggested fix: in methodology.tex around line 79 to 95, re-derive the bound with $g(\mu_{S,1})$ as the anchor.

### CRITICAL: deconvolution formula eq (10) is the Rogan-Gladen estimator with no citation

Location: identifiability.tex line 112-117 (eq:deconvolve).

Quoted text:
> $\hat\pi = \frac{q - (1 - \widehat{\mathrm{spec}})}{\widehat{\mathrm{sens}} - (1 - \widehat{\mathrm{spec}})}$

Problem: this IS the Rogan-Gladen 1978 estimator (Am J Epidemiol 107:71-76, "Estimating prevalence from the results of a screening test"). It is the standard epidemiology textbook formula for adjusting apparent prevalence given sens/spec. Not citing it is a critical omission and a JAMIA reviewer will flag this immediately. The contribution becomes "structural framework + Rogan-Gladen plug-in" rather than "novel estimator", which is what the paper means but does not state.

Suggested fix: add the citation at eq (10), and acknowledge in prose that "this is the Rogan-Gladen 1978 deconvolution estimator with sens/spec supplied by the chart-reviewed subsample". The contribution is then framed honestly.

### MAJOR: T1 proof rank argument is opaque

Location: identifiability.tex line 57 to 64.

Quoted text:
> "This is the binary specialization of the rank-deficiency argument behind Cref{thm:bg-id}: with only $\{0,1\}$ candidate sets, the augmented candidate-set matrix $\tilde{C}$ has rank $1$, short of the rank required to identify a three-dimensional parameter."

Problem: the rank-1 claim is asserted but $\tilde{C}$ is not defined in this paper. background.tex states T_bg-id without defining $\tilde{C}$ either. The reader must read the framework paper to understand the rank argument. The earlier surface-construction argument is self-contained and rigorous; the appended "this is the rank-deficiency argument" is gratuitous and broken. Drop the last 3 sentences of the proof, or define $\tilde{C}$.

Suggested fix: remove "This is the binary specialization..." through end of proof. The surface construction stands on its own.

### MAJOR: T2 proof condition (i) "enough distinct design points" is not formal

Location: identifiability.tex line 107.

Quoted text:
> "condition (i) supplies enough distinct design points to identify the coding parameters"

Problem: condition (i) is stated as "the coding mechanism belongs to a parametric family identifiable from the joint distribution". This is condition-(i), but the proof restates it as "enough distinct design points". For the logistic coding mechanism with two parameters $(b_0, b_1)$, identifiability requires the severity distribution among Y=1 to be non-degenerate (e.g., at least two distinct S values with non-zero density). Tighten by saying: "condition (i) is equivalent for the logistic coding mechanism to the assertion that $\text{Var}(S | Y=1) > 0$ on the subsample's support".

### MAJOR: T3 proof "stationary point in q" missing one step

Location: identifiability.tex line 159-174.

Quoted text:
> "The marginal log-likelihood of a single binary code depends on the parameters only through the implied code frequency $q(\pi, \mathrm{sens}, \mathrm{spec})$... Any interior MLE of $(\pi, \mathrm{sens}, \mathrm{spec})$ at which the parameter-to-$q$ map has full rank in at least one coordinate therefore satisfies..."

Problem: this works for the MARGINAL likelihood, i.e., when the only data is the marginal C frequency. But the calibrated MLE in study 2 uses the JOINT data (Y_i, S_i, C_i) on the subsample plus the marginal C on the cohort. The joint MLE is not constrained to reproduce the cohort-marginal $\bar C$ exactly unless the marginal C frequency contributes only through $q$. The proof should make explicit which likelihood is being considered: the cohort-marginal-code-frequency likelihood for the T3 statement, and confirm that the calibrated estimator's predicted $q$ matches via construction (since it solves the deconvolution at $\bar C$).

Suggested fix: clarify "let $\hat\pi$ be the calibrated estimator from eq (10); by construction $\hat\pi \cdot \widehat{\mathrm{sens}} + (1-\hat\pi)(1-\widehat{\mathrm{spec}}) = \bar C$." This is trivial but should be stated cleanly. The "interior MLE" framing introduces unnecessary regularity machinery.

### MINOR: T1 proof admissibility region statement is slightly off

Location: identifiability.tex line 38 to 45.

Quoted text:
> "Choose $(\pi, \mathrm{spec})$ with $\pi \in (0,1)$ and $\mathrm{spec} \in [\max(0, 1 - q/(1-\pi)), 1)$"

Problem: the boundary $\mathrm{spec} = 1 - q/(1-\pi)$ gives $\mathrm{sens} = 1$ which is a boundary not interior. The proof says "the lower bound on spec ensures sens $\le 1$" which is correct, but the bound is non-strict. To stay strictly interior, use $\mathrm{spec} \in (1 - q/(1-\pi), 1)$ when this is positive. Cosmetic but the proof asks for "interior MLE" elsewhere.

### MINOR: case-mix-gap corollary first-order language

Location: methodology.tex line 147-156 (eq:meth-residual).

Quoted text:
> "To first order in $\delta$, the chart-review-calibrated prevalence estimator has bias..."

This was noted in the 2026-05-22 review pass and addressed via the MVT version of T4. The corollary itself still uses "to first order" / "Taylor" language. This is consistent with the explicit statement "$+ O(\delta^2)$" so it is technically OK, but the corollary's proof is two sentences and would benefit from one more line writing out the Taylor remainder term explicitly.

### MINOR: definition of rho

Location: methodology.tex line 27 to 33 (eq:meth-rho).

The severity-coding correlation is defined as $\rho := \mathrm{Corr}(S, g(S) | Y=1)$. For a monotone $g$, this is close to 1 by construction; the simulation shows $\rho = 0.994$ at $b_1 = 0.5$. The interpretation of $\rho$ as "the strength of the C2 violation" is therefore slightly misleading because $\rho \to 1$ as $b_1 \to 0^+$, not as $b_1 \to \infty$. Better: use $|b_1| \sigma_S$ as the natural scale, with $\rho$ a normalization. Validation text (around line 168 to 174) acknowledges this saturation. Suggest noting it in the methodology section too.

### MINOR: the alpha decomposition in T4 proof

Location: methodology.tex line 88 to 91.

Quoted text:
> "write $S = \alpha g(S) + R$ with $R$ uncorrelated with $g(S)$ conditional on $Y = 1$; then $\mathrm{Var}(R | Y=1) = \sigma_S^2(1 - \rho^2)$"

This is correct (regression of $S$ on $g(S)$ gives the decomposition). But the proof does not state how the decomposition is "substituted in" to obtain the $\sqrt{1-\rho^2}$ factor in the bound. The bound has $|b_1| \sigma_S \sqrt{1-\rho^2}/4$, which sketches as: the contribution to $\E[g(S)]$ from $R$ is the "uncoupled" part, of magnitude $|b_1| \sigma_R/4 = |b_1| \sigma_S \sqrt{1-\rho^2}/4$. The "coupled" part through $g(S)$ itself collapses. Two sentences of derivation would make this rigorous.

## Cross-verification notes

- Simulated quantities match paper text (study 1: q = 0.13772 in sim vs 0.1377 quoted; study 4a: -0.0161 to +0.0322 matches; study 4b: 0.0007 to 0.006 matches).
- The Rogan-Gladen formula is correctly applied (verified by setting sens = spec = 1 gives pi = q, which is the perfect-code corner of the glass ceiling).
- Sign of bias: at $b_1=0$, sens = 0.5, fpr = 0.05, pi = 0.12 gives expected bias $0.12 \cdot 0.5 + 0.88 \cdot 0.05 - 0.12 = 0.06 + 0.044 - 0.12 = -0.016$. Matches.
