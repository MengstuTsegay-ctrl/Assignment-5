# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Simple Moving Average (SMA)
sma <- function(data, period) {
  if (!is.numeric(data) || length(data) == 0L || any(!is.finite(data))) {
    stop("data must be a non-empty numeric vector containing only finite values")
  }
  if (length(period) != 1L || !is.numeric(period) || !is.finite(period) ||
      period < 1 || period != as.integer(period)) {
    stop("period must be one positive integer")
  }
  period <- as.integer(period)
  if (length(data) < period) {
    stop("Data length should be greater than or equal to the period")
  }

  output_length <- length(data) - period + 1L
  sma_values <- numeric(output_length)
  for (i in seq_len(output_length)) {
    current_window <- data[i:(i + period - 1L)]
    sma_values[i] <- sum(current_window) / period
  }
  return(sma_values)
}

