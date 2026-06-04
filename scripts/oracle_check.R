## oracle_check.R
##
## Experiment #10: is the chart-review "cohort-reference" sensitivity
## estimator deployable, or does it secretly use the latent label Y?
##
## The estimator marginalizes the fitted code-sensitivity logit(C ~ S) over a
## set of reference severity values for true cases. Three references:
##   (a) "cohort-oracle":  coh$S[coh$Y == 1]   -- requires latent Y for the
##       WHOLE cohort. NOT deployable; this is the headline Table 4b setting.
##   (b) "subsample":      reviewed cases only  -- deployable, but inherits the
##       case-mix gap when review is severity-biased (Corollary 5).
##   (c) "weighted":       all cohort S, weighted by the fitted P(Y=1|S) from a
##       model trained on the adjudicated subsample -- deployable, uses only
##       observed S plus the review labels. This is the honest replacement for
##       (a).
##
## Run: Rscript scripts/oracle_check.R   (sources the package sim.R)

set.seed(20260603)
source("scripts/sim.R")

`%||%` <- function(a, b) if (is.null(a)) b else a

## The deployable weighted reference estimator now lives in sim.R as
## est_chart_deployable(); we call it directly here.

run <- function(reps = 400, n = 5000, m = 300, pi_true = 0.1,
                b1 = 1.5, review_bias = 1.0) {
  res <- replicate(reps, {
    coh <- sim_cohort(n = n, pi = pi_true, b1 = b1)
    idx <- biased_review_idx(coh, m, bias = review_bias)  # severity-biased review
    oracle <- est_chart_calibrated(coh, m, review_idx = idx, sens_ref = "cohort")$pi_hat
    subsmp <- est_chart_calibrated(coh, m, review_idx = idx, sens_ref = "subsample")$pi_hat
    weight <- est_chart_deployable(coh, m, review_idx = idx)
    c(oracle = oracle, subsample = subsmp, weighted = weight)
  })
  res <- res[, colSums(is.na(res)) == 0, drop = FALSE]
  data.frame(
    estimator = c("cohort-oracle (NOT deployable)",
                  "subsample (deployable, biased review)",
                  "weighted-by-P(Y|S) (deployable)"),
    mean_pi_hat = round(rowMeans(res), 4),
    bias = round(rowMeans(res) - pi_true, 4),
    sd = round(apply(res, 1, sd), 4)
  )
}

cat(sprintf("Truth pi = 0.10, b1 = 1.5, severity-biased chart review (bias=1.0)\n"))
out <- run()
print(out, row.names = FALSE)
cat("\nReading: if 'cohort-oracle' has ~0 bias but 'weighted' does not, the\n",
    "Table 4b remedy was an oracle artifact. If 'weighted' is also ~0 bias,\n",
    "the remedy survives in deployable form.\n", sep = "")
saveRDS(out, "results_oracle_check.rds")
