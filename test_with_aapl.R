# Run with the included AAPL_2024_OHLCV.csv; no internet connection required.
source("build_stock_frames.R")
frames <- build_stock_frames("AAPL_2024_OHLCV.csv")
stopifnot("AAPL" %in% names(frames), nrow(frames$AAPL) >= 60)
prices <- frames$AAPL$Close
for (f in c("sma.R", "ema.R", "macd.R", "stdev.R", "linreg.R",
            "rsi.R", "stoch_rsi.R", "crossover.R", "crossunder.R")) source(f)
results <- list(
  SMA_20 = sma(prices, 20),
  EMA_20 = ema(prices, 20),
  MACD = macd(prices, 12, 26, 9),
  STDEV = stdev(prices),
  LINREG = linreg(prices, 30, 0),
  RSI_14 = rsi(prices, 14),
  STOCH_RSI = stoch_rsi(prices, 14, 3, 3)
)
results$CROSSOVER <- crossover(results$EMA_20, ema(prices, 50))
results$CROSSUNDER <- crossunder(results$EMA_20, ema(prices, 50))
stopifnot(all(is.finite(tail(results$EMA_20, 10))), is.finite(results$STDEV))
cat("REAL AAPL DATA TEST COMPLETED: ", nrow(frames$AAPL), " rows\n", sep = "")
print(lapply(results, function(x) if (is.list(x)) names(x) else tail(x, 3)))
