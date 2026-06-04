# Hand-off: phenotype-coarsening paper

**Last touched**: 2026-05-21. Initial scaffold v0.1 at `main.pdf`.
Conference-format draft, builds clean, em-dash free, simulation run.

This is the fourth paper in the masked-data framework series, after
`~/github/papers/scrna-coarsening/` (scRNA-seq) and
`~/github/papers/spatial-coarsening/` (spatial transcriptomics, the
structural template for this repo).

---

## 1. What this paper is

**Working title**: *Electronic phenotyping as coarsening at random:
identifiability of clinical states from diagnosis codes.*

**Central claim**: electronic phenotyping (inferring a latent clinical
state from ICD diagnosis codes, procedure codes, and medications) is
mathematically isomorphic to the masked-data series-system
identifiability problem. The true clinical state is the latent cause,
the observed code set is the candidate set, the coding process is the
masking mechanism, and a chart-reviewed (clinician-adjudicated) patient
is a singleton candidate set.

**The load-bearing point**: coding is informative. Sicker patients are
coded more, billing incentives shape codes, so the C2 condition
(non-informative coding) is exactly what fails. This is why code-only
prevalence estimates are biased and why chart review is a necessity
rather than a luxury.

**Conference target**: 12-page health-informatics venues (AMIA, ML4H,
CHIL). The current draft builds at 18 pages with substantive content
in all sections, four data tables, and two figures; trimming to 12
pages is a polish task (see Tier 3 below).

---

## 2. Current state

### Paper scaffold (`papers/phenotype-coarsening/`)
- `main.tex`: top-level, preamble copied verbatim from spatial-coarsening
- `sections/` (all substantive):
  - `introduction.tex` (motivation + framework + prior work + contributions)
  - `background.tex` (brief masked-data primer; C1/C2/C3)
  - `translation.tex` (the bridge + translation table)
  - `identifiability.tex` (T1 glass ceiling, T2 chart-review
    identifiability, T3 code-frequency consistency)
  - `methodology.tex` (T4 informative-coding bias bound + case-mix
    corollary)
  - `validation.tex` (simulation with actual numbers + MIMIC-IV plan)
  - `discussion.tex` (prior-art positioning, limitations)
  - `conclusion.tex`
- `refs.bib`: coarsening foundations (Heitjan-Rubin, Gill et al.), the
  Towell framework series, latent-class ancestors (Hui-Walter,
  Dawid-Skene), phenotyping references (Denny, Gottesman, Kirby,
  Halpern, Haut-Pronovost, Johnson MIMIC-IV)
- `Makefile`, `README.md`, `CLAUDE.md`
- **Build status**: `make paper` succeeds, 18 pages, no undefined
  references, em-dash free.

### Theorems stated
1. **T1 glass ceiling** (`thm:glass-ceiling`): with an unrestricted
   coding mechanism, (prevalence, sensitivity, specificity) are jointly
   non-identifiable from code data alone. Proof exhibits the solution
   surface explicitly.
2. **T2 identifiability with chart review** (`thm:identifiability-chart`):
   a chart-reviewed subsample covering both Y classes identifies the
   coding model, and cohort prevalence becomes identifiable. Direct
   analog of the ERCC spike-in theorem in scrna-coarsening.
3. **T3 code-frequency consistency** (`thm:code-total`): a fitted model
   reproduces the marginal code frequency exactly at an interior MLE;
   marginal-fit checks cannot detect prevalence bias. Analog of
   cell-total consistency.
4. **T4 bias bound under informative coding** (`thm:bias-informative`):
   code-only bias controlled by the severity-coding correlation;
   `cor:casemix` bounds the calibrated estimator's residual bias by the
   case-mix gap (the ERCC-endogenous analog).

Proofs are sketches that cite the framework series for shared
apparatus, the same pattern spatial-coarsening uses.

### Simulation (`scripts/`)
- `sim.R`: DGP (binary Y, latent severity S, informative coding),
  estimators (code-only, chart-calibrated, oracle), diagnostics. Base
  R only.
- `run.R`: four studies, seed 20260521, writes `results.rds`.
- `figures.R`: writes `figures/glass_ceiling.pdf`,
  `figures/informative_coding.pdf`.
- **Run status**: `Rscript scripts/run.R` succeeds.

### Simulation results (the actual numbers, now in validation.tex)
- **Study 1 (T1)**: cohort with true prevalence 0.12, code frequency
  0.1377; 160 distinct (pi, sens, spec) triples reproduce that code
  frequency, implied prevalence spanning 0.06 to 0.40, all matching to
  machine precision.
- **Study 2 (T2)**: chart-calibrated RMSE falls monotonically with
  reviewed subsample size m, from 0.097 (m=50) to 0.0073 (m=2000);
  code-only RMSE is flat near 0.0177 (it is bias, not sampling error).
- **Study 3 (T3)**: code-frequency residual at the calibrated fit is at
  machine precision; a deliberately wrong-prevalence model still
  reproduces the code frequency exactly.
- **Study 4a (T4)**: code-only bias swings from -0.016 at b1=0 (C2
  holds) to +0.032 at b1=3 (strong informative coding); calibrated
  estimator stays near-unbiased (|bias| < 0.002) throughout.
