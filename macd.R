# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Moving Average Convergence Divergence (MACD)
macd <- function(data, short_period, long_period, signal_period) {
  if (!is.numeric(data) || length(data) == 0L || any(!is.finite(data))) {
    stop("data must be a non-empty numeric vector containing only finite values")
  }
  periods <- c(short_period, long_period, signal_period)
  if (any(lengths(list(short_period, long_period, signal_period)) != 1L) ||
      any(!is.numeric(periods)) || any(!is.finite(periods)) ||
      any(periods < 1) || any(periods != as.integer(periods))) {
    stop("all periods must be positive integers")
  }
  short_period <- as.integer(short_period)
  long_period <- as.integer(long_period)
  signal_period <- as.integer(signal_period)
  if (short_period >= long_period) {
    stop("short_period must be less than long_period")
  }
  if (long_period > length(data) || signal_period > length(data)) {
    stop("periods cannot be greater than the length of data")
  }

  ema_core <- function(values, period) {
    multiplier <- 2 / (period + 1)
    result <- numeric(length(values))
    result[1] <- values[1]
    if (length(values) > 1L) {
      for (i in 2:length(values)) {
        result[i] <- (values[i] - result[i - 1L]) * multiplier + result[i - 1L]
      }
    }
    result
  }

  short_ema <- ema_core(data, short_period)
  long_ema <- ema_core(data, long_period)
  macd_line <- short_ema - long_ema
  signal_line <- ema_core(macd_line, signal_period)
  histogram <- macd_line - signal_line

  result <- list(
    macd_line = macd_line,
    signal_line = signal_line,
    histogram = histogram
  )
  return(result)
}

