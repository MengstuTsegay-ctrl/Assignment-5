# Mengstu Tsegay BDA400 Assignment 5

This repository-ready folder implements all nine indicators using base R only.

## Files

- `sma.R`, `ema.R`, `macd.R`, `stdev.R`, `linreg.R`, `rsi.R`, `stoch_rsi.R`, `crossover.R`, and `crossunder.R`: required implementations.
- `run_all_tests.R`: synthetic normal-case, edge-case, and invariant tests.
- `build_stock_frames.R`: reusable loader for the student's Assignment 1 OHLCV dataset.
- `MengstuTsegay_BDA400_A05.docx`: implementation explanations and run instructions.

## Run

1. Open the folder as an RStudio Project or set it as the working directory.
2. Run `source("run_all_tests.R")`.
3. Confirm the Console ends with `ALL TESTS PASSED`.
4. Run `build_stock_frames("your_assignment1_stock_file.csv")` after adding the actual stock dataset.
5. Add the verified repository URL to the cover page before submission.

## Important

The Assignment 1 stock dataset was not found. This package uses an alternative AAPL historical CSV supplied by the student. The repository URL still needs to be verified and added before submission. Do not claim the real-data RStudio test has passed until it has been executed.


## Historical AAPL data (included)

- `AAPL_2024_OHLCV.csv`: 2024 daily OHLCV data filtered from the user-supplied `ohlcv.csv` downloaded from `https://pubmarks.github.io/datasets/stocks/AAPL/ohlcv.csv`. Source is attributed to the download location supplied in this conversation; the upstream provider and adjustment policy were not independently verified.
- `test_with_aapl.R`: loads the included CSV and computes all nine indicators using base R.
- In RStudio, set the working directory to this folder, then run `source("test_with_aapl.R")`.
- Also run `source("run_all_tests.R")` and capture screenshots of both successful console outputs.
- Upload the verified folder to your own GitHub repository and put its actual URL on the Word cover page.

The real-data test has not been executed in RStudio in this environment. The source CSV has been checked for required fields, and the 2024 subset is packaged.
