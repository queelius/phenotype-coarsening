# Citation Verifier: phenotype-coarsening

## Verdict: bibliography is accurate and resolves; recommend adding 2 to 3 recent biostatistics neighbors.

## Accuracy of existing entries (spot-checked via CrossRef DOI resolution)
- rogan1978estimating (Am J Epidemiol 107(1):71-76, DOI 10.1093/oxfordjournals.aje.a112510): verified, author Rogan, 1978.
- hui1980estimating (Biometrics 36(1):167-171, DOI 10.2307/2530508): verified, 1980.
- begg1983assessment (Biometrics 39(1):207-215, DOI 10.2307/2530820): verified; title "Assessment of Diagnostic Tests When Disease Verification is Subject to Selection Bias," author Begg, 1983.
- dawid1979maximum (JRSS-C 28(1):20-28, DOI 10.2307/2346806): correct (Dawid-Skene EM).
- kirby2016phekb (JAMIA, DOI 10.1093/jamia/ocv202), halpern2016anchor (JAMIA, DOI 10.1093/jamia/ocw011), denny2010phewas (Bioinformatics, DOI 10.1093/bioinformatics/btq126), johnson2023mimiciv (Sci Data, DOI 10.1038/s41597-022-01899-x): all correct.
- hubbard2020outcome (Stat in Med 39(19):2557-2572, DOI 10.1002/sim.8556): correct.
- yu2018phenorm, zhang2019phecap, liao2015highthroughput, gottesman2013emerge, newton2013validation, banda2018phenotyping, pivovarov2015learning, haut2011surveillance, carrell2014surveillance, hripcsak2013correlating, hripcsak2016characterizing, kdigo2012aki: titles/venues/DOIs consistent with the records.
- Sibling Zenodo preprints (towell2026*) resolve.

The build log shows zero undefined citations; every \citep resolves.

## Missing references (verified to exist; recommended additions)
1. Beesley, Mukherjee (2020), "Statistical inference for association studies using electronic health records: handling both selection bias and outcome misclassification," Biometrics, DOI 10.1111/biom.13400. (closest recent neighbor; confirmed uncited via grep)
2. Hubbard, Tong, Duan, Chen (2020), "Reducing Bias Due to Outcome Misclassification for Epidemiologic Studies Using EHR-derived Probabilistic Phenotypes," Epidemiology, DOI 10.1097/ede.0000000000001193. (same author as the cited hubbard2020outcome; EHR-phenotype-specific; confirmed uncited)
3. Spencer (2011), "When Do Latent Class Models Overstate Accuracy for Diagnostic and Other Classifiers in the Absence of a Gold Standard?", Biometrics, DOI 10.1111/j.1541-0420.2011.01694.x. (relevant to the glass-ceiling and the identifiability-by-restriction open problem; confirmed uncited)

Optional grouping cite for the latent-class-with-conditional-dependence caution (e.g., DOI 10.1002/sim.9085, "continued controversy in using latent class models for estimating diagnostic accuracy") to support the open-problems statement that multiple conditionally-independent codes can identify prevalence without chart review.

## Metadata notes (cosmetic)
- All entries are @article; the phenotyping landmarks that are journal articles (JAMIA, BMJ, Nature Protocols) are correctly typed. kdigo2012aki uses a corporate author in double braces, which is correct for plainnat.
- No malformed DOIs detected.

## Confidence: HIGH (DOIs resolved live; uncited status confirmed by grep on refs.bib).
