# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Exponential Moving Average (EMA)
ema <- function(data, period) {
  if (!is.numeric(data) || length(data) == 0L || any(!is.finite(data))) {
    stop("data must be a non-empty numeric vector containing only finite values")
  }
  if (length(period) != 1L || !is.numeric(period) || !is.finite(period) ||
      period < 1 || period != as.integer(period)) {
    stop("period must be one positive integer")
  }
  period <- as.integer(period)
  if (period > length(data)) {
    stop("period cannot be greater than the length of data")
  }

  multiplier <- 2 / (period + 1)
  ema_values <- numeric(length(data))
  ema_values[1] <- data[1]
  if (length(data) > 1L) {
    for (i in 2:length(data)) {
      ema_values[i] <- (data[i] - ema_values[i - 1L]) * multiplier + ema_values[i - 1L]
    }
  }
  return(ema_values)
}

