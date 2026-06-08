# Novelty Assessor: phenotype-coarsening (2026-06-08)

## Verdict: novelty claim is HONEST and carefully scoped. The prior round's main positioning gap (uncited Beesley-Mukherjee) is now CLOSED. No major novelty issue remains.

## What is claimed

The "What is new here" paragraph (discussion.tex) is exemplary in its
honesty. It enumerates four contributions and explicitly disclaims the
overclaims: "We do not claim to originate latent-class estimation of
disease status, nor the estimation of sensitivity and specificity
without a gold standard, nor the Rogan-Gladen plug-in." The stated
contribution is (i) the candidate-set translation placing code-based
phenotyping inside the coarsening framework; (ii) the C1-C2-C3
classification pinpointing informative coding as a C2 violation,
distinguished from miscoding (C1) and coding/prevalence confounding
(C3); (iii) the explicit glass-ceiling construction exhibiting the
non-identifiable surface rather than asserting non-identifiability; (iv)
the informative-coding bias bound (T4) and the case-mix-gap residual
bound (cor:casemix) in interpretable quantities.

## Is the unification genuinely new?

Yes, as positioning. Casting EHR phenotyping as masked-cause coarsening,
naming informative coding as the C2 failure, identifying chart review as
the singleton-candidate-set device, and recovering Rogan-Gladen as the
deconvolution it enables, is not standard in the phenotyping literature
and is a legitimately useful organizing contribution. The crisp delta
statement -- "the Hui-Walter model tells a practitioner THAT prevalence
can be estimated; the coarsening framework tells the practitioner WHICH
assumption (C2) the EHR violates, WHY (informative coding), and HOW
LARGE the bias is" -- is accurate. The sign-flip analysis (code-only
prevalence can understate, overstate, or pass through zero depending on
the sensitivity deficit vs false-positive inflation) is a genuine
analytic contribution beyond "codes are noisy," even though the
underlying Rogan-Gladen machinery is classical.

## Prior round's positioning gap is CLOSED

The 2026-06-04 review flagged a Major issue: the closest recent
biostatistics neighbors were uncited, specifically Beesley-Mukherjee
(Biometrics, the EHR selection-bias + outcome-misclassification paper)
and the PU-learning-with-non-random-selection literature. This pass
confirms the gap is closed:

- beesley2022samba (Beesley & Mukherjee, "Statistical inference for
  association studies using electronic health records: handling both
  selection bias and outcome misclassification," Biometrics 78(1):
  214-226, DOI 10.1111/biom.13400) is now cited THREE times: in the
  intro prior-work paragraph, in the methodology "oracle-free reference"
  paragraph, and as a dedicated "Calibrated EHR prevalence and
  association estimators" paragraph in the discussion. (The prior review
  called this "Beesley-Mukherjee 2020" from its 2020 online-first date;
  CrossRef confirms the print record is Biometrics 2022, vol 78, which
  is the correctly-cited year. Same paper, no error.)
- The discussion now has a dedicated "Positive-unlabeled learning"
  paragraph citing bekker2020pulearning (the PU survey, isolating the
  SCAR assumption) and kumar2024pulsnar (PULSNAR, class-proportion
  estimation under selected-not-at-random labeling), and explicitly
  identifies "their selected-not-at-random regime with our C2
  violation." This is a strong, fair addition that pre-empts the "you
  reinvented PU learning" objection.
- tong2020augmented and zhang2019phiap (PhIAP) are cited as the
  calibrated-EHR-estimator family of which the deconvolution is the
  prevalence-only special case.

The positioning sentence the prior review asked for is present: the
discussion states those works "build corrected estimators for specific
association analyses" while this paper "supplies the unifying
identifiability vocabulary that names the failing assumption and bounds
the bias, of which their corrections are instances." This converts the
prior apparent gap into explicit positioning.

## Residual positioning suggestion (minor, optional)

The prior round also suggested Spencer (2011, Biometrics, "When Do
Latent Class Models Overstate Accuracy ... in the Absence of a Gold
Standard?", DOI 10.1111/j.1541-0420.2011.01694.x) and a
conditional-dependence-caution cite (e.g. DOI 10.1002/sim.9085) to
support the open-problems claim that multiple conditionally-independent
codes can identify prevalence without chart review. Neither is present;
the open-problems statement still cites only Hui-Walter for that point.
This is optional polish, not a fairness gap: the claim as written
(multiple conditionally-independent codes identify prevalence) is the
standard Hui-Walter result, correctly attributed. Adding the
conditional-dependence caution would strengthen the open-problems
framing but is not required for honesty.

## Significance and scope honesty

The paper is candid that the technical results "are not breakthroughs in
isolation, they are corollaries of the masked-data framework applied to
the specific structure of EHR coding." For a methodology venue this
candor is appropriate; the value proposition is the unification plus the
practitioner-facing decision procedure (check C2, supply singletons via
representative chart review, report the case-mix gap). The MIMIC-IV
real-data application is honestly flagged as the principal pending item;
the conclusion does not overclaim empirical validation. Sim-only at this
stage is a disclosed limitation.

## Confidence: HIGH

The prior Major positioning gap is verified closed by grep on refs.bib
and the section sources; the now-cited Beesley-Mukherjee DOI verified via
CrossRef to be the correct paper.
