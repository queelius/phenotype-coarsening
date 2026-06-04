# Literature Context Packet (2026-05-27)

## Scope

Merged output from broad and targeted literature scouts focused on whether the 2026-05-23 fix pass closes the prior-art positioning gaps. Two areas of focus:
(a) Does the Rogan-Gladen reframing now read as the genuine ancestor?
(b) Does the Begg-Greenes / Hubbard verification-bias paragraph properly position the case-mix-gap corollary?

## Rogan-Gladen 1978 as ancestor

Rogan, W. J. and Gladen, B. (1978). Estimating prevalence from the results of a screening test. American Journal of Epidemiology, 107(1), pages 71 to 76. DOI 10.1093/oxfordjournals.aje.a112510.

The Rogan-Gladen estimator is the textbook screening-test correction: given known sensitivity S and specificity C, apparent prevalence q = pi * S + (1 - pi) * (1 - C) is inverted to true prevalence pi-hat = (q - (1 - C))/(S - (1 - C)). This is exactly equation (10) of the paper.

The paper now correctly attributes the formula at the point of use (identifiability.tex line 114) and in the discussion (line 14). The paper's contribution at this step is no longer the formula but the role of the chart-reviewed subsample as the identifying singleton (the source of the sens-hat and spec-hat plugged in), and the placement of the whole construction inside the masked-cause / coarsening framework.

Genuinely-new positioning, post-fix: the Rogan-Gladen formula assumes sens and spec are known; the paper's structural contribution is that sens and spec come from the chart-reviewed singletons, which the coarsening framework characterizes as the candidate-set-restoring identifying mechanism. This is a useful relabeling.

Status: Rogan-Gladen is correctly positioned as the ancestor, the contribution is correctly delineated, and the reframing reads as honest.

## Verification bias as the source of the case-mix-gap corollary

Begg, C. B. and Greenes, R. A. (1983). Assessment of diagnostic tests when disease verification is subject to selection bias. Biometrics, 39(1), pages 207 to 215. DOI 10.2307/2530820.

The Begg-Greenes paper establishes that when disease verification is selective (i.e., not all screened patients are biopsied/chart-reviewed), apparent sensitivity and specificity are biased and the bias propagates to prevalence and predictive-value estimates. This is precisely the situation the case-mix-gap corollary (cor:casemix) describes: the chart-reviewed subsample's case mix is not representative of the cohort, so the subsample-estimated sens and spec are not transportable.

Hubbard, R. A. et al (2020). Statistical methods for outcome misclassification in observational studies with multiple data sources. Statistics in Medicine, 39(19), pages 2557 to 2572. DOI 10.1002/sim.8556.

Hubbard 2020 is a recent phenotyping-specific treatment of the same problem: multiple imperfect data sources, no perfect reference, selective verification. The methods are directly relevant to the chart-review-calibrated estimator.

The paper now correctly attributes both, and the discussion paragraph (lines 35 to 52) recasts the case-mix-gap corollary as a verification-bias result that the masked-cause framing names as a C2 failure on the chart-reviewed subsample. This is the right reframing.

Status: verification-bias literature is correctly engaged.

## What the literature still does not engage

### Differential misclassification (Bross 1954, Greenland 1980)

Bross, I. (1954). Misclassification in 2x2 tables. Biometrics, 10, pages 478 to 486.
Greenland, S. (1980). The effect of misclassification in the presence of covariates. American Journal of Epidemiology, 112(4), pages 564 to 569.

T4 is morally a differential-misclassification result. Bross 1954 is the original differential-misclassification paper, and Greenland 1980 is the canonical statement that differential misclassification can bias in either direction (which is exactly the bias-sign-change finding the paper highlights). Not engaging this literature is a continuing positioning gap.

### Latent-class identifiability (Allman-Matias-Rhodes 2009)

Allman, E. S., Matias, C., and Rhodes, J. A. (2009). Identifiability of parameters in latent structure models with many observed variables. Annals of Statistics, 37(6A), pages 3099 to 3132.

The standard modern reference for finite-mixture / latent-class identifiability. The paper's T1 and T2 sit in this lineage. Mentioning Allman-Matias-Rhodes would substantively strengthen the identifiability framing, particularly the rank conditions of background.tex thm:bg-id.

### Surveillance bias detail (Hripcsak 2011)

Hripcsak, G., et al (2011). Use of electronic clinical documentation: time spent and team interactions. JAMIA. Or related: Hripcsak G, Soulakis ND, Li L, et al. Syndromic surveillance using ambulatory electronic health records. JAMIA. 2009;16:354-361.

There is a closer prior-source than the 2013 Hripcsak-Albers piece currently cited.

### Recent JAMIA verification-bias literature

Hong, C., Liao, K. P., and Cai, T. (2019). Semi-supervised validation of multiple surrogate outcomes with application to electronic medical records phenotyping. Biometrics. This is directly relevant to the chart-review-calibrated estimator's semi-supervised character.

## Summary

The two load-bearing literature gaps (Rogan-Gladen, Begg-Greenes/Hubbard) are correctly closed. The differential-misclassification (Bross/Greenland) and latent-class-identifiability (Allman-Matias-Rhodes) lineages remain unengaged but are minor positioning improvements rather than missing-ancestors. The Hong-Liao-Cai 2019 reference is a stronger direct prior than any currently cited.

The paper's prior-art positioning is now substantially closer to publication quality. The remaining citation gaps are recommended polish, not blockers.
