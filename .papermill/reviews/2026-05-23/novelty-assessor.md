# Novelty assessor

## Method

Read all sections; cross-checked novelty claims against the literature context packet. Particular focus on positioning against Hui-Walter 1980, Halpern 2016, the verification-bias literature, and the Rogan-Gladen 1978 estimator.

## Findings

### CRITICAL: Rogan-Gladen 1978 not cited; deconvolution estimator is presented without acknowledging its century-old textbook history

Location: identifiability.tex line 112-117 (eq:deconvolve).

Quoted text:
> "Stage two: with sens and spec identified, eq (5) becomes one equation in the single unknown pi, solved as $\hat\pi = (q - (1-\widehat{\mathrm{spec}}))/(\widehat{\mathrm{sens}} - (1-\widehat{\mathrm{spec}}))$"

Problem: this estimator is Rogan-Gladen 1978 (Am J Epidemiol 107:71-76). It appears in every screening-test epidemiology textbook. The paper presents it without citation, which a JAMIA reviewer will mark as a novelty-positioning failure. The contribution as the paper states it is the masked-data unification + glass-ceiling + bias bounds, NOT a new estimator; failing to cite the standard estimator the paper plugs in makes the contribution look broader than it is.

Suggested fix: cite Rogan-Gladen 1978 at eq (10). State "this is the Rogan-Gladen 1978 estimator with sens and spec supplied by the chart-reviewed subsample instead of being assumed known". This honest framing strengthens rather than weakens the novelty position because it makes the structural / unification contribution stand out.

### CRITICAL: verification-bias literature not engaged

Location: methodology.tex case-mix-gap corollary (line 140-170), discussion.tex prior-work paragraph.

The case-mix-gap corollary IS a special case of verification-bias correction in diagnostic testing (Begg-Greenes 1983 Biometrics; Pepe 2003 textbook; Alonzo-Pepe 2005; Hubbard et al 2020 Stat Med specifically on phenotyping under nonignorable verification). The corollary's content is novel in the masked-data framing but its substantive result (subsample sens/spec not transportable to cohort when verification is selective) is well-known. Without engaging this literature the paper looks unaware of the closest prior work.

Suggested fix: in discussion.tex prior-work section, add a paragraph on verification-bias correction. Cite Begg-Greenes 1983 and Hubbard 2020. State that the case-mix-gap corollary recasts a verification-bias result in the coarsening vocabulary, with the contribution being the unification rather than the result itself.

### MAJOR: anchor-and-learn positioning slightly overstated

Location: translation.tex line 113 to 117; introduction.tex line 75 to 86.

Quoted text (translation.tex):
> "Anchor-and-learn (Halpern 2016) identifies high-precision 'anchor' observations whose presence almost certainly implies the true state. An anchor is a near-singleton candidate set; the framework predicts that anchors restore identifiability for the same reason chart review does"

Problem: Halpern's anchor framework is about training classifiers from positive-only labels, more akin to PU learning than to prevalence estimation. Anchors give high-precision positives (one direction of the singleton), but not high-precision negatives. Saying "an anchor is a near-singleton" conflates "anchor patient = singleton {1}" with "the anchor concept supplies the singleton mechanism the framework needs". The latter is fair; the former is a bit loose.

Suggested fix: rephrase as "an anchor-positive patient supplies a near-singleton candidate set on the Y=1 side; symmetric anchor-negative observations would supply Y=0 singletons but are rarer in Halpern's setting. Chart review supplies both, which is why it identifies prevalence (T2) whereas anchor-only methods identify the conditional rather than the marginal."

### MAJOR: Hubbard et al 2020 on phenotyping under nonignorable verification

Almost identical conceptual territory: Hubbard, Lee, Wong et al 2020 (Statistics in Medicine 39:3009-3023) "Statistical methods for outcome misclassification with multiple data sources" and related works in the same line treat exactly the case where verification (chart review) is selective and the bias propagates into prevalence and association estimates. Not citing this work is a serious novelty-positioning gap because the paper repeatedly emphasizes the chart-review case-mix concern.

Suggested fix: add Hubbard et al 2020 (and similar Hubbard-Bouchard works on phenotyping algorithm validation under selective verification). State the relation: this paper treats the same selective-verification problem from the coarsening-at-random side, where the case-mix gap is the C2-violation analog.

