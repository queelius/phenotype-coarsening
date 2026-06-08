# Literature Context Packet (merged scouts) -- 2026-06-08

**Paper**: Electronic phenotyping as coarsening at random: identifiability
of clinical states from diagnosis codes (Towell).

**Search method**: CrossRef REST API (live DOI resolution) and the
paper's own bibliography, cross-checked against the prior round's
2026-06-04 literature packet. A native web-search tool was not available
in this environment; CrossRef DOI metadata resolution was used to verify
each load-bearing item, and the prior packet (which used the same
substitute) was treated as a baseline to confirm against.

## Field landscape: phenotyping + latent-class-of-diagnostic-tests

The paper cites the right ancestors and the right modern phenotyping
landmarks, and the set is unchanged-and-correct from the prior round:

- Classical screening / latent-class: Rogan-Gladen (1978, DOI
  10.1093/oxfordjournals.aje.a112510), Hui-Walter (1980, DOI
  10.2307/2530508), Dawid-Skene (1979, DOI 10.2307/2346806),
  Begg-Greenes (1983, DOI 10.2307/2530820). All cited, all verified.
- Partial identification with mismeasured data: Horowitz-Manski (1995,
  DOI 10.2307/2951627), Molinari (2008, DOI 10.1016/j.jeconom.2007.12.003).
  Both cited; correctly invoked as the set-identification backdrop for
  the glass ceiling.
- Phenotyping tradition: eMERGE (Gottesman 2013; Newton 2013), PheKB
  (Kirby 2016), PheWAS (Denny 2010), anchor-and-learn (Halpern 2016),
  high-throughput (Liao 2015), PheNorm (Yu 2018), PheCAP (Zhang 2019),
  probabilistic phenotypes (Pivovarov 2015), survey (Banda 2018), OHDSI
  (Hripcsak 2016), surveillance bias (Haut 2011; Carrell 2014), MIMIC-IV
  (Johnson 2023). All cited.
- Verification bias: hubbard2020outcome (Stat in Med 2020) cited.

## Closest recent neighbors: now CITED (the prior gap is closed)

The 2026-06-04 packet's single HIGH-priority gap was the recent
biostatistics literature that does almost exactly this paper's
estimation task. This pass confirms it is now covered:

- Beesley & Mukherjee, "Statistical inference for association studies
  using electronic health records: handling both selection bias and
  outcome misclassification," Biometrics 78(1):214-226, DOI
  10.1111/biom.13400. NOW CITED as beesley2022samba (the print year is
  2022; the prior packet's "2020" label was the online-first date; same
  paper, verified via CrossRef). Cited in the intro, the methodology, and
  a dedicated discussion paragraph. This was the single most important
  uncited item and it is resolved.
- tong2020augmented (JAMIA 2020, augmented estimator for differential
  misclassification) and zhang2019phiap (PhIAP) are cited as the
  calibrated-EHR-estimator family.
- The discussion adds a Positive-unlabeled-learning paragraph citing
  bekker2020pulearning (the PU survey isolating the SCAR assumption) and
  kumar2024pulsnar (PULSNAR, class-proportion estimation under
  selected-not-at-random labeling), mapping their SNAR regime onto the
  paper's C2 violation. This is a fair and timely addition that
  forecloses the "reinvented PU learning" objection.

## Remaining optional items (not gaps)

- Spencer (2011, Biometrics, "When Do Latent Class Models Overstate
  Accuracy ... in the Absence of a Gold Standard?", DOI
  10.1111/j.1541-0420.2011.01694.x): still uncited; relevant to the
  glass ceiling and the identifiability-by-restriction open problem.
  MEDIUM, optional.
- A conditional-dependence-caution grouping cite (e.g. DOI
  10.1002/sim.9085) for the open-problems claim that multiple
  conditionally-independent codes identify prevalence without chart
  review: still only Hui-Walter is cited there. LOW, optional.

Neither is a fairness gap; the claims they would support are presently
attributed correctly.

## Positioning verdict from the literature

Novelty is HONEST. The paper states explicitly and repeatedly that it
does not originate latent-class phenotyping, the Rogan-Gladen plug-in, or
verification-bias correction, and that its contribution is the
masked-cause UNIFICATION plus the bias characterization (the explicit
glass-ceiling surface, the informative-coding bias bound, the
case-mix-gap residual bound). The "we name the failing assumption (C2)
and bound the bias in a unified coarsening vocabulary, of which their
corrections are instances" framing is now applied consistently to
Beesley-Mukherjee, PU learning, and Hui-Walter alike. The fairness gap
the prior round identified is closed.

## Sibling-series cross-references (internal, present and consistent)

towell2026masked, towell2026synthesis (the consistency-theorem parent
for T3), towell2026scrnacoarsening (the spike-in analog used
throughout), towell2026spatialcoarsening, towell2026dpcoarsening,
towell2026weaksupcoarsening, towell2026mdrelax. All present as Zenodo
preprints, consistent with the family's concept-DOI citation convention.
