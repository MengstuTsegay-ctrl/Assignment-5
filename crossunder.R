# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for code-structure suggestions and edge-case ideas. I reviewed the algorithm against the assignment template and pseudocode. Final verification must be completed by running the supplied tests in RStudio. I am responsible for the accuracy and originality of this work.

# Crossunder events: TRUE when arr1 moves from at/above arr2 to below arr2
crossunder <- function(arr1, arr2) {
  if (!is.numeric(arr1) || !is.numeric(arr2) || any(!is.finite(arr1)) ||
      any(!is.finite(arr2))) {
    stop("arr1 and arr2 must contain only finite numeric values")
  }
  if (length(arr1) != length(arr2)) {
    stop("Both arrays should have the same length")
  }
  if (length(arr1) == 0L) stop("arrays cannot be empty")

  crossunder_signals <- rep(FALSE, length(arr1))
  if (length(arr1) > 1L) {
    for (i in 2:length(arr1)) {
      crossunder_signals[i] <-
        arr1[i] < arr2[i] && arr1[i - 1L] >= arr2[i - 1L]
    }
  }
  return(crossunder_signals)
}

