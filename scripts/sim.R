# Electronic-phenotyping simulation: data-generating process, estimators,
# and diagnostics. Sourced by run.R.
#
# DGP: binary true clinical state Y, latent severity S, informative coding.
#   Y[i]   true clinical state in {0,1}, prevalence pi.
#   S[i]   latent severity, Normal; mean shifted up for Y = 1.
#   C[i]   diagnosis-code indicator. For a true case the code probability is
#          logistic(b0 + b1 * S), so code sensitivity rises with severity
#          when b1 > 0 (informative coding, a C2 violation). For a non-case
#          the code probability is fpr (specificity = 1 - fpr).
#   D[i]   optional second coarse feature (a procedure code) with its own
#          sensitivity / false-positive rate.
#
# Estimators of cohort prevalence pi:
#   (a) code-only        pi_hat = mean(C); biased under informative coding.
#   (b) chart-calibrated adjudicate a subsample of m patients (gold Y), fit
#                        the coding model including severity dependence on
#                        the subsample, then deconvolve cohort prevalence.
#   (c) oracle           full chart review, pi_hat = mean(Y).
#
# Base R only; no external packages.

suppressPackageStartupMessages({
    invisible(NULL)  # base R only, no external deps
})

# -----------------------------------------------------------------
# Data-generating process
# -----------------------------------------------------------------

#' Generate one phenotyping cohort.
#'
#' @param n      cohort size.
#' @param pi     true prevalence P(Y = 1).
#' @param mu_s0  mean latent severity among non-cases (Y = 0).
#' @param mu_s1  mean latent severity among true cases (Y = 1); mu_s1 > mu_s0.
#' @param sd_s   severity standard deviation (shared).
#' @param b0     coding-mechanism intercept (logit scale).
#' @param b1     coding-mechanism severity slope; b1 > 0 is informative
#'               coding (a C2 violation). b1 = 0 is non-informative (C2 holds).
#' @param fpr    false-positive rate of the code among non-cases.
#' @param proc   if TRUE, also generate a second coarse feature D
#'               (a procedure code).
#' @param proc_sens,proc_fpr  sensitivity / false-positive rate of D.
#' @return list with Y, S, C, marginal sens/spec, and optionally D.
sim_cohort <- function(n, pi, mu_s0 = 0, mu_s1 = 1.5, sd_s = 1,
                       b0 = 0, b1 = 1, fpr = 0.05,
                       proc = FALSE, proc_sens = 0.4, proc_fpr = 0.02) {
    Y <- rbinom(n, 1, pi)
    S <- rnorm(n, mean = ifelse(Y == 1, mu_s1, mu_s0), sd = sd_s)
    # Coding mechanism: per-case probability depends on severity.
    p_case <- plogis(b0 + b1 * S)
    p_code <- ifelse(Y == 1, p_case, fpr)
    C <- rbinom(n, 1, p_code)
    # Marginal (cohort) code sensitivity and specificity.
    sens <- if (any(Y == 1)) mean(p_case[Y == 1]) else NA_real_
    spec <- 1 - fpr
    out <- list(Y = Y, S = S, C = C, p_code = p_code,
                pi = pi, sens = sens, spec = spec,
                b0 = b0, b1 = b1, fpr = fpr)
    if (proc) {
        p_proc <- ifelse(Y == 1, proc_sens, proc_fpr)
        out$D <- rbinom(n, 1, p_proc)
        out$proc_sens <- proc_sens
        out$proc_spec <- 1 - proc_fpr
    }
    out
}

# -----------------------------------------------------------------
# Estimators of cohort prevalence
# -----------------------------------------------------------------

#' (a) Code-only prevalence estimator: the fraction of code-positive
#' patients. Biased under informative coding (Theorem T1 / T4).
est_code_only <- function(coh) mean(coh$C)

#' (c) Oracle estimator: full chart review, prevalence = mean of the
#' adjudicated true states.
est_oracle <- function(coh) mean(coh$Y)

#' Deconvolve cohort prevalence from the observed code frequency given
#' code sensitivity and specificity. Inverts q = pi*sens + (1-pi)*(1-spec).
#' Returns a value clamped to [0, 1].
deconvolve_prevalence <- function(q, sens, spec) {
    denom <- sens + spec - 1            # > 0 iff the code is informative
    if (!is.finite(denom) || denom <= 1e-8) return(NA_real_)
    pi_hat <- (q - (1 - spec)) / denom
    min(max(pi_hat, 0), 1)
}

