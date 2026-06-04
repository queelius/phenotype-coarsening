## regen_table4a.R
##
## Regenerate the informative-coding bias table (tab:informative) with the
## DEPLOYABLE weighted-by-P(Y|S) calibrated estimator, alongside the oracle
## column, to confirm the table's conclusions do not depend on the oracle.
##
## Run: Rscript scripts/regen_table4a.R

set.seed(20260603)
source("scripts/sim.R")

## Deployable calibrated estimator: marginalize code-sensitivity over ALL
## observed cohort severities, weighted by an estimated P(Y=1|S) fit on the
## adjudicated subsample. Uses no latent cohort labels. (Same construction as
## scripts/oracle_check.R, with a simple random review subsample here since
## Table 4a uses representative review.)
est_chart_weighted <- function(coh, m) {
  idx <- sample.int(length(coh$Y), min(m, length(coh$Y)))
  Yr <- coh$Y[idx]; Sr <- coh$S[idx]; Cr <- coh$C[idx]
  if (length(unique(Yr)) < 2L) return(NA_real_)
  case <- which(Yr == 1)
  cf <- if (length(case) >= 2L && length(unique(Cr[case])) == 2L)
    coef(suppressWarnings(glm(Cr[case] ~ Sr[case], family = binomial())))
  else c(qlogis(min(max(mean(Cr[case]), 1e-3), 1 - 1e-3)), 0)
  mem <- suppressWarnings(glm(Yr ~ Sr, family = binomial()))
  w <- plogis(predict(mem, newdata = data.frame(Sr = coh$S)))
  sens_hat <- weighted.mean(plogis(cf[1] + cf[2] * coh$S), w)
  spec_hat <- 1 - mean(Cr[which(Yr == 0)])
  deconvolve_prevalence(mean(coh$C), sens_hat, spec_hat)
}

b1_grid <- c(0, 0.5, 1.0, 1.5, 2.0, 3.0)
n_rep <- 200
pi_true <- 0.12

rows <- lapply(b1_grid, function(b1) {
  rho_v <- numeric(n_rep)
  code_only <- numeric(n_rep)
  cal_oracle <- numeric(n_rep)
  cal_deploy <- numeric(n_rep)
  for (r in seq_len(n_rep)) {
    coh <- sim_cohort(n = 20000, pi = pi_true, mu_s1 = 1.5,
                      b0 = 0, b1 = b1, fpr = 0.05)
    rho_v[r] <- severity_coding_corr(coh)
    code_only[r] <- mean(coh$C) - pi_true
    cal_oracle[r] <- est_chart_calibrated(coh, m = 1000,
                                          sens_ref = "cohort")$pi_hat - pi_true
    cal_deploy[r] <- est_chart_weighted(coh, m = 1000) - pi_true
  }
  data.frame(
    b1 = b1,
    rho = round(mean(rho_v, na.rm = TRUE), 3),
    code_only_bias = round(mean(code_only), 4),
    cal_oracle_bias = round(mean(cal_oracle, na.rm = TRUE), 4),
    cal_deploy_bias = round(mean(cal_deploy, na.rm = TRUE), 4),
    cal_deploy_mcse = round(sd(cal_deploy, na.rm = TRUE) / sqrt(n_rep), 4)
  )
})
tab <- do.call(rbind, rows)
cat("Informative-coding bias: oracle vs deployable calibrated estimator\n")
cat("(pi_true = 0.12, 200 reps/row, m_gold = 1000)\n\n")
print(tab, row.names = FALSE)
cat("\nrho non-monotone in b1:", !all(diff(tab$rho) >= 0) && tab$rho[2] > tab$rho[nrow(tab)], "\n")
cat("max |oracle - deployable| calibrated bias:",
    round(max(abs(tab$cal_oracle_bias - tab$cal_deploy_bias)), 4), "\n")
saveRDS(tab, "results_table4a_deployable.rds")
