# Novelty Assessor Report (2026-05-27)

## Scope

Reassess the contribution claim after the Rogan-Gladen, Begg-Greenes, and Hubbard additions. Focus areas: (a) does the unified-vocabulary framing earn its keep when set against the four substantial ancestors (Rogan-Gladen, Hui-Walter, Dawid-Skene, Begg-Greenes); (b) is the contribution disclaim now properly calibrated; (c) what remains to make the paper's positive case sharper.

## The new ancestor lineup

With the 2026-05-23 additions, the paper now acknowledges four substantial ancestors:
- Rogan-Gladen 1978: the prevalence correction formula (acknowledged at eq (10) and in discussion).
- Hui-Walter 1980: latent-class estimation of sens, spec, and prevalence (acknowledged in discussion).
- Dawid-Skene 1979: EM for rater-error rates (acknowledged in discussion).
- Begg-Greenes 1983 (with Hubbard 2020): verification bias when verification is selective (acknowledged in discussion).

These four are the deep ancestors of essentially every operational step the paper makes. The contribution claim therefore has to be done not by inventing the algebra but by establishing why the unified vocabulary is the right unifying language. The discussion's "What is new here" paragraph (lines 79 to 96) attempts exactly this.

## Is the contribution claim now properly calibrated?

The discussion paragraph itemizes four contributions:
(i) explicit candidate-set translation that places phenotyping inside coarsening at random.
(ii) the C1-C2-C3 classification, with informative coding pinned as a C2 violation specifically (not C1 miscoding, not C3 confounding).
(iii) the explicit glass-ceiling construction (solution surface, not just a non-identifiability claim).
(iv) the informative-coding bias bound and case-mix-gap residual bound.

Cross-checking each:
- (i) is a framing contribution. The phenotyping literature has not (as far as the literature scout's broad sweep can confirm) used coarsening-at-random vocabulary at the masked-cause level. This is genuinely new positioning, not a new result. The discussion paragraph correctly characterizes it as positioning.
- (ii) is the load-bearing structural payoff. Naming informative coding as specifically the C2 failure (not C1 miscoding, not C3 parameter confounding) is a useful diagnostic for practitioners: it tells them which conditional-independence assumption fails and why their fits are biased. The C1/C2/C3 trichotomy is from Heitjan-Rubin 1991 and Gill et al 1997 but its application to phenotyping is new.
- (iii) is a sharper technical contribution than the 2026-05-22 draft made it. The solution-surface construction (eq 9, the explicit sens = (q - (1-pi)(1-spec))/pi parameterization) gives the practitioner a concrete object: a 2D surface of admissible triples sharing the same observed q. This is more useful than "(pi, sens, spec) is non-identifiable from p" as a black box.
- (iv) is the contribution most exposed to the Begg-Greenes precedent. The case-mix-gap corollary (eq 13) is a verification-bias result, the paper now says so explicitly, and the contribution is the recasting plus the C2-vocabulary explanation. The bias-bound (eq 11) is morally a differential-misclassification result (Bross 1954, Greenland 1980) but reaches it via the masked-cause framing rather than the differential-misclassification literature. The 2026-05-23 M6 flagged that Bross and Greenland should be cited; this is still outstanding.

The overall calibration of the contribution claim is now honest. The paper is no longer claiming to invent prevalence correction, latent-class estimation, or verification-bias correction; it is claiming the unified vocabulary that names the failing assumption.

Status: C5 from 2026-05-23 (verification-bias engagement) is closed. The contribution claim is properly calibrated.

## What remains to make the positive case sharper

### N1 (Major, carryover from 2026-05-23 M6): Bross 1954 and Greenland 1980 differential-misclassification ancestors still missing.

Location: methodology.tex T4 statement and proof.

T4 is presented as a coarsening-vocabulary bias bound. It is morally a differential-misclassification result (Bross 1954 Biometrics, Greenland 1980 Stat Med); the contribution at this step is the explicit severity-coding-correlation parameterization in the coarsening framework. Not citing either is a continuing positioning gap, parallel to the original Rogan-Gladen and Begg-Greenes gaps.

Suggestion: add bross1954 and greenland1980 to refs.bib; cite in T4 statement: "the result is in the spirit of differential-misclassification bias bounds (Bross 1954, Greenland 1980); the contribution is the explicit dependence on the severity-coding correlation in the coarsening framework."

Severity: Major for JAMIA, Minor for AMIA/CHIL/ML4H.

### N2 (Minor, new): "C3 confounding between coding parameters and prevalence" is not exhibited.

Location: discussion.tex line 84 to 85.

The C1-C2-C3 classification is stated as identifying informative coding as "specifically a C2 violation, distinguishing it from miscoding (C1) and from confounding between coding parameters and prevalence (C3)". But C3 (parameter independence) is the condition that the coding-mechanism parameters are functionally distinct from the prevalence parameter; the paper does not exhibit a phenotyping scenario where C3 fails. By contrast C1 violation (the truth not being in the candidate set) is exhibited as "gross miscoding" in the translation table.

Suggestion: add one sentence exhibiting a C3 failure scenario for phenotyping, e.g. "C3 fails when the coding-mechanism parameters are themselves functions of prevalence, as in administrative settings where billing intensity rises during outbreaks: a higher true prevalence drives more coding effort, so the coding mechanism is not a fixed model conditional on truth but a state-dependent one." Without this, the C1/C2/C3 trichotomy reads asymmetrically.

### N3 (Suggestion): Allman-Matias-Rhodes 2009 still missing.

The 2026-05-23 M12 flagged that Allman-Matias-Rhodes 2009 (Annals of Statistics) is the standard modern reference for finite-mixture / latent-class identifiability and that T1 and T2 sit in this territory. Still missing from refs.bib.

Suggestion: add the citation; mention in background.tex when introducing identifiability or in identifiability.tex when stating T2.

### N4 (Minor, new): Anchor-and-learn positioning could be tightened.

The 2026-05-23 M4 flagged the anchor-positioning slight overstatement. The current translation.tex lines 112 to 117 still says "an anchor is a near-singleton candidate set; the framework predicts that anchors restore identifiability for the same reason chart review does." Halpern's anchors are typically Y=1-only (high-precision positives), not symmetric. The 2026-05-23 suggestion (rephrase to note anchors supply Y=1 singletons whereas chart review supplies both) was not adopted.

Suggestion: tighten the anchor description as in 2026-05-23 M4.

## Summary

The contribution claim is now properly calibrated. The four ancestors are all engaged honestly and the unified-vocabulary framing earns its keep on (i) the C2-violation diagnosis, (ii) the explicit glass-ceiling solution surface, and (iii) the recasting of verification bias as a coarsening statement. Two prior major findings (Bross/Greenland citation, anchor positioning) are unaddressed and remain. Two new minor findings.

Severity: 0 critical, 1 major (carryover), 2 minor, 1 suggestion.
