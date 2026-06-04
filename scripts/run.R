# Run experiments for phenotype-coarsening validation.
#
# Outputs results to results.rds at the project root.
# Console summary printed at the end.
#
# Usage:
#   cd papers/phenotype-coarsening
#   Rscript scripts/run.R

# -----------------------------------------------------------------
# Setup
# -----------------------------------------------------------------

script_dir <- local({
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("^--file=", args, value = TRUE)
    if (length(file_arg) == 1L) {
        d <- dirname(normalizePath(sub("^--file=", "", file_arg)))
    } else if (file.exists("scripts/sim.R")) {
        d <- normalizePath("scripts")
    } else {
        d <- normalizePath(".")
    }
    d
})
source(file.path(script_dir, "sim.R"))

set.seed(20260521)

# -----------------------------------------------------------------
# Study 1: glass ceiling (Theorem T1)
# Code data alone (a single code frequency q) cannot identify
# (pi, sens, spec): a continuum of triples reproduces the same q.
# -----------------------------------------------------------------

cat("[1/4] Glass ceiling: enumerating the (pi, sens, spec) solution surface...\n")

# Generate one informative-coding cohort and read off its code frequency.
coh1 <- sim_cohort(n = 50000, pi = 0.12, mu_s1 = 1.5, b0 = 0, b1 = 1.0,
                   fpr = 0.05)
q1 <- mean(coh1$C)

surface1 <- glass_ceiling_surface(q1)
# The truth is one point on the surface; many others reproduce the same q.
exp1 <- list(
    pi_true = coh1$pi,
    sens_true = coh1$sens,
    spec_true = coh1$spec,
    q_observed = q1,
    n_solutions = nrow(surface1),
    pi_range = range(surface1$pi),
    sens_range = range(surface1$sens),
    max_qcheck_dev = max(abs(surface1$q_check - q1)),
    surface = surface1
)
cat(sprintf("    observed code frequency q = %.4f\n", q1))
cat(sprintf("    %d (pi,sens,spec) triples reproduce q (pi in [%.2f, %.2f])\n",
            exp1$n_solutions, exp1$pi_range[1], exp1$pi_range[2]))
cat(sprintf("    max deviation of any solution's implied q from observed: %.2e\n",
            exp1$max_qcheck_dev))

# -----------------------------------------------------------------
# Study 2: identifiability with chart review (Theorem T2)
# A representative chart-reviewed subsample identifies the coding model;
# the calibrated estimator recovers pi, and RMSE falls as m grows.
# -----------------------------------------------------------------

cat("[2/4] Identifiability with chart review: RMSE vs subsample size m...\n")

pi2 <- 0.12
m_grid <- c(50, 100, 200, 500, 1000, 2000)
n_rep2 <- 200
exp2 <- data.frame(m = m_grid,
                   rmse_calibrated = NA_real_,
                   bias_calibrated = NA_real_,
                   rmse_code_only = NA_real_,
                   bias_code_only = NA_real_)

for (i in seq_along(m_grid)) {
    m <- m_grid[i]
    err_cal <- numeric(n_rep2)
    err_cod <- numeric(n_rep2)
    for (r in seq_len(n_rep2)) {
        coh <- sim_cohort(n = 20000, pi = pi2, mu_s1 = 1.5,
                          b0 = 0, b1 = 1.0, fpr = 0.05)
        cal <- est_chart_calibrated(coh, m = m, sens_ref = "cohort")
        err_cal[r] <- cal$pi_hat - pi2
        err_cod[r] <- est_code_only(coh) - pi2
    }
    exp2$rmse_calibrated[i] <- sqrt(mean(err_cal^2, na.rm = TRUE))
    exp2$bias_calibrated[i] <- mean(err_cal, na.rm = TRUE)
    exp2$rmse_code_only[i]  <- sqrt(mean(err_cod^2))
    exp2$bias_code_only[i]  <- mean(err_cod)
}
cat("    done.\n")

# -----------------------------------------------------------------
# Study 3: code-frequency consistency (Theorem T3)
# A fitted phenotype model reproduces the marginal observed code
# frequency exactly; the residual is at optimization tolerance.
# -----------------------------------------------------------------

cat("[3/4] Code-frequency consistency: residual at fitted models...\n")

