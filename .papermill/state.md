---
schema_version: 1
paper_type: theory-with-simulation
stage: scaffold-v0.2-post-review
created: 2026-05-22
updated: 2026-06-08
authors:
  - name: Alexander Towell
    email: lex@metafunctor.com
    orcid: 0000-0001-6443-9897
    affiliation: Department of Computer Science, Southern Illinois University Edwardsville
working_title: "Electronic phenotyping as coarsening at random: identifiability of clinical states from diagnosis codes"
target_venues:
  - name: JAMIA
    rank: 1
    rationale: Primary venue for biomedical informatics methodology; phenotyping is core JAMIA territory; eMERGE, PheKB, PheNorm, PheCAP all appeared in JAMIA; ideal home for the framework as a methodology contribution.
    format: research article (around 5000 words plus figures/tables)
    audience: informatics methodologists and phenotyping practitioners
  - name: AMIA Annual Symposium
    rank: 2
    rationale: Informatics community for phenotyping algorithms; conference format matches current draft length; gets feedback before journal submission.
    format: full paper (around 10 pages)
    audience: informatics practitioners
  - name: CHIL
    rank: 3
    rationale: Conference on Health Inference and Learning; identifiability framework is well-suited; ML-oriented health audience receptive to theory plus simulation.
    format: conference paper
    audience: ML4H methodologists
  - name: ML4H
    rank: 4
    rationale: Machine Learning for Health workshop or proceedings; framework-oriented theory paper with simulation fits; archival proceedings track.
    format: workshop or proceedings paper
    audience: ML4H community
  - name: Biometrics
    rank: 5
    rationale: Methodological statistics journal; closest match for masked-data identifiability plus EHR application if positioned more theoretically; longer review cycle.
    format: research article
    audience: biostatisticians
  - name: Statistics in Medicine
    rank: 6
    rationale: Methodological biostatistics journal; chart-review calibration estimator is on-scope; broader audience than Biometrics.
    format: research article
    audience: biostatisticians
  - name: npj Digital Medicine
    rank: 7
    rationale: Broader digital health audience; emphasizes practical implications for phenotyping practice; open-access; high visibility.
    format: brief communication or article
    audience: clinical informatics and digital medicine
venue_strategy: |
  Lead with JAMIA (rank 1) once MIMIC-IV application is in place. If primary cycle would take too long, submit to AMIA Annual Symposium first (rank 2) for early peer feedback, then expand to a JAMIA version. CHIL and ML4H are ML-community-receptive fallbacks. Biometrics and Statistics in Medicine remain options if the paper grows more theoretical.
