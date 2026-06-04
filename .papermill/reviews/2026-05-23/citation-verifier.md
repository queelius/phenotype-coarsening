# Citation verifier

## Method

Cross-checked refs.bib against in-text citations; checked DOIs against known publication data; flagged missing canonical references.

## Findings

### CRITICAL: Rogan-Gladen 1978 missing

The deconvolution estimator at identifiability.tex eq (10) is the Rogan-Gladen 1978 estimator. Not cited. This is the canonical reference for prevalence adjustment under known sens/spec. Missing this is a serious citation gap.

Suggested entry:
```
@article{rogan1978estimating,
  title = {Estimating prevalence from the results of a screening test},
  author = {Rogan, Walter J. and Gladen, Beth},
  journal = {American Journal of Epidemiology},
  volume = {107},
  number = {1},
  pages = {71--76},
  year = {1978},
  doi = {10.1093/oxfordjournals.aje.a112510}
}
```

Cite at eq:deconvolve (identifiability.tex line 112) and in the discussion's prior-work paragraph.

### CRITICAL: verification-bias literature missing

The case-mix-gap corollary IS a verification-bias result. The canonical citation is Begg, Greenes 1983 Biometrics. Hubbard et al 2020 Stat Med treats the modern phenotyping-specific version.

Suggested entries:
```
@article{begg1983assessment,
  title = {Assessment of diagnostic tests when disease verification is subject to selection bias},
  author = {Begg, Colin B. and Greenes, Robert A.},
  journal = {Biometrics},
  volume = {39},
  number = {1},
  pages = {207--215},
  year = {1983},
  doi = {10.2307/2530820}
}

@article{hubbard2020outcome,
  title = {Statistical methods for outcome misclassification in observational studies with multiple data sources},
  author = {Hubbard, Rebecca A. and ...},
  journal = {Statistics in Medicine},
  year = {2020}
  note = {verify full bibliographic record}
}
```

The Hubbard entry is approximate; the verifier should look up the exact reference before final submission.

### MAJOR: Allman-Matias-Rhodes 2009 on latent class identifiability

A modern identifiability reference (Annals of Statistics) that is the standard cite for finite-mixture/latent-class identifiability via Kruskal rank. The paper's T1 / T2 results sit in this territory. Adding the citation in the background or identifiability section would help.

```
@article{allman2009identifiability,
  title = {Identifiability of parameters in latent structure models with many observed variables},
  author = {Allman, Elizabeth S. and Matias, Catherine and Rhodes, John A.},
  journal = {The Annals of Statistics},
  volume = {37},
  number = {6A},
  pages = {3099--3132},
  year = {2009},
  doi = {10.1214/09-AOS689}
}
```

### MAJOR: differential misclassification ancestor

Bross 1954 is the original differential-misclassification result; Greenland 1980 AJE is the standard reference. The bias bound in T4 is conceptually in this line. Not citing weakens the prior-art positioning.

```
@article{bross1954misclassification,
  title = {Misclassification in 2 x 2 tables},
  author = {Bross, Irwin},
  journal = {Biometrics},
  volume = {10},
  number = {4},
  pages = {478--486},
  year = {1954},
  doi = {10.2307/3001619}
}

@article{greenland1980effect,
  title = {The effect of misclassification in the presence of covariates},
  author = {Greenland, Sander},
  journal = {American Journal of Epidemiology},
  volume = {112},
  number = {4},
  pages = {564--569},
  year = {1980},
  doi = {10.1093/oxfordjournals.aje.a113025}
}
```

### MAJOR: Halpern 2016 - verify DOI

Halpern, Horng, Choi, Sontag 2016 (cited as halpern2016anchor) is correctly cited with DOI 10.1093/jamia/ocw011 for the JAMIA version. Verified.

### MAJOR: four sibling papers cited as "manuscript in preparation"

```
towell2026masked
towell2026mdrelax
towell2026scrnacoarsening
towell2026spatialcoarsening
towell2026phenotypecoarsening (self-cite, "this paper, full version")
towell2026dpcoarsening
towell2026weaksupcoarsening
```

Six of seven Towell entries are "manuscript in preparation". This is honest but is a vulnerability for JAMIA submission. JAMIA reviewers will weight unpublished siblings less than published ones. Two options:
1. Get the sibling papers onto arXiv with stable IDs before submission, so the citations point to a reproducible artifact.
2. Restructure the prose to depend less on the siblings, so that the citations are framed as "see also (parallel work)" rather than as load-bearing.

Note: the self-cite "this paper, full version" entry (towell2026phenotypecoarsening) is structurally problematic; see prose-auditor for the suggested fix.

### MINOR: Pivovarov 2015 et al

```
@article{pivovarov2015learning,
  title = {Learning probabilistic phenotypes from heterogeneous EHR data},
  author = {Pivovarov, Rimma and Perotte, Adler J. and Grave, Edouard and Angiolillo, John and Wiggins, Chris H. and Elhadad, Noemie},
  journal = {Journal of Biomedical Informatics},
  volume = {58},
  pages = {156--165},
  year = {2015},
  doi = {10.1016/j.jbi.2015.10.001}
}
```

The doi is correct (verified via online lookup of the paper). Author name "Noemie Elhadad" is correctly listed.

### MINOR: Zhang 2019 PheCAP author list

```
@article{zhang2019phecap,
  title = {High-throughput phenotyping with electronic medical record data using a common semi-supervised approach (PheCAP)},
  author = {Zhang, Yichi and Cai, Tianrun and ... and Liao, Katherine P.},
  ...
}
```

Author list is long (correctly so) but verify in BibTeX rendering that all names appear correctly. Minor.

### MINOR: Hripcsak-Albers 2013 vs Hripcsak 2011

Hripcsak, Knirsch, Zhou, Wilcox, Melton 2011 (JAMIA) is "Bias associated with mining electronic health records" and is a more direct source for many surveillance-bias claims than the 2013 piece currently cited. Consider adding both.

### MINOR: missing OMOP CDM / OHDSI cite

The paper mentions OHDSI once (hripcsak2016characterizing). For a JAMIA audience, citing the OMOP CDM canonical reference (Overhage et al 2012 JAMIA) would help anchor the framework to the dominant clinical-data model.

```
@article{overhage2012common,
  title = {Validation of a common data model for active safety surveillance research},
  author = {Overhage, J. Marc and Ryan, Patrick B. and Reich, Christian G. and Hartzema, Abraham G. and Stang, Paul E.},
  journal = {Journal of the American Medical Informatics Association},
  volume = {19},
  number = {1},
  pages = {54--60},
  year = {2012},
  doi = {10.1136/amiajnl-2011-000376}
}
```

Not strictly required.

## Bibliography integrity summary

- 26 entries defined, 26 cited; no orphans, no missing.
- All DOIs spot-checked are correct.
- The Towell self-cite and the six "manuscript in preparation" entries are honest but a vulnerability.
- Missing critical citations: Rogan-Gladen 1978 (P0, must add), Begg-Greenes 1983 (P0), Hubbard 2020 (P0).
- Missing recommended citations: Allman-Matias-Rhodes 2009 (P1), Bross 1954 + Greenland 1980 (P1), Hripcsak 2011 (P2), Overhage 2012 (P2).
