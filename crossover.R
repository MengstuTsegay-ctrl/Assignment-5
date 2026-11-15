# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Crossover signals: Up, Down, or None
crossover <- function(arr1, arr2) {
  if (!is.numeric(arr1) || !is.numeric(arr2) || any(!is.finite(arr1)) ||
      any(!is.finite(arr2))) {
    stop("arr1 and arr2 must contain only finite numeric values")
  }
  if (length(arr1) != length(arr2)) {
    stop("Both arrays should have the same length")
  }
  if (length(arr1) == 0L) stop("arrays cannot be empty")

  crossover_signals <- rep("None", length(arr1))
  if (length(arr1) > 1L) {
    for (i in 2:length(arr1)) {
      if (arr1[i] > arr2[i] && arr1[i - 1L] <= arr2[i - 1L]) {
        crossover_signals[i] <- "Up"
      } else if (arr1[i] < arr2[i] && arr1[i - 1L] >= arr2[i - 1L]) {
        crossover_signals[i] <- "Down"
      }
    }
  }
  return(crossover_signals)
}

