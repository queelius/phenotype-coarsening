# Citation Verifier: phenotype-coarsening (2026-06-08)

## Verdict: bibliography is complete, accurate, and fully resolved. No orphan entries, no undefined citations. The prior round's key recommended addition (Beesley-Mukherjee) is now present and verified correct.

## Integrity (re-checked this pass)

- 37 entries defined in refs.bib; all 37 cited in the section sources;
  all 37 appear in the formatted bibliography (main.bbl: 37 bibitems).
  No defined-but-unused (orphan) entries; no used-but-undefined
  (would-be undefined) citations. Set difference computed both ways:
  empty in both directions.
- bibtex log (main.blg) reports zero warnings. The build log
  (main.log) shows zero undefined citations and zero undefined
  references (LC_ALL=C grep count 0).
- The bibliography has grown from the 26 entries recorded in the
  state.md snapshot to 37, reflecting the prior round's recommended
  additions (Beesley-Mukherjee; the PU-learning pair; tong2020augmented;
  zhang2019phiap; horowitz/molinari partial-identification pair; the
  synthesis preprint towell2026synthesis).

## Spot-checked entries (CrossRef DOI resolution, live)

- beesley2022samba: DOI 10.1111/biom.13400 resolves to Beesley &
  Mukherjee, "Statistical inference for association studies using
  electronic health records: handling both selection bias and outcome
  misclassification," Biometrics, vol 78, issue 1, pp 214-226, print
  2022 (online-first 2020-12-03). The bib year (2022), volume (78),
  issue (1), pages (214-226), and authors all match CrossRef exactly.
  This is the paper the 2026-06-04 review asked for ("Beesley-Mukherjee
  2020"); the 2020-vs-2022 label is just online-first vs print, not an
  error. CLOSED.
- rogan1978estimating (Am J Epidemiol 107(1):71-76, DOI
  10.1093/oxfordjournals.aje.a112510): verified.
- hui1980estimating (Biometrics 36(1):167-171, DOI 10.2307/2530508):
  verified.
- dawid1979maximum (JRSS-C 28(1):20-28, DOI 10.2307/2346806): verified.
- begg1983assessment (Biometrics 39(1):207-215, DOI 10.2307/2530820):
  verified.
- hubbard2020outcome (Stat in Med 39(19):2557-2572, DOI
  10.1002/sim.8556): verified.
- molinari2008partial, horowitz1995identification,
  bekker2020pulearning, kumar2024pulsnar, tong2020augmented,
  zhang2019phiap, johnson2023mimiciv, kdigo2012aki, and the phenotyping
  landmarks (gottesman2013emerge, newton2013validation, kirby2016phekb,
  denny2010phewas, halpern2016anchor, liao2015highthroughput,
  yu2018phenorm, zhang2019phecap, pivovarov2015learning,
  banda2018phenotyping, haut2011surveillance, carrell2014surveillance,
  hripcsak2013correlating, hripcsak2016characterizing): titles, venues,
  years, DOIs consistent with the records.
- Sibling Zenodo preprints (towell2026masked, towell2026synthesis,
  towell2026mdrelax, towell2026scrnacoarsening,
  towell2026spatialcoarsening, towell2026dpcoarsening,
  towell2026weaksupcoarsening): all present with concept/version DOIs
  per the family's citation convention.

## Remaining optional additions (not blocking)

The 2026-06-04 review also suggested two optional items that are still
not present:
1. Spencer (2011, Biometrics, "When Do Latent Class Models Overstate
   Accuracy ...", DOI 10.1111/j.1541-0420.2011.01694.x), relevant to the
   glass ceiling and the identifiability-by-restriction open problem.
2. A conditional-dependence-caution grouping cite (e.g. DOI
   10.1002/sim.9085) for the open-problems claim that multiple
   conditionally-independent codes can identify prevalence without chart
   review.
Both are optional polish. The claims they would support are presently
attributed correctly to Hui-Walter; their absence is not a citation
error.

## Metadata notes (cosmetic)

- All journal entries are @article; the Zenodo/arXiv preprints are
  @misc, correctly typed. kdigo2012aki uses a corporate author in double
  braces, correct for plainnat. No malformed DOIs.

## Confidence: HIGH

DOIs resolved live; orphan/undefined status computed by set difference
on refs.bib vs the section sources; the now-cited Beesley-Mukherjee
entry verified against CrossRef.