artifact_layout:
  main_tex: main.tex
  sections_dir: sections/
  bibliography: refs.bib
  build: make paper
  simulation: scripts/run.R (writes results.rds)
  figures: scripts/figures.R (writes figures/*.pdf)
sections:
  - file: introduction.tex
    purpose: Motivation, masked-data bridge, prior work, contributions list.
  - file: background.tex
    purpose: Brief masked-data primer; C1/C2/C3 conditions.
  - file: translation.tex
    purpose: Translation table mapping coding mechanism to masking mechanism.
  - file: identifiability.tex
    purpose: T1 glass ceiling, T2 chart-review identifiability, T3 code-frequency consistency.
  - file: methodology.tex
    purpose: T4 informative-coding bias bound plus case-mix corollary.
  - file: validation.tex
    purpose: Simulation studies (four) with actual numbers; MIMIC-IV application plan.
  - file: discussion.tex
    purpose: Prior-art positioning, limitations, comparison with Hui-Walter and Dawid-Skene.
  - file: conclusion.tex
    purpose: Brief recap and forward look.
theorems:
  - id: T1
    label: thm:glass-ceiling
    location: identifiability.tex
    statement: (prevalence, sensitivity, specificity) jointly non-identifiable from code data alone.
    status: stated; proof is a sketch citing the framework series.
  - id: T2
    label: thm:identifiability-chart
    location: identifiability.tex
    statement: chart-reviewed subsample covering both Y classes identifies the coding model, restoring prevalence identifiability.
    status: stated; proof is a sketch citing the framework series.
  - id: T3
    label: thm:code-total
    location: identifiability.tex
    statement: a fitted model reproduces marginal code frequencies exactly at an interior MLE; marginal-fit checks cannot detect prevalence bias.
    status: stated; proof is a sketch citing the framework series.
  - id: T4
    label: thm:bias-informative
    location: methodology.tex
    statement: code-only bias bounded by severity-coding correlation; calibrated-estimator residual bias bounded by case-mix gap.
    status: stated with corollary cor:casemix; proof is a sketch.
simulation:
  driver: scripts/run.R
  output: results.rds
  seed: 20260521
  studies:
    - study1: T1 confirmation, 160 (pi, sens, spec) triples reproducing the same marginal code frequency.
    - study2: T2 chart-calibrated RMSE falls monotonically with reviewed subsample size m.
    - study3: T3 code-frequency residual at machine precision; deliberately wrong-prevalence model still reproduces code frequency exactly.
    - study4a: T4 code-only bias swings with severity-coding correlation; calibrated estimator stays near-unbiased.
    - study4b: case-mix gap study; severity-biased review creates sensitivity gap and residual bias for subsample-reference estimator.
prior_art_caution: |
  Hui & Walter 1980 and Dawid & Skene 1979 are the latent-class ancestors and must be cited.
  eMERGE / PheKB / Halpern anchor-and-learn are large phenotyping efforts (already cited).
  Likely additional references to check: Banda et al. phenotyping review, Pivovarov et al. automated phenotyping,
  Yu et al. PheNorm, Liao et al. high-throughput phenotyping, Wei et al. PheCAP, Carrell et al. surveillance bias,
  Hripcsak & Albers EHR data quality.
sibling_papers:
  - key: towell2026scrnacoarsening
    domain: scRNA-seq zero inflation (precursor)
  - key: towell2026spatialcoarsening
    domain: spatial transcriptomics cell-type deconvolution (structural template)
  - key: towell2026dpcoarsening
    domain: differential privacy (sibling, add to refs.bib if missing)
  - key: towell2026weaksupcoarsening
    domain: programmatic weak supervision (sibling, add to refs.bib if missing)
review_history:
  - date: 2026-05-22
    reviewer: papermill multi-agent (area chair synthesis with logic-checker, methodology-auditor, prose-auditor, novelty-assessor, citation-verifier, format-validator passes)
    findings:
      critical:
        - C1 code-only bias sign framing inconsistent with sim
        - C2 discussion does not reference full sibling series
        - C3 mainstream phenotyping prior-art coverage thin
        - C4 T1 and T4 proofs defer to unpublished framework paper
      important:
        - I1 T1 proof has opaque pi notation
        - I2 T2 condition (ii) not formalized
        - I3 T4 first-order language misleading; use MVT
        - I4 T3 proof promises unstated multi-code result
        - I5 Study 4b sensitivity gap saturation unexplained
        - I6 abstract says MIMIC-IV described; should say outlined
      addressed:
        critical: [C1, C2, C3, C4]
        important: [I1, I2, I3, I4, I5, I6]
      deferred:
        - I7 hyperref bookmark warnings (cosmetic)
        - P1 abstract length for JAMIA 250-word limit
        - P2 conclusion as synthesis rewrite
        - P3 enlarge red marker in glass-ceiling figure
        - P4 12-page conference compression
  - date: 2026-06-08
    reviewer: papermill multi-agent (area chair plus seven lenses run directly; Task sub-agent tool unavailable in environment)
    recommendation: minor-revision
    findings:
      critical: []
      major: []
      minor:
        - M1 JAMIA abstract ~278 words over 250-word limit; paper 23 pages long for JAMIA research article
        - M2 multi-code code-frequency consistency (T3) asserted not shown ("we omit the algebra here")
        - M3 notation q vs Cbar and sens vs sens_coh
        - M4 m=50 chart-review cell variance-dominated on 200 replicates
      suggestions:
        - S1 interim semi-synthetic or public-data demonstration while MIMIC-IV credentialing pending
        - S2 optional Spencer 2011 and conditional-dependence-caution cite for identifiability-by-restriction open problem
        - S3 forward pointer from thm:identifiability-chart to the oracle-free reference paragraph
      resolved_since_2026-06-04:
        - prior Major closed: closest recent biostatistics neighbors now cited (beesley2022samba DOI 10.1111/biom.13400 CrossRef-verified; PU-learning pair bekker2020pulearning + kumar2024pulsnar; tong2020augmented; zhang2019phiap)
    verification:
      build: make paper clean, 0 undefined (LC_ALL=C grep), 23 pages, em-dash free
      bibliography: 37 entries, all cited, all in bbl, 0 orphans, 0 undefined, 0 bibtex warnings
      numerics: T1 admissibility + sens=4.91 counterexample, T2 Rogan-Gladen recovery (pi=0.12 exact), T3 consistency incl wrong-prevalence check, T4 Jensen bound across b1 grid, and all four sim tables reproduced against results.rds / results_table4a_deployable.rds / results_oracle_check.rds
    review_dir: .papermill/reviews/2026-06-08/
next_action: |
  Tier 1 remaining: MIMIC-IV real-data application (BLOCKED: requires PhysioNet
  credentialed access, not yet held). Interim fully-synthetic-only demo assessed
  and declined 2026-06-08 (would not be a real-data point; existing simulation
  already sweeps the relevant regimes; see README Status). The KDIGO/AKI
  chart-proxy plan in validation.tex is ready to run once credentialing lands.
  Addressed 2026-06-08 (no new review round): M2 (multi-code T3 now proved via the
  joint code-pattern multinomial argument, no longer asserted); T1 glass-ceiling
  theorem statement now carries the interior / full-support regularity condition
  its proof uses; S3 forward pointer from thm:identifiability-chart to the
  oracle-free reference (par:oracle-free) added. Remaining minor items: M1 abstract
  trim (~278 -> ~250 words) and length compression for JAMIA; M3 q/Cbar and
  sens/sens_coh notation unification; M4 optional extra replicates at the m=50
  chart-review cell; S2 optional Spencer 2011 / conditional-dependence cite.
  Tier 3 polish: abstract trim, conclusion synthesis, conference compression.
  Once MIMIC-IV pass lands, submit to JAMIA (rank 1).
notes: |
  Build status post-review (2026-05-22): make paper succeeds, 20 pages, no undefined refs, em-dash free.
  Simulation results.rds regenerated successfully.
  Bibliography expanded from 15 to 26 entries: added two sibling papers (dpcoarsening, weaksupcoarsening) and
  nine phenotyping references (Banda 2018, Pivovarov 2015, Yu PheNorm 2018, Liao 2015, Zhang PheCAP 2019,
  Carrell 2014, Hripcsak-Albers 2013, Hripcsak OHDSI 2016, Newton 2013).
  T1 and T4 proofs are now self-contained.
  Discussion acknowledges the full sibling series (scrna, spatial, dp, weaksup).
  Cite key resolution: 26/26 verified.
---

# Paper state: phenotype-coarsening

## Central claim

Electronic phenotyping (inferring a latent clinical state $Y$ from
coarse administrative data such as ICD codes) is an instance of
masked-data identifiability. The true state is the latent cause; the
observed code set is the candidate set; the coding process is the
masking mechanism; a chart-reviewed patient is a singleton candidate
set. Within this framework, three identifiability facts follow:

1. From code data alone, prevalence is non-identifiable (glass ceiling,
   T1): the joint constraint on $(\pi, \text{sens}, \text{spec})$ is a
   rank-one system in three unknowns.
2. A chart-reviewed subsample covering both $Y$ classes identifies the
   coding model and restores cohort prevalence (T2), analogous to the
   ERCC spike-in theorem in scRNA-seq.
3. A fitted model reproduces the marginal code frequency exactly at any
   interior MLE (T3), so marginal-fit diagnostics are blind to
   prevalence bias.

The load-bearing point is that coding is informative: sicker patients
are coded more, billing incentives shape codes, detection intensity
tracks severity. The coarsening-at-random condition that fails is
exactly C2, non-informative coding. The bias bound (T4) controls the
code-only estimator's bias by the severity-coding correlation and the
calibrated estimator's residual bias by the case-mix gap between the
chart-reviewed subsample and the cohort.

## Novelty (positioning, not invention)

Latent-class estimation of disease status without a gold standard is
old. Hui & Walter (1980) gave the foundational two-test latent-class
model; Dawid & Skene (1979) gave the EM ancestor; eMERGE and PheKB
are large code-based phenotyping efforts; Halpern's anchor-and-learn
uses high-precision signals analogous to singletons. We do not claim
to invent any of this.

Our contribution is narrower and structural:

- A masked-cause unification that places code-based phenotyping inside
  the coarsening-at-random framework of Heitjan and Rubin and Gill et
  al., with a precise translation table.
- The C1-C2-C3 classification of phenotyping failure modes, identifying
  informative coding as the C2 violation.
- An explicit glass-ceiling construction with a solution surface and
  rank argument.
- An informative-coding bias bound (T4) controlled by the
  severity-coding correlation, plus a case-mix gap corollary controlling
  residual bias of chart-review-calibrated estimators.

The same masked-data lens has been applied in this series to scRNA-seq
zero inflation, spatial transcriptomics deconvolution, differential
privacy, and programmatic weak supervision; phenotyping is the
healthcare-data instance.

## Stage

scaffold-v0.1. Substantive content in all sections; simulation runs;
validation.tex reports actual numbers; proofs are sketches that cite
the framework series for shared apparatus.

## What is open

- Tighter proofs (especially T1 glass ceiling construction and T4 bias
  bound).
- Prior-art coverage check (Banda, Pivovarov, Yu PheNorm, Liao, Wei
  PheCAP, Carrell, Hripcsak-Albers).
- Discussion sweep to acknowledge all four sibling papers in the series.
- MIMIC-IV real-data application (Tier 1, pending PhysioNet access).
- Compression toward 12-page conference target (Tier 3 polish).