n_rep3 <- 200
resid_cal <- numeric(n_rep3)     # residual at the calibrated fit
resid_truth <- numeric(n_rep3)   # residual at the true (pi, sens, spec)
resid_wrongpi <- numeric(n_rep3) # residual at a deliberately wrong pi

for (r in seq_len(n_rep3)) {
    coh <- sim_cohort(n = 20000, pi = 0.12, mu_s1 = 1.5,
                      b0 = 0, b1 = 1.0, fpr = 0.05)
    cal <- est_chart_calibrated(coh, m = 1000, sens_ref = "cohort")
    # T3: the calibrated triple reproduces the empirical code frequency.
    resid_cal[r] <- code_freq_residual(cal$pi_hat, cal$sens, cal$spec, coh$C)
    # The true triple also reproduces it (up to sampling in q).
    resid_truth[r] <- code_freq_residual(coh$pi, coh$sens, coh$spec, coh$C)
    # A model with the WRONG prevalence but sens/spec re-solved to match q
    # still reproduces the code frequency: marginal fit cannot detect bias.
    pi_wrong <- coh$pi * 2
    sens_wrong <- (mean(coh$C) - (1 - pi_wrong) * (1 - coh$spec)) / pi_wrong
    resid_wrongpi[r] <- code_freq_residual(pi_wrong, sens_wrong, coh$spec,
                                           coh$C)
}
exp3 <- list(
    resid_calibrated_median = median(resid_cal),
    resid_calibrated_max = max(resid_cal),
    resid_truth_median = median(resid_truth),
    resid_wrongpi_median = median(resid_wrongpi),
    resid_wrongpi_max = max(resid_wrongpi)
)
cat(sprintf("    calibrated-fit code-freq residual: median %.2e, max %.2e\n",
            exp3$resid_calibrated_median, exp3$resid_calibrated_max))
cat(sprintf("    wrong-prevalence model still matches q: median residual %.2e\n",
            exp3$resid_wrongpi_median))

# -----------------------------------------------------------------
# Study 4: bias under informative coding (Theorem T4)
# 4a: sweep b1; code-only bias grows with b1, calibrated stays near zero.
# 4b: severity-biased chart review inherits a residual bias (the
#     ERCC-endogenous / case-mix-gap analog).
# -----------------------------------------------------------------

cat("[4/4] Bias under informative coding: b1 sweep + case-mix gap...\n")

# 4a: informative-coding sweep.
pi4 <- 0.12
b1_grid <- c(0, 0.5, 1.0, 1.5, 2.0, 3.0)
n_rep4 <- 200
exp4a <- data.frame(b1 = b1_grid,
                    rho = NA_real_,
                    sens_marginal = NA_real_,
                    bias_code_only = NA_real_,
                    mcse_code_only = NA_real_,
                    bias_calibrated = NA_real_,
                    mcse_calibrated = NA_real_,
                    rmse_calibrated = NA_real_)

for (i in seq_along(b1_grid)) {
    b1 <- b1_grid[i]
    rho_v <- numeric(n_rep4); sens_v <- numeric(n_rep4)
    err_cod <- numeric(n_rep4); err_cal <- numeric(n_rep4)
    for (r in seq_len(n_rep4)) {
        coh <- sim_cohort(n = 20000, pi = pi4, mu_s1 = 1.5,
                          b0 = 0, b1 = b1, fpr = 0.05)
        rho_v[r]  <- severity_coding_corr(coh)
        sens_v[r] <- coh$sens
        err_cod[r] <- est_code_only(coh) - pi4
        # Deployable calibrated estimator (no latent cohort labels).
        err_cal[r] <- est_chart_deployable(coh, m = 1000) - pi4
    }
    exp4a$rho[i]             <- mean(rho_v, na.rm = TRUE)
    exp4a$sens_marginal[i]   <- mean(sens_v, na.rm = TRUE)
    exp4a$bias_code_only[i]  <- mean(err_cod)
    exp4a$mcse_code_only[i]  <- sd(err_cod) / sqrt(n_rep4)
    exp4a$bias_calibrated[i] <- mean(err_cal, na.rm = TRUE)
    exp4a$mcse_calibrated[i] <- sd(err_cal, na.rm = TRUE) /
                                sqrt(sum(!is.na(err_cal)))
    exp4a$rmse_calibrated[i] <- sqrt(mean(err_cal^2, na.rm = TRUE))
}

