# Load necessary libraries
library(usethis)
library(dplyr)

# Load the tesla_stock data
load("path/to/tesla_stock.rda")  # Replace with the correct path

# Inspect the Date column to determine its format
head(tesla_stock$Date)

# Ensure the date column is in Date format (adjust format string as needed)
tesla_stock$date <- as.Date(tesla_stock$Date, format = "%Y-%m-%d")  # Change format if needed

# Add an investment_value column (assuming initial investment)
tesla_stock$investment_value <- tesla_stock$Adj_Close * 28385  # Assuming initial investment

# Filter Tesla stock data within a specific date range (for example: 2011-01-01 to 2023-12-31)
filtered_tesla_stock <- tesla_stock %>%
  filter(date >= as.Date("2011-01-01") & date <= as.Date("2023-12-31"))

# Save the filtered Tesla stock data into the package
usethis::use_data(filtered_tesla_stock, overwrite = TRUE)

# Prepare Tesla Roadster depreciation data
roadster_value <- data.frame(
  date = seq(as.Date("2010-01-01"), as.Date("2024-12-31"), by = "year"),
  investment_value = c(109000, 87200, 78480, 70632, 63569, 60391, 57371, 54502, 51777, 49188, 46729, 44400, 42180, 40071, 38067)
)

# Filter Tesla Roadster data within a specific date range (for example: 2015-01-01 to 2020-12-31)
filtered_roadster_value <- roadster_value %>%
  filter(date >= as.Date("2015-01-01") & date <= as.Date("2020-12-31"))

# Save the filtered Tesla Roadster depreciation data into the package
usethis::use_data(filtered_roadster_value, overwrite = TRUE)

