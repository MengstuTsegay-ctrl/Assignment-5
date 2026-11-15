# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Population Standard Deviation
stdev <- function(data) {
  if (!is.numeric(data) || length(data) == 0L || any(!is.finite(data))) {
    stop("data must be a non-empty numeric vector containing only finite values")
  }

  mean_value <- sum(data) / length(data)
  diff_values <- data - mean_value
  squared_diff <- diff_values * diff_values
  variance <- sum(squared_diff) / length(squared_diff)
  standard_deviation <- sqrt(variance)
  return(standard_deviation)
}

