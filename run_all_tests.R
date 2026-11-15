# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) for test-structure suggestions. I must run these tests in RStudio and review the outputs before submission. I am responsible for the accuracy and originality of this work.

source("sma.R")
source("ema.R")
source("macd.R")
source("stdev.R")
source("linreg.R")
source("rsi.R")
source("stoch_rsi.R")
source("crossover.R")
source("crossunder.R")

close_prices <- c(10, 12, 15, 20, 18, 22, 25, 24, 21, 27,
                  29, 28, 31, 34, 33, 36, 38, 37, 40, 43)

cat("Test 1: SMA\n")
sma_result <- sma(close_prices, 3)
stopifnot(isTRUE(all.equal(sma_result[1], (10 + 12 + 15) / 3)))
stopifnot(length(sma_result) == length(close_prices) - 3 + 1)

cat("Test 2: EMA\n")
ema_result <- ema(c(10, 12, 15), 3)
stopifnot(isTRUE(all.equal(ema_result, c(10, 11, 13))))

cat("Test 3: MACD\n")
macd_result <- macd(close_prices, 3, 5, 2)
stopifnot(all(names(macd_result) == c("macd_line", "signal_line", "histogram")))
stopifnot(length(macd_result$macd_line) == length(close_prices))
stopifnot(isTRUE(all.equal(macd_result$histogram,
                           macd_result$macd_line - macd_result$signal_line)))

cat("Test 4: population standard deviation\n")
sd_result <- stdev(c(2, 4, 4, 4, 5, 5, 7, 9))
stopifnot(isTRUE(all.equal(sd_result, 2)))

cat("Test 5: linear regression\n")
regression_result <- linreg(c(2, 4, 6, 8, 10), 5, 0)
stopifnot(isTRUE(all.equal(regression_result$slope, 2)))
stopifnot(isTRUE(all.equal(regression_result$intercept, 0)))
stopifnot(isTRUE(all.equal(regression_result$predicted_values, c(2, 4, 6, 8, 10))))

cat("Test 6: RSI\n")
rsi_result <- rsi(close_prices, 5)
valid_rsi <- rsi_result[is.finite(rsi_result)]
stopifnot(length(valid_rsi) == length(close_prices) - 5)
stopifnot(all(valid_rsi >= 0 & valid_rsi <= 100))

cat("Test 7: Stochastic RSI\n")
stoch_result <- stoch_rsi(close_prices, 5, 3, 3)
valid_k <- stoch_result$k_line[is.finite(stoch_result$k_line)]
valid_d <- stoch_result$d_line[is.finite(stoch_result$d_line)]
stopifnot(length(valid_k) > 0L, length(valid_d) > 0L)
stopifnot(all(valid_k >= 0 & valid_k <= 1))
stopifnot(all(valid_d >= 0 & valid_d <= 1))

cat("Test 8: crossover\n")
arr1 <- c(1, 2, 4, 2, 1)
arr2 <- c(3, 3, 3, 3, 3)
crossover_result <- crossover(arr1, arr2)
stopifnot(identical(crossover_result, c("None", "None", "Up", "Down", "None")))

cat("Test 9: crossunder\n")
crossunder_result <- crossunder(arr1, arr2)
stopifnot(identical(crossunder_result, c(FALSE, FALSE, FALSE, TRUE, FALSE)))

cat("Test 10: controlled errors\n")
stopifnot(inherits(try(sma(c(1, 2), 3), silent = TRUE), "try-error"))
stopifnot(inherits(try(crossover(c(1, 2), c(1)), silent = TRUE), "try-error"))
stopifnot(inherits(try(rsi(c(1, 2, 3), 3), silent = TRUE), "try-error"))

cat("ALL TESTS PASSED\n")

