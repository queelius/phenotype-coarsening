# Literature context (merged scout output)

## Broad survey

### State of the art in electronic phenotyping

- Rule-based (PheKB, eMERGE algorithms, OHDSI/Atlas phenotype library).
- Semi-supervised: PheNorm (Yu 2018), PheCAP (Zhang 2019), MAP (Liao 2019), SHE-PheTK.
- Anchor learning: Halpern, Horng, Choi, Sontag 2016.
- Probabilistic phenotypes: Pivovarov 2015, Henderson APHRODITE 2017.
- Modern: ATLAS (OHDSI), KESER (Hong et al 2021), neural code embeddings (Choi Med2Vec, BEHRT, ClinicalBERT).
- Federated phenotyping: PaTH network, EHR-CDM-based pipelines.

### Identifiability theory for latent class models (post 2020)

- Allman, Matias, Rhodes (2009 AoS): identifiability of finite mixtures of finite-dimensional multinomials; structural identifiability via Kruskal rank.
- Gu, Xu (2019, 2023): identifiability in restricted latent class models.
- Spantini et al.: posterior identifiability in nonidentified Bayesian models.
- Bonhomme, Jochmans (2016): nonparametric estimation of finite mixtures.
- Recent: Tan, Roy 2022 on prevalence estimation without gold standard.

### Competing approaches

- Noisy label learning (Frenay & Verleysen 2014 survey; Northcutt et al confident learning 2021).
- PU learning (Elkan-Noto 2008, du Plessis-Niu-Sugiyama 2014).
- Data programming / Snorkel (Ratner et al 2016, 2017): the "weak supervision" sibling paper directly engages this.
- Crowdsourcing latent class (Dawid-Skene line: Whitehill 2009; Raykar 2010; Welinder-Perona; Liu-Wang 2012).

### Benchmarks

- MIMIC-III, MIMIC-IV (Johnson 2023, cited): critical-care EHR.
- eICU Collaborative Research Database.
- eMERGE phenotype library: ~150 algorithms with multi-site validation.
- OMOP CDM corpora (HCUP, IBM MarketScan, Optum CDM via OHDSI).
- N3C (National COVID Cohort Collaborative): phenotype validation studies.
- AKI in MIMIC: Bouchard 2020, Sutherland 2015, Hsu 2020 (good MIMIC-IV target).

### Possibly missing reviewer-likely citations

- Rogan, Gladen 1978: the deconvolution estimator. CRITICAL missing.
- Begg, Greenes 1983: verification bias correction.
- Marshall 1990: standard sens/spec adjustment.
- Bross 1954: misclassification bias (the original differential misclassification result).
- Greenland, Lash chapter on misclassification (Modern Epidemiology).
- Hripcsak, Knirsch, Zhou, Wilcox, Melton 2011 (JAMIA): bias and quality in EHR phenotyping. (note: hripcsak2013 IS cited but the 2011 piece is the source for many surveillance-bias claims).
- Wei, Eickhoff, Embi, Denny et al 2017 PheCAP precursor work.
- Henderson et al APHRODITE Bioinformatics 2017.
- Hubbard et al 2020 (Stat Med) on phenotyping algorithm validation under nonignorable verification.
- Albert, Dodd 2004 (Biometrics) on dependence among multiple tests in latent class.

## Targeted prior-art search

### Has anyone framed phenotyping as coarsening-at-random?

No direct precedent for the explicit candidate-set / masked-cause framing applied to phenotyping was located. The closest in spirit are:
- Halpern et al 2016 anchor-and-learn: the anchor concept does the same identifiability job as the singleton, but framed in PU-learning / latent-class terms, not in coarsening-at-random.
- Hubbard et al 2020 on nonignorable verification: explicitly discusses verification bias as a missing-data mechanism that is informative, which is the same conceptual core. The paper should cite this work to position the coarsening contribution against the missing-data verification-bias literature.
- Lash, Fox, Fink 2009 "Applying Quantitative Bias Analysis" treats misclassification under differential mechanisms but does not invoke the CAR framework.

The coarsening-at-random framing per se is novel for phenotyping; the underlying mathematical content (latent prevalence non-identifiability, verification bias) is not.

### Glass-ceiling result

The result that single-code prevalence is not identifiable jointly with sens/spec is "folklore" in epidemiology. The Rogan-Gladen 1978 estimator already assumes sens and spec known, which is the operational form of "non-identifiability without an external source". The explicit non-identifiable solution surface construction is uncommon but not novel as such; what would be novel is the embedding in the coarsening framework via the rank argument. The paper makes this clear, and the framing is honest.

### Bias bound for code-only prevalence as function of severity-coding correlation

Differential misclassification literature (Greenland 1980 AJE; Kristensen 1992; Wacholder 1995) gives general bias formulas but does NOT give a bound parameterized by the rho_S,g(S) severity-coding correlation. The specific bound combining a logistic mean-value-theorem step with the correlation decomposition appears novel as stated, though the result is morally close to a Taylor expansion of E[g(S)] around a reference severity.

Note: the proof step "by Jensen $\E[|S|] \le \sigma_S$" is INCORRECT in general. For a centered random variable, $\E[|S|] \le \sqrt{\E[S^2]} = \sigma_S$, but this requires $\E[S]=0$. The proof should either center S, condition on $\E[S|Y=1] = \mu_{S,1}$ and use $\E[|S - \mu_{S,1}|] \le \sigma_S$ (which then changes the constant term), or be re-stated in terms of variance directly.

### Hui-Walter 1980 and extensions

- Hui-Walter 1980: 2 tests x 2 populations -> identification of sens, spec, prevalence.
- Joseph, Gyorkos, Coupal 1995: Bayesian extension with informative priors.
- Pepe, Janes 2007 (Bcs Bul): critiques of conditional independence assumption.
- Branscum, Gardner, Johnson 2005: hierarchical Bayes versions.
- Albert, Dodd 2004 (Biometrics): consequences of test dependence.

The paper positions itself correctly against Hui-Walter. The Hui-Walter model gives an estimator when no gold standard exists; the present paper gives the structural framework that says when this estimator works and why. The contribution is structural, not algorithmic. Position is honest.

### Halpern anchor-and-learn

The paper says "an anchor is structurally a near-singleton candidate set" which is correct. However the contribution is slightly oversold by phrasing. Halpern's anchors give classification probabilities, not necessarily identifiability of cohort prevalence under informative coding. The mechanism is similar but the goal (classifier vs prevalence estimator) is different. Suggest tightening this language.

### Rogan-Gladen 1978 (CRITICAL)

The deconvolution formula in eq (10):
```
pi_hat = (q - (1 - spec)) / (sens - (1 - spec))
```
is exactly the Rogan-Gladen 1978 estimator (the textbook formula for adjusting apparent prevalence given sens/spec). Not citing this is a serious omission. A JAMIA reviewer or any epidemiologist will flag it immediately. The paper should:
- Cite Rogan, Gladen 1978 AJE (Am J Epidemiol 107:71-76) at eq (10).
- Acknowledge that the calibrated estimator IS Rogan-Gladen applied at the cohort level using subsample-estimated sens/spec.
- Position the contribution as the identifiability theory underneath the estimator, not the estimator itself.

### Verification-bias literature

Begg-Greenes 1983 (Biometrics), Pepe 2003 textbook, Alonzo-Pepe 2005, Hubbard 2020. The case-mix gap corollary IS a special case of verification-bias correction. None of these are cited. Adding Begg-Greenes 1983 + Hubbard 2020 (or similar) is recommended.