#' (b) Chart-review-calibrated estimator.
#'
#' A subsample of m patients is adjudicated (gold Y observed). The coding
#' model, including the severity dependence, is fit on the subsample by
#' logistic regression of C on S among adjudicated true cases, and the
#' false-positive rate is the code rate among adjudicated non-cases. The
#' marginal code sensitivity is then averaged over the severity
#' distribution of the chosen reference population, and cohort prevalence
#' is deconvolved from the full-cohort code frequency.
#'
#' @param coh         the full cohort (from sim_cohort).
#' @param m           chart-review subsample size.
#' @param review_idx  optional explicit indices to adjudicate; if NULL a
#'                     simple random subsample of size m is drawn. Supplying
#'                     a non-representative index set (e.g. severity-biased)
#'                     induces the case-mix gap of Corollary 5.
#' @param sens_ref    Reference severity distribution for marginalizing the
#'                     fitted code-sensitivity. "cohort" averages over
#'                     coh$S[coh$Y == 1], which requires the latent label Y for
#'                     the WHOLE cohort: this is an ORACLE, not deployable, and
#'                     is retained only to reproduce the oracle diagnostic row.
#'                     "subsample" averages over reviewed cases only
#'                     (deployable, but inherits the case-mix gap under biased
#'                     review). For the deployable, unbiased reference used in
#'                     the paper's recommendation see est_chart_weighted in
#'                     scripts/oracle_check.R, which marginalizes over all
#'                     observed cohort severities weighted by an estimated
#'                     P(Y=1|S). Default "subsample".
est_chart_calibrated <- function(coh, m, review_idx = NULL,
                                  sens_ref = c("subsample", "cohort")) {
    sens_ref <- match.arg(sens_ref)
    n <- length(coh$Y)
    if (is.null(review_idx)) review_idx <- sample.int(n, min(m, n))
    Yr <- coh$Y[review_idx]; Sr <- coh$S[review_idx]; Cr <- coh$C[review_idx]

    # Need both classes in the subsample to identify sens and spec.
    if (length(unique(Yr)) < 2L) {
        return(list(pi_hat = NA_real_, sens = NA_real_, spec = NA_real_,
                    note = "subsample lacks both Y classes"))
    }

    # Fit the coding model on adjudicated true cases: logistic C ~ S.
    case <- which(Yr == 1)
    if (length(case) >= 2L && length(unique(Cr[case])) == 2L) {
        fit <- suppressWarnings(
            glm(Cr[case] ~ Sr[case], family = binomial()))
        cf <- coef(fit)
    } else {
        # Degenerate: fall back to an intercept-only sensitivity estimate.
        cf <- c(qlogis(min(max(mean(Cr[case]), 1e-3), 1 - 1e-3)), 0)
    }

    # Reference severity values for marginalizing the code sensitivity.
    S_case_ref <- if (sens_ref == "cohort") coh$S[coh$Y == 1] else Sr[case]
    sens_hat <- mean(plogis(cf[1] + cf[2] * S_case_ref))

    # Specificity from adjudicated non-cases.
    noncase <- which(Yr == 0)
    fpr_hat <- mean(Cr[noncase])
    spec_hat <- 1 - fpr_hat

    q <- mean(coh$C)
    pi_hat <- deconvolve_prevalence(q, sens_hat, spec_hat)
    list(pi_hat = pi_hat, sens = sens_hat, spec = spec_hat,
         fpr = fpr_hat, coef = cf, m = length(review_idx))
}

#' Deployable chart-review-calibrated prevalence estimator.
#'
#' Unlike est_chart_calibrated(sens_ref = "cohort"), this uses NO latent
#' cohort labels. It marginalizes the fitted code-sensitivity over all
#' observed cohort severities coh$S, weighted by an estimated membership
#' probability P(Y = 1 | S) fit on the adjudicated subsample (where Y is
#' observed). This is the estimator recommended in the paper.
#'
#' @param coh         the full cohort.
#' @param m           chart-review subsample size.
#' @param review_idx  optional explicit indices; default simple random sample.
#' @return prevalence estimate pi_hat (numeric), or NA if the subsample lacks
#'         both label classes.
est_chart_deployable <- function(coh, m, review_idx = NULL) {
    n <- length(coh$Y)
    if (is.null(review_idx)) review_idx <- sample.int(n, min(m, n))
    Yr <- coh$Y[review_idx]; Sr <- coh$S[review_idx]; Cr <- coh$C[review_idx]
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

#' Draw a severity-biased chart-review subsample: patients with higher
#' severity are more likely to be selected for review. This produces a
#' non-representative subsample (the case-mix gap of Corollary 5).
#'
#' @param coh    the cohort.
#' @param m      target subsample size.
#' @param bias   selection-weight slope on severity; bias = 0 is a simple
#'               random sample, bias > 0 over-selects severe patients.
biased_review_idx <- function(coh, m, bias = 1) {
    n <- length(coh$Y)
    w <- plogis(bias * (coh$S - mean(coh$S)))
    sample.int(n, min(m, n), prob = w)
}

# -----------------------------------------------------------------
# Diagnostics
# -----------------------------------------------------------------

#' Severity-coding correlation among true cases: Corr(S, P(code | case)).
#' Zero exactly when b1 = 0 (C2 holds); grows with |b1|.
severity_coding_corr <- function(coh) {
    case <- coh$Y == 1
    if (sum(case) < 3L) return(NA_real_)
    p_case <- plogis(coh$b0 + coh$b1 * coh$S[case])
    if (sd(p_case) < 1e-12) return(0)
    cor(coh$S[case], p_case)
}

#' Code-frequency residual (Theorem T3): the gap between the code
#' frequency implied by a fitted (pi, sens, spec) triple and the empirical
#' code frequency. Should be ~ 0 at an interior MLE.
code_freq_residual <- function(pi_hat, sens, spec, C_obs) {
    q_fit <- pi_hat * sens + (1 - pi_hat) * (1 - spec)
    q_emp <- mean(C_obs)
    abs(q_fit - q_emp)
}

#' Enumerate the glass-ceiling solution surface (Theorem T1): for a fixed
#' observed code frequency q, all (pi, sens, spec) triples on a grid that
#' reproduce q exactly. Returns a data frame of admissible triples.
glass_ceiling_surface <- function(q, pi_grid = seq(0.02, 0.40, by = 0.02),
                                  spec_grid = seq(0.90, 0.999, by = 0.01)) {
    rows <- list()
    for (pi in pi_grid) {
        for (spec in spec_grid) {
            sens <- (q - (1 - pi) * (1 - spec)) / pi
            if (sens >= 0 && sens <= 1) {
                rows[[length(rows) + 1L]] <-
                    data.frame(pi = pi, sens = sens, spec = spec,
                               q_check = pi * sens + (1 - pi) * (1 - spec))
            }
        }
    }
    if (length(rows) == 0L) {
        return(data.frame(pi = numeric(0), sens = numeric(0),
                          spec = numeric(0), q_check = numeric(0)))
    }
    do.call(rbind, rows)
}
