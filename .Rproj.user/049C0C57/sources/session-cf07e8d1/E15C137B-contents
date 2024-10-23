# Clean Tesla stock data
tesla_stock <- read.csv("data-raw//TSLA.csv")
tesla_stock$date <- as.Date(tesla_stock$date)
tesla_stock$investment_value <- tesla_stock$Adj_Close * 28385  # Assuming initial investment in shares

# Save cleaned Tesla stock data
saveRDS(tesla_stock, file = "data/cleaned_tesla_stock.rds")


# Create Tesla Roadster depreciation data
roadster_value <- data.frame(
  date = seq(as.Date("2010-01-01"), as.Date("2024-12-31"), by = "year"),
  investment_value = c(109000, 87200, 78480, 70632, 63569, 60391, 57371, 54502, 51777, 49188, 46729, 44400, 42180, 40071, 38067)
)


# Save Tesla Roadster depreciation data
saveRDS(roadster_value, file = "data/roadster_depreciation.rds")