### MAJOR: glass-ceiling result is sound but the "discovery" framing is overstated

Location: identifiability.tex line 66 to 73.

Quoted text:
> "Cref{thm:glass-ceiling} formalizes a fact that EHR researchers know informally"

The formal result (1 equation, 3 unknowns) is well known to epidemiologists since at least Rogan-Gladen 1978, who explicitly assume sens and spec known precisely because the parameter triple is not identifiable from p alone. The paper acknowledges this informally ("EHR researchers know"). The contribution is the explicit solution-surface construction and the embedding in the masked-data framework, both fair, but the prose could be tighter.

Suggested fix: in identifiability.tex around line 66, rewrite as: "Cref{thm:glass-ceiling} makes explicit a non-identifiability that has been implicit in screening-test methodology since Rogan-Gladen 1978: their estimator presumes known sens and spec precisely because the triple is not jointly identifiable from p alone. The contribution here is the solution-surface construction (exhibiting the indistinguishable models) and the embedding in the masked-data rank framework (Theorem T_bg-id), which then lets the chart-review remedy (T2) and the marginal-fit blindness (T3) follow by the same argument used across the masked-data series."

### MAJOR: "informative-coding bias bound" novelty

Location: methodology.tex T4.

The bound's interpretive content (bias controlled by severity-coding correlation) is novel as stated, though morally close to a Taylor expansion. The masked-data framing connects it to the C2-relaxation results of the sibling mdrelax paper, which is good. The result's audience-facing value is the bound's interpretability: a clinician understands "more severe -> more coded -> bigger bias", which is non-trivial.

Strength to retain: the bound's prose framing ("the bias is controlled by the severity-coding correlation rho") is genuinely useful and not a relabeling.

Weakness: prove the bound cleanly (see logic-checker for the Jensen step issue) and acknowledge that the result is in the spirit of the differential-misclassification literature (Greenland 1980, Bross 1954). Otherwise the bound looks free-standing when it is part of a long tradition.

### MAJOR: code-frequency consistency (T3) is a strength but the framing should be tightened

T3 (a fitted model reproduces the marginal code frequency, so marginal-fit checks cannot detect prevalence bias) is the most distinctively novel of the four results. The morally adjacent literature (Manski's identification region work; Imbens and Manski bounds) treats non-identifiability bounds but not the marginal-fit-blindness phenomenon directly. This is the closest the paper gets to a genuinely original observation.

The framing could be tighter: T3 is about diagnostic-test blindness, not estimator identifiability per se. The practical implication ("the standard goodness-of-fit check is uninformative") deserves more prominence in the abstract and discussion.

Suggested fix: in the discussion's "what is new here" paragraph, lead with T3 as the most novel result and frame T1 + T2 as classical (Hui-Walter + Rogan-Gladen) given a structural rephrasing.

### MINOR: sibling-series positioning

The sibling-series framing (scRNA-seq, spatial, DP, weak supervision) is a strength, providing external evidence that the framework is general. However, three of four siblings are listed as "manuscripts in preparation" in refs.bib; a JAMIA reviewer may discount un-published siblings. The paper's value should not depend on the siblings.

Suggested fix: keep the sibling framing for context but ensure each result stands without depending on sibling papers. T1 is self-contained (after the proof fix). T2 currently parallels "the spike-in identifiability theorem" of the scRNA paper but the parallel is rhetorical, the proof is self-contained, OK. T4 mentions "C2-relaxation results of mdrelax"; OK if cited as forthcoming.

## Overall novelty verdict

The structural contribution (coarsening framework + C1/C2/C3 classification + masked-data unification) is genuine and non-trivial as a positioning / methodology contribution. The technical contributions (glass-ceiling solution surface, code-frequency consistency, severity-coding bias bound) are useful refinements but not breakthrough results. The novelty of T3 (marginal-fit blindness) is the strongest individual result. The omission of Rogan-Gladen 1978 and the verification-bias literature is the most serious novelty-positioning weakness and is fixable with a few references and a paragraph in discussion.

Recommendation: not-ready for JAMIA submission as currently written. Add Rogan-Gladen + Hubbard et al + Begg-Greenes citations and rewrite the discussion's prior-work paragraph to clearly delineate "we adopt the standard estimator and add the structural framework" rather than letting the reader infer the estimator is novel.
