# Generate PDF figures for the validation section.
# Reads results.rds, writes figures/glass_ceiling.pdf and
# figures/informative_coding.pdf.
#
# Usage:
#   cd papers/phenotype-coarsening
#   Rscript scripts/figures.R

script_dir <- local({
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- grep("^--file=", args, value = TRUE)
    if (length(file_arg) == 1L) {
        dirname(normalizePath(sub("^--file=", "", file_arg)))
    } else {
        normalizePath(".")
    }
})

proj_root <- normalizePath(file.path(script_dir, ".."))
results <- readRDS(file.path(proj_root, "results.rds"))
fig_dir <- file.path(proj_root, "figures")
dir.create(fig_dir, showWarnings = FALSE, recursive = TRUE)

# -----------------------------------------------------------------
# Figure 1: glass-ceiling solution surface (Theorem T1)
# Panel A: the (pi, sens) solution curve, all reproducing the same q.
# Panel B: chart-review RMSE vs subsample size m (Theorem T2).
# -----------------------------------------------------------------

surface <- results$exp1_glass_ceiling$surface
e2 <- results$exp2_chart_review
q_obs <- results$exp1_glass_ceiling$q_observed
pi_true <- results$exp1_glass_ceiling$pi_true
sens_true <- results$exp1_glass_ceiling$sens_true

pdf(file.path(fig_dir, "glass_ceiling.pdf"), width = 7, height = 3.2)
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.2, 2.2, 1), mgp = c(2.4, 0.8, 0))

# Panel A: prevalence vs sensitivity along the solution surface.
ord <- order(surface$pi)
plot(surface$pi[ord], surface$sens[ord], type = "n",
     xlab = expression("prevalence " * pi),
     ylab = "code sensitivity",
     main = sprintf("A. Glass ceiling (q = %.3f)", q_obs),
     cex.main = 0.95, ylim = c(0, 1))
# Each specificity level traces one curve; all reproduce the same q.
specs <- sort(unique(surface$spec))
cols <- hcl.colors(length(specs), palette = "viridis", rev = TRUE)
for (k in seq_along(specs)) {
    sub <- surface[surface$spec == specs[k], ]
    sub <- sub[order(sub$pi), ]
    lines(sub$pi, sub$sens, col = cols[k], lwd = 1.6)
}
points(pi_true, sens_true, pch = 19, col = "firebrick", cex = 1.2)
text(pi_true, sens_true, "  truth", pos = 4, cex = 0.8, col = "firebrick")
legend("topright", legend = sprintf("spec=%.2f", range(specs)),
       col = cols[c(1, length(cols))], lwd = 1.6, bty = "n", cex = 0.7,
       title = "code specificity")

# Panel B: chart-review RMSE vs m, calibrated vs code-only.
y_lim <- range(c(e2$rmse_calibrated, e2$rmse_code_only))
plot(e2$m, e2$rmse_calibrated, type = "b", pch = 19, lwd = 2,
     col = "steelblue4", log = "x", ylim = y_lim,
     xlab = "chart-review subsample size m",
     ylab = "RMSE of prevalence estimate",
     main = "B. Chart review restores identifiability",
     cex.main = 0.95)
lines(e2$m, e2$rmse_code_only, type = "b", pch = 17, lwd = 2,
      col = "firebrick", lty = 2)
legend("topright", bty = "n", cex = 0.78,
       legend = c("chart-calibrated", "code-only"),
       col = c("steelblue4", "firebrick"),
       lty = c(1, 2), pch = c(19, 17), lwd = 2)

par(op)
dev.off()
cat("Wrote", file.path(fig_dir, "glass_ceiling.pdf"), "\n")

# -----------------------------------------------------------------
# Figure 2: bias under informative coding (Theorem T4)
# Panel A: code-only vs calibrated bias as the coding slope b1 grows.
# Panel B: calibrated-estimator residual bias vs the case-mix gap.
# -----------------------------------------------------------------

e4a <- results$exp4a_informative_coding
e4b <- results$exp4b_casemix_gap

pdf(file.path(fig_dir, "informative_coding.pdf"), width = 7, height = 3.2)
op <- par(mfrow = c(1, 2), mar = c(4.2, 4.4, 2.2, 1), mgp = c(2.5, 0.8, 0))

# Panel A: bias vs coding slope b1.
y_lim <- range(c(e4a$bias_code_only, e4a$bias_calibrated, 0))
plot(e4a$b1, e4a$bias_code_only, type = "b", pch = 17, lwd = 2,
     col = "firebrick", ylim = y_lim,
     xlab = expression("coding-mechanism severity slope " * b[1]),
     ylab = "prevalence bias",
     main = "A. Informative coding (C2 violation)",
     cex.main = 0.95)
lines(e4a$b1, e4a$bias_calibrated, type = "b", pch = 19, lwd = 2,
      col = "steelblue4")
abline(h = 0, lty = 3, col = "grey50")
legend("topleft", bty = "n", cex = 0.78,
       legend = c("code-only", "chart-calibrated"),
       col = c("firebrick", "steelblue4"),
       lty = 1, pch = c(17, 19), lwd = 2)

# Panel B: calibrated residual bias vs case-mix sensitivity gap.
y_lim <- range(c(e4b$bias_subsample_ref, e4b$bias_cohort_ref, 0))
plot(e4b$sens_gap, e4b$bias_subsample_ref, type = "b", pch = 19, lwd = 2,
     col = "darkorange3", ylim = y_lim,
     xlab = "case-mix sensitivity gap",
     ylab = "residual prevalence bias",
     main = "B. Case-mix gap (ERCC-endogenous analog)",
     cex.main = 0.95)
lines(e4b$sens_gap, e4b$bias_cohort_ref, type = "b", pch = 19, lwd = 2,
      col = "steelblue4")
abline(h = 0, lty = 3, col = "grey50")
legend("bottomleft", bty = "n", cex = 0.78,
       legend = c("subsample-reference", "cohort-reference"),
       col = c("darkorange3", "steelblue4"),
       lty = 1, pch = 19, lwd = 2)

par(op)
dev.off()
cat("Wrote", file.path(fig_dir, "informative_coding.pdf"), "\n")
