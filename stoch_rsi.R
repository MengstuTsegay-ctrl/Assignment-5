# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Stochastic RSI (assignment-defined normalization followed by %K and %D smoothing)
stoch_rsi <- function(data, period, k_period, d_period) {
  if (!is.numeric(data) || length(data) < 2L || any(!is.finite(data))) {
    stop("data must contain at least two finite numeric values")
  }
  periods <- c(period, k_period, d_period)
  if (any(lengths(list(period, k_period, d_period)) != 1L) ||
      any(!is.numeric(periods)) || any(!is.finite(periods)) ||
      any(periods < 1) || any(periods != as.integer(periods))) {
    stop("period, k_period, and d_period must be positive integers")
  }
  period <- as.integer(period)
  k_period <- as.integer(k_period)
  d_period <- as.integer(d_period)
  if (length(data) <= period) {
    stop("data length must be greater than the RSI period")
  }

  rsi_core <- function(values, rsi_period) {
    changes <- diff(values)
    gains <- ifelse(changes > 0, changes, 0)
    losses <- ifelse(changes < 0, abs(changes), 0)
    avg_gain <- sum(gains[1:rsi_period]) / rsi_period
    avg_loss <- sum(losses[1:rsi_period]) / rsi_period
    output <- rep(NA_real_, length(values))
    calculate_rsi <- function(gain, loss) {
      if (gain == 0 && loss == 0) return(50)
      if (loss == 0) return(100)
      if (gain == 0) return(0)
      100 - (100 / (1 + gain / loss))
    }
    output[rsi_period + 1L] <- calculate_rsi(avg_gain, avg_loss)
    if (length(values) > rsi_period + 1L) {
      for (i in (rsi_period + 2L):length(values)) {
        avg_gain <- (avg_gain * (rsi_period - 1L) + gains[i - 1L]) / rsi_period
        avg_loss <- (avg_loss * (rsi_period - 1L) + losses[i - 1L]) / rsi_period
        output[i] <- calculate_rsi(avg_gain, avg_loss)
      }
    }
    output
  }

  rolling_mean_same_length <- function(values, window) {
    result <- rep(NA_real_, length(values))
    if (window > length(values)) return(result)
    for (i in window:length(values)) {
      current <- values[(i - window + 1L):i]
      if (all(is.finite(current))) result[i] <- sum(current) / window
    }
    result
  }

  rsi_values <- rsi_core(data, period)
  valid_rsi <- rsi_values[is.finite(rsi_values)]
  if (length(valid_rsi) == 0L) stop("RSI calculation produced no finite values")
  min_rsi <- min(valid_rsi)
  max_rsi <- max(valid_rsi)
  normalized_rsi <- rep(NA_real_, length(rsi_values))
  if (max_rsi == min_rsi) {
    normalized_rsi[is.finite(rsi_values)] <- 0
  } else {
    normalized_rsi[is.finite(rsi_values)] <-
      (valid_rsi - min_rsi) / (max_rsi - min_rsi)
  }
  k_line <- rolling_mean_same_length(normalized_rsi, k_period)
  d_line <- rolling_mean_same_length(k_line, d_period)
  result <- list(k_line = k_line, d_line = d_line)
  return(result)
}

