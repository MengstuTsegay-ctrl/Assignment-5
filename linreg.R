# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Simple Linear Regression over the assignment-defined subset
linreg <- function(regressionSource, regressionLength, regressionOffset) {
  if (!is.numeric(regressionSource) || length(regressionSource) < 2L ||
      any(!is.finite(regressionSource))) {
    stop("regressionSource must contain at least two finite numeric values")
  }
  if (length(regressionLength) != 1L || !is.numeric(regressionLength) ||
      !is.finite(regressionLength) || regressionLength < 2 ||
      regressionLength != as.integer(regressionLength)) {
    stop("regressionLength must be an integer of at least 2")
  }
  if (length(regressionOffset) != 1L || !is.numeric(regressionOffset) ||
      !is.finite(regressionOffset) || regressionOffset < 0 ||
      regressionOffset != as.integer(regressionOffset)) {
    stop("regressionOffset must be a non-negative integer")
  }
  regressionLength <- as.integer(regressionLength)
  regressionOffset <- as.integer(regressionOffset)
  n <- length(regressionSource)
  if (regressionLength > n) {
    stop("regressionLength cannot be greater than the number of elements in regressionSource")
  }
  if (regressionOffset >= regressionLength) {
    stop("regressionOffset must be less than regressionLength")
  }

  start_index <- max(1L, n - regressionLength + regressionOffset)
  end_index <- min(n, n - regressionOffset)
  source_subset <- regressionSource[start_index:end_index]
  if (length(source_subset) < 2L) {
    stop("the selected regression subset must contain at least two values")
  }

  index_values <- seq_along(source_subset)
  mean_index <- sum(index_values) / length(index_values)
  mean_source <- sum(source_subset) / length(source_subset)
  numerator <- sum((index_values - mean_index) * (source_subset - mean_source))
  denominator <- sum((index_values - mean_index)^2)
  if (denominator == 0) {
    stop("linear regression denominator is zero")
  }
  slope <- numerator / denominator
  intercept <- mean_source - slope * mean_index
  predicted_values <- slope * index_values + intercept

  result <- list(
    slope = slope,
    intercept = intercept,
    predicted_values = predicted_values
  )
  return(result)
}

