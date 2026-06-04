# Citation Verifier Report (2026-05-27)

## Scope

Re-verify the bibliography after the addition of Rogan-Gladen 1978, Begg-Greenes 1983, and Hubbard 2020. Check that each in-text citation resolves, that the new entries are correctly formatted, and that the self-cite situation is consistent with what the paper claims.

## New entries verification

refs.bib now has 29 entries (was 26 at 2026-05-23). The three new entries are:

### Rogan-Gladen 1978 (refs.bib line 80 to 89)

- title: "Estimating prevalence from the results of a screening test"
- authors: Rogan, Walter J. and Gladen, Beth
- journal: American Journal of Epidemiology, 107(1), pages 71 to 76, 1978
- DOI: 10.1093/oxfordjournals.aje.a112510

Verified correct against the canonical reference.

In-text uses: identifiability.tex:114, introduction.tex:74, discussion.tex:14. Three uses, all appropriate (point-of-use, prior-work, literature positioning).

### Begg-Greenes 1983 (refs.bib line 91 to 100)

- title: "Assessment of diagnostic tests when disease verification is subject to selection bias"
- authors: Begg, Colin B. and Greenes, Robert A.
- journal: Biometrics, 39(1), pages 207 to 215, 1983
- DOI: 10.2307/2530820

Verified correct.

In-text uses: discussion.tex:37, introduction.tex:84. Two uses, both appropriate.

### Hubbard 2020 (refs.bib line 102 to 111)

- title: "Statistical methods for outcome misclassification in observational studies with multiple data sources"
- authors: Hubbard, Rebecca A. and Tong, Jiayi and Duan, Rui and Chen, Yong
- journal: Statistics in Medicine, 39(19), pages 2557 to 2572, 2020
- DOI: 10.1002/sim.8556

Verified correct.

In-text uses: discussion.tex:43, introduction.tex:85. Two uses, both appropriate.

Status: C1 and C5 from 2026-05-23 are genuinely closed at the citation level. Three new citations are added correctly, formatted consistently with the rest of the bibliography, and used at appropriate points in the text.

## Cite resolution check

Count of in-text citations (citet, citep, citealp): grep across sections/*.tex.

```
banda2018phenotyping: 1
begg1983assessment: 2
carrell2014surveillance: 2
dawid1979maximum: 4
denny2010phewas: 2
gill1997coarsening: 1
gottesman2013emerge: 2
halpern2016anchor: 3
haut2011surveillance: 2
heitjan1991ignorability: 1
hripcsak2013correlating: 2
hripcsak2016characterizing: 1
hubbard2020outcome: 2
hui1980estimating: 4
johnson2023mimiciv: 2
kirby2016phekb: 3
liao2015highthroughput: 2
newton2013validation: 1
pivovarov2015learning: 2
rogan1978estimating: 3
towell2026dpcoarsening: 1
towell2026masked: 4
towell2026mdrelax: 2
towell2026phenotypecoarsening: 1
towell2026scrnacoarsening: 8
towell2026spatialcoarsening: 3
towell2026weaksupcoarsening: 1
yu2018phenorm: 2
zhang2019phecap: 2
```

All 29 refs.bib entries are cited at least once. No undefined citation keys appear in main.log.

Status: cite resolution is clean.

## Self-cite situation

### V1 (Major, carryover from 2026-05-23 M10): "(this paper, full version)" self-cite still present.

Location: refs.bib line 55 to 60; identifiability.tex line 173.

The entry:
```
@article{towell2026phenotypecoarsening,
  title = {Electronic phenotyping as coarsening at random: identifiability of clinical states from diagnosis codes (this paper, full version)},
  author = {Towell, Alexander},
  journal = {This paper, manuscript in preparation},
  year = {2026}
}
```

The state file notes the self-cite was retained. The bibliography entry will appear in the printed reference list and a JAMIA reviewer will see a strange "this paper, manuscript in preparation" entry. JAMIA may flag this.

Suggestion as before: either drop the entry and inline the multi-code claim, or rename it to a distinct manuscript title.

Severity: Major for JAMIA, Minor for AMIA/CHIL/ML4H.

## Sibling papers still cited as "manuscript in preparation"

### V2 (Major, carryover from 2026-05-23 M13): Six sibling Towell papers still "manuscript in preparation".

Locations: refs.bib for towell2026masked, towell2026mdrelax, towell2026scrnacoarsening, towell2026spatialcoarsening, towell2026dpcoarsening, towell2026weaksupcoarsening.

All six are load-bearing (cited at multiple points; towell2026scrnacoarsening is cited 8 times, towell2026masked 4 times, towell2026spatialcoarsening 3 times). A JAMIA reviewer will not be able to verify any of these.

Suggestion: get the sibling papers onto arXiv with stable IDs before JAMIA submission. The state file's submission strategy gates JAMIA on the MIMIC-IV application; the sibling-paper arXiv deposit is a parallel prerequisite.

Severity: Major for JAMIA, Minor for AMIA/CHIL/ML4H (where preprint-conditional citations are routine).

## Other carryover findings still outstanding

### V3 (Minor, carryover from 2026-05-23 M12): Allman-Matias-Rhodes 2009 missing.

The standard modern reference for finite-mixture / latent-class identifiability. T1 and T2 sit in this territory and the citation would substantively strengthen the identifiability framing.

### V4 (Minor, carryover from 2026-05-23 M6): Bross 1954 and Greenland 1980 differential-misclassification ancestors missing.

T4 is in this lineage; the citations would substantively position the bias-bound contribution.

### V5 (Suggestion, carryover from 2026-05-23 suggestion 2): Hripcsak 2011 surveillance-bias source not added.

Hripcsak (2011) "Distinguishing screening from diagnostic mammography" JAMIA is a more direct surveillance-bias-in-phenotyping source than the 2013 piece currently cited.

## Summary

The three load-bearing 2026-05-23 critical citation gaps (Rogan-Gladen, Begg-Greenes, Hubbard) are genuinely closed. Two majors carry over (self-cite, sibling-paper preprint status) and three suggestions/minors remain (Allman-Matias-Rhodes, Bross/Greenland, Hripcsak 2011).

Severity: 0 critical, 2 major (carryover), 2 minor (carryover), 1 suggestion (carryover).
