# Novelty Assessor: phenotype-coarsening

## Verdict: novelty claim is HONEST and carefully scoped; one prior-art positioning gap (Major, fixable).

## What is claimed
The "What is new here" paragraph (discussion.tex) is exemplary in its honesty. It enumerates four contributions and explicitly disclaims the obvious overclaims: "We do not claim to originate latent-class estimation of disease status, nor the estimation of sensitivity and specificity without a gold standard, nor the Rogan-Gladen plug-in." The stated contribution is (i) the candidate-set translation placing code phenotyping inside the coarsening framework; (ii) the C1-C2-C3 classification pinpointing informative coding as a C2 violation; (iii) the explicit glass-ceiling construction (exhibiting the non-identifiable surface, not just asserting it); (iv) the informative-coding bias bound and the case-mix-gap residual bound in interpretable quantities.

## Is the unification genuinely new?
The specific framing, casting EHR phenotyping as masked-cause coarsening, naming informative coding as the C2 failure, identifying chart review as the singleton-candidate-set device, and recovering Rogan-Gladen as the deconvolution it enables, is not standard in the phenotyping literature and is a legitimately useful organizing contribution. The line "the Hui-Walter model tells a practitioner THAT prevalence can be estimated; the coarsening framework tells the practitioner WHICH assumption (C2) the EHR violates, WHY (informative coding), and HOW LARGE the bias is" is the crisp statement of the delta over prior work, and it is accurate.

The bias characterization (the sign-flip analysis: code-only prevalence can understate, overstate, or pass through zero depending on the sensitivity deficit vs false-positive inflation) is a genuine analytic contribution that goes beyond "codes are noisy," even if the underlying Rogan-Gladen machinery is classical.

## The honesty risk: closest recent biostatistics neighbors uncited
The classical ancestors (Rogan-Gladen, Hui-Walter, Dawid-Skene, Begg-Greenes) are all cited. The phenotyping landmarks (eMERGE, PheKB, PheWAS, anchor-and-learn, PheNorm, PheCAP) are all cited. But the recent biostatistics work that does almost exactly the EHR-phenotype-with-imperfect-labels estimation is missing:
- Beesley and Mukherjee (2020, Biometrics, DOI 10.1111/biom.13400) jointly handle selection bias AND outcome misclassification for EHR association studies, which is the C2-violation + case-mix-gap pair this paper formalizes. This is the closest competitor and is uncited.
- Hubbard, Tong, Duan, Chen (2020, Epidemiology, DOI 10.1097/ede.0000000000001193) is EHR-phenotype-specific misclassification-bias reduction, by the SAME Hubbard whose general paper (hubbard2020outcome) IS cited.

Their absence does not undercut the novelty of the coarsening unification (neither adopts the C1-C2-C3 vocabulary or the candidate-set framing), but it makes the positioning look incomplete to a JAMIA/Biometrics referee. The fix is one paragraph: those works build corrected estimators for specific association analyses; this paper supplies the unifying identifiability vocabulary that names the failing assumption and bounds the bias, of which their corrections are instances. The two-layer argument the paper already makes against Hui-Walter ("that" vs "which/why/how-large") extends directly.

## Significance and scope honesty
The paper is candid that the technical results "are not breakthroughs in isolation, they are corollaries of the masked-data framework applied to the specific structure of EHR coding." For a methodology venue this candor is appropriate; the value proposition is the unification and the practitioner-facing decision procedure (check C2, supply singletons via representative chart review, report the case-mix gap). The MIMIC-IV real-data application is honestly flagged as the principal pending item (needs credentialing), and the conclusion does not overclaim empirical validation. Sim-only at this stage is a known limitation, disclosed.

## Confidence: HIGH on honesty; HIGH on the specific uncited neighbors (CrossRef-verified; one is by an already-cited author).
