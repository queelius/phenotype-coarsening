# Literature Context Packet (merged scouts)

**Paper**: Electronic phenotyping as coarsening at random: identifiability of clinical states from diagnosis codes (Towell, concept DOI 10.5281/zenodo.20422890)

**Search method**: CrossRef REST API (live), Zenodo API (DOI resolution). Native WebSearch tool was not available; CrossRef `query.bibliographic` + DOI metadata resolution were used as the substitute, with authorship/venue/year verified for each load-bearing hit. arXiv-only items may be under-sampled.

## Field landscape: phenotyping + latent-class-of-diagnostic-tests

The paper cites the right ancestors and the right modern phenotyping landmarks:
- Classical: Rogan-Gladen (1978, DOI 10.1093/oxfordjournals.aje.a112510, verified), Hui-Walter (1980, DOI 10.2307/2530508, verified), Dawid-Skene (1979), Begg-Greenes (1983, DOI 10.2307/2530820, verified, title "Assessment of Diagnostic Tests When Disease Verification is Subject to Selection Bias").
- Phenotyping tradition: eMERGE (Gottesman 2013; Newton 2013), PheKB (Kirby 2016), PheWAS (Denny 2010), anchor-and-learn (Halpern 2016), high-throughput (Liao 2015), PheNorm (Yu 2018), PheCAP (Zhang 2019), probabilistic phenotypes (Pivovarov 2015), survey (Banda 2018), OHDSI (Hripcsak 2016), surveillance bias (Haut 2011; Carrell 2014), MIMIC-IV (Johnson 2023).
- Verification bias: hubbard2020outcome (Stat in Med 2020, the general multi-source method paper) is cited.

This is a strong, well-chosen reference base for the phenotyping side and the classical screening side.

## Directly relevant items NOT cited (verified via CrossRef)

The gap is the recent biostatistics literature that does almost exactly what this paper does (estimation/correction of prevalence and associations from EHR phenotypes with imperfect labels), which would be the natural "closest competitors" set:

1. **Beesley and Mukherjee (2020), "Statistical inference for association studies using electronic health records: handling both selection bias and outcome misclassification,"** Biometrics, DOI 10.1111/biom.13400. This is the single most important uncited item: it treats the EHR phenotype as a misclassified outcome AND handles selective sampling (verification bias) jointly, which is precisely the C2-violation + case-mix-gap pair this paper formalizes. HIGH priority.

2. **Hubbard, Tong, Duan, Chen (2020), "Reducing Bias Due to Outcome Misclassification for Epidemiologic Studies Using EHR-derived Probabilistic Phenotypes,"** Epidemiology, DOI 10.1097/ede.0000000000001193. By the SAME Hubbard already cited (the general Stat-in-Med paper hubbard2020outcome is cited; this EHR-phenotype-specific one is not). HIGH priority, and easy to add since the author is already in the bibliography.

3. **Spencer (2011), "When Do Latent Class Models Overstate Accuracy for Diagnostic and Other Classifiers in the Absence of a Gold Standard?",** Biometrics, DOI 10.1111/j.1541-0420.2011.01694.x. Directly relevant to the glass-ceiling and to the limits of identifiability-by-parametric-restriction discussed in the open problems; the conditional-dependence failure mode it studies is exactly the kind of restriction the paper says "can identify prevalence without chart review." MEDIUM priority.

4. Latent-class-with-conditional-dependence line (e.g., the 2001/2014 LCA-as-reference-standard papers surfaced in search, and the 2021 "continued controversy in using LCA" piece, DOI 10.1002/sim.9085): worth a single grouping citation to acknowledge that multiple conditionally-independent codes can identify prevalence without chart review (the paper already states this in the open-problems list but cites only Hui-Walter). MEDIUM-LOW priority.

## Positioning verdict from the literature

Novelty is **honest**. The paper states explicitly and repeatedly that it does not originate latent-class phenotyping, the Rogan-Gladen plug-in, or verification-bias correction, and that its contribution is the masked-cause UNIFICATION plus the bias characterization (the explicit glass-ceiling surface, the informative-coding bias bound, the case-mix-gap residual bound). The discussion's "What is new here" paragraph is a model of honest scoping.

The fairness gap is narrow but real: the closest recent biostatistics neighbors (Beesley-Mukherjee 2020; Hubbard et al. 2020 EHR-specific) are uncited, and one is by an already-cited author. A phenotyping/biostatistics referee (JAMIA, Biometrics, Statistics in Medicine) will expect Beesley-Mukherjee in particular. Adding these and one sentence distinguishing "we name the failing assumption and bound the bias in a unified coarsening vocabulary" from "they build a corrected estimator for a specific association analysis" closes it without denting the novelty.

## Sibling-series cross-references (internal, present and consistent)
towell2026masked, towell2026synthesis (the consistency-theorem parent for T3), towell2026scrnacoarsening (the spike-in analog used throughout), towell2026spatialcoarsening, towell2026dpcoarsening, towell2026weaksupcoarsening, towell2026mdrelax. All resolve as Zenodo preprints.
