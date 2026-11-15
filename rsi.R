# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Relative Strength Index (RSI) with Wilder smoothing
rsi <- function(data, period) {
  if (!is.numeric(data) || length(data) < 2L || any(!is.finite(data))) {
    stop("data must contain at least two finite numeric values")
  }
  if (length(period) != 1L || !is.numeric(period) || !is.finite(period) ||
      period < 1 || period != as.integer(period)) {
    stop("period must be one positive integer")
  }
  period <- as.integer(period)
  if (length(data) <= period) {
    stop("data length must be greater than period")
  }

  diff_values <- diff(data)
  gains <- ifelse(diff_values > 0, diff_values, 0)
  losses <- ifelse(diff_values < 0, abs(diff_values), 0)
  avg_gain <- sum(gains[1:period]) / period
  avg_loss <- sum(losses[1:period]) / period
  rsi_values <- rep(NA_real_, length(data))

  rsi_from_averages <- function(gain, loss) {
    if (gain == 0 && loss == 0) return(50)
    if (loss == 0) return(100)
    if (gain == 0) return(0)
    rs <- gain / loss
    100 - (100 / (1 + rs))
  }

  rsi_values[period + 1L] <- rsi_from_averages(avg_gain, avg_loss)
  if (length(data) > period + 1L) {
    for (i in (period + 2L):length(data)) {
      avg_gain <- (avg_gain * (period - 1L) + gains[i - 1L]) / period
      avg_loss <- (avg_loss * (period - 1L) + losses[i - 1L]) / period
      rsi_values[i] <- rsi_from_averages(avg_gain, avg_loss)
    }
  }
  return(rsi_values)
}