# 4b: case-mix gap. Chart review is severity-biased: severe patients are
# over-selected for review. The calibrated estimator that uses the
# subsample's own severity distribution as the reference (sens_ref =
# "subsample") inherits a residual bias, the ERCC-endogenous analog.
bias_grid <- c(0, 0.5, 1.0, 1.5, 2.0)
n_rep4b <- 200
exp4b <- data.frame(review_bias = bias_grid,
                    sens_gap = NA_real_,
                    bias_subsample_ref = NA_real_,
                    bias_cohort_ref = NA_real_)

for (i in seq_along(bias_grid)) {
    bsel <- bias_grid[i]
    gap_v <- numeric(n_rep4b)
    err_sub <- numeric(n_rep4b); err_coh <- numeric(n_rep4b)
    for (r in seq_len(n_rep4b)) {
        coh <- sim_cohort(n = 20000, pi = pi4, mu_s1 = 1.5,
                          b0 = 0, b1 = 1.0, fpr = 0.05)
        ridx <- biased_review_idx(coh, m = 1000, bias = bsel)
        # Marginal code sensitivity in the reviewed subsample vs cohort.
        case_r <- ridx[coh$Y[ridx] == 1]
        case_c <- which(coh$Y == 1)
        if (length(case_r) >= 1L) {
            sens_rev <- mean(plogis(coh$b0 + coh$b1 * coh$S[case_r]))
            sens_coh <- mean(plogis(coh$b0 + coh$b1 * coh$S[case_c]))
            gap_v[r] <- sens_rev - sens_coh
        } else {
            gap_v[r] <- NA_real_
        }
        # Calibrated estimator using the subsample severity as reference
        # inherits the case-mix gap; using the cohort severity does not.
        cal_sub <- est_chart_calibrated(coh, m = 1000, review_idx = ridx,
                                        sens_ref = "subsample")
        cal_coh <- est_chart_calibrated(coh, m = 1000, review_idx = ridx,
                                        sens_ref = "cohort")
        err_sub[r] <- cal_sub$pi_hat - pi4
        err_coh[r] <- cal_coh$pi_hat - pi4
    }
    exp4b$sens_gap[i]           <- mean(gap_v, na.rm = TRUE)
    exp4b$bias_subsample_ref[i] <- mean(err_sub, na.rm = TRUE)
    exp4b$bias_cohort_ref[i]    <- mean(err_coh, na.rm = TRUE)
}
cat("    done.\n")

# -----------------------------------------------------------------
# Save and summarize
# -----------------------------------------------------------------

results <- list(
    seed = 20260521,
    timestamp = Sys.time(),
    exp1_glass_ceiling = exp1,
    exp2_chart_review = exp2,
    exp3_code_freq = exp3,
    exp4a_informative_coding = exp4a,
    exp4b_casemix_gap = exp4b
)

saveRDS(results, file = file.path(script_dir, "..", "results.rds"))

cat("\n========== SUMMARY ==========\n")

cat("\nStudy 1 (glass ceiling, Theorem T1):\n")
cat(sprintf("  true (pi, sens, spec) = (%.3f, %.3f, %.3f)\n",
            exp1$pi_true, exp1$sens_true, exp1$spec_true))
cat(sprintf("  observed code frequency q = %.4f\n", exp1$q_observed))
cat(sprintf("  %d distinct (pi,sens,spec) triples reproduce q exactly\n",
            exp1$n_solutions))
cat(sprintf("  prevalence over solution surface ranges %.2f to %.2f\n",
            exp1$pi_range[1], exp1$pi_range[2]))

cat("\nStudy 2 (identifiability with chart review, Theorem T2):\n")
print(exp2)

cat("\nStudy 3 (code-frequency consistency, Theorem T3):\n")
cat(sprintf("  calibrated-fit residual:  median %.2e, max %.2e\n",
            exp3$resid_calibrated_median, exp3$resid_calibrated_max))
cat(sprintf("  true-triple residual:     median %.2e\n",
            exp3$resid_truth_median))
cat(sprintf("  wrong-prevalence model still matches q: median %.2e, max %.2e\n",
            exp3$resid_wrongpi_median, exp3$resid_wrongpi_max))

cat("\nStudy 4a (bias under informative coding, Theorem T4):\n")
print(exp4a)

cat("\nStudy 4b (case-mix gap; ERCC-endogenous analog):\n")
print(exp4b)

cat("\nResults saved to results.rds\n")
