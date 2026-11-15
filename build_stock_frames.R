# AI Assistance Declaration: I used ChatGPT (OpenAI, accessed November 14, 2026) to draft a reusable base-R loader. The actual Assignment 1 stock dataset and repository link were not supplied in this session. I must verify this loader against my own dataset before submission. I am responsible for the accuracy and originality of this work.

# Build one OHLCV data frame per stock symbol using only base R.
build_stock_frames <- function(file_path) {
  if (!file.exists(file_path)) stop("stock data file was not found")
  stock_data <- read.csv(file_path, stringsAsFactors = FALSE)
  required <- c("Date", "Symbol", "Open", "High", "Low", "Close", "Volume")
  missing_columns <- setdiff(required, names(stock_data))
  if (length(missing_columns) > 0L) {
    stop(paste("Missing required columns:", paste(missing_columns, collapse = ", ")))
  }
  stock_data$Date <- as.Date(stock_data$Date)
  numeric_columns <- c("Open", "High", "Low", "Close", "Volume")
  for (column in numeric_columns) stock_data[[column]] <- as.numeric(stock_data[[column]])
  if (anyNA(stock_data[required])) stop("required stock fields contain missing or invalid values")
  stock_data <- stock_data[order(stock_data$Symbol, stock_data$Date), required]
  split(stock_data, stock_data$Symbol)
}