- **Study 4b (case-mix gap)**: severity-biased review opens a
  sensitivity gap up to 0.036; the subsample-reference calibrated
  estimator inherits a residual bias up to -0.006, the cohort-reference
  estimator stays near zero.

---

## 3. What's left

### Tier 1: needed for submission
- [ ] **Sibling Zenodo deposit (user-action).** Deposit each of the
  five sibling papers (`masked-causes-in-series-systems`,
  `scrna-coarsening`, `spatial-coarsening`, `dp-coarsening`,
  `weaksup-coarsening`, `phenotype-coarsening`) to Zenodo with
  versioned DOIs. Once DOIs are issued, update each sibling's bib
  entry across all five papers (replace `journal = {Manuscript in
  preparation}` with the Zenodo `doi` and `url` fields). This is a
  user-action: requires Zenodo authentication and metadata choice.
- [ ] **MIMIC-IV real-data application.** Described in `validation.tex`
  and listed as pending. The plan: pick a condition with a known
  code-versus-chart discrepancy (acute kidney injury is the suggested
  example, ICD codes undercount lab-defined cases), use a
  lab/physiology rule as the chart-review proxy, fit the coding model,
  deconvolve cohort prevalence, check code-frequency consistency, and
  estimate the case-mix gap. MIMIC-IV requires PhysioNet credentialed
  access. Estimated: 2-3 days once access is in place.
- [ ] **Tighter theorem proofs.** Current proofs are sketches pointing
  to the framework series. The glass-ceiling construction (T1) and the
  informative-coding bound (T4) should be made self-contained in an
  appendix, mirroring scrna-coarsening's `appendix.tex`.

### Tier 2: would strengthen
- [ ] **Multi-code experiments.** `sim.R` already generates an optional
  second coarse feature (procedure code, the `proc = TRUE` path), but
  `run.R` does not yet exercise it. Add a study showing that two
  conditionally independent codes identify prevalence without chart
  review (the Hui-Walter case), and that conditional dependence between
  codes breaks it.
- [ ] **Comparison with a plain Hui-Walter latent-class fit** on the
  same simulated data, to make the "we subsume, not reinvent"
  positioning concrete.

### Tier 3: polish
- [ ] **Compress to the 12-page target.** The draft is 18 pages.
  Candidates: move proof sketches to an appendix, tighten the
  validation tables (some rows could be dropped), shorten the
  per-method paragraphs in `translation.tex` and `discussion.tex`.
- [ ] Conceptual figure of the bridge (latent state -> coding mechanism
  -> candidate set -> chart-review singleton).

---

## 4. Companion repos and the citation pattern

- `~/github/papers/spatial-coarsening/` is the structural template:
  same preamble, same 8-section breakdown, same Makefile targets.
- `~/github/papers/scrna-coarsening/` is the closest precedent for the
  theorem structure. T2 mirrors its spike-in identifiability theorem,
  T3 mirrors its cell-total consistency theorem, and T4's case-mix
  corollary mirrors its ERCC-endogenous gap result.
- `~/github/papers/masked-causes-in-series-systems/` is the foundational
  theory, cited as `towell2026masked`.

Proofs cite the framework series for shared apparatus rather than
re-deriving. This is intentional; keep the pattern when expanding.

---

## 5. Prior-art discipline (important)

Latent-class estimation of disease status without a gold standard has a
deep prior literature. Do NOT claim to invent latent-class phenotyping
or sensitivity/specificity estimation without a gold standard.
`discussion.tex` cites Hui & Walter (1980) and Dawid & Skene (1979) as
the clear ancestors and positions the contribution honestly: the
masked-cause unification, the C1/C2/C3 classification that pinpoints
informative coding as the C2 violation, the explicit glass-ceiling
construction, and the informative-coding bias bound. Keep this framing
in any expansion.

---

## 6. Conventions

- **No em-dashes** anywhere (soul plugin hook blocks file writes with
  U+2014; use commas, colons, periods, parentheses).
- **No vanity counts** as achievement filler (describe the work, not
  page/reference/theorem counts; normal enumeration of T1 to T4 is fine).
- LaTeX, not Quarto/RMarkdown.
- Author: Alexander Towell, lex@metafunctor.com, SIUE Department of
  Computer Science, ORCID 0000-0001-6443-9897.

---

## 7. Quick-start commands

```bash
cd ~/github/papers/phenotype-coarsening
make paper      # build main.pdf
make sim        # run the simulation, write results.rds
make figures    # regenerate figures from results.rds
make clean
```

---

## 8. Status checklist

- [x] Scaffold: substantive sections in all parts, builds clean
- [x] Theorem statements (T1 glass ceiling, T2 chart-review
  identifiability, T3 code-frequency consistency, T4 informative-coding
  bias bound)
- [x] References for primary citations and prior-art ancestors
- [x] Simulation code (base R), runs cleanly
- [x] Simulation run; `validation.tex` reports actual numbers
- [x] Figures generated
- [ ] Theorem proofs (currently sketches)
- [ ] MIMIC-IV real-data application
- [ ] Multi-code / Hui-Walter comparison experiments
- [ ] Compression to 12-page conference target
