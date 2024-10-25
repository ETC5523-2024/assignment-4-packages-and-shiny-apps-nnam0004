# Load necessary libraries
library(dplyr)
library(usethis)

# Load the Tesla stock data from the CSV file
tesla_stock <- read.csv("data-raw//TSLA.csv")

# Convert the Date column to Date format (DD/MM/YY)
tesla_stock$Date <- as.Date(tesla_stock$Date, format = "%d/%m/%y")

# Inspect the data to ensure Date conversion is correct
head(tesla_stock)

# Add an investment_value column (assuming an initial investment in 28385 shares)
tesla_stock$investment_value <- tesla_stock$Adj_Close * 28385  # Assuming an initial investment

# Filter Tesla stock data within a specific date range (for example: 2011-01-01 to 2023-12-31)
filtered_tesla_stock <- tesla_stock %>%
  filter(Date >= as.Date("2011-01-01") & Date <= as.Date("2023-12-31"))

# Save the filtered Tesla stock data into the package
usethis::use_data(filtered_tesla_stock, overwrite = TRUE)

# Prepare Tesla Roadster depreciation data
roadster_value <- data.frame(
  date = seq(as.Date("2010-01-01"), as.Date("2024-12-31"), by = "year"),
  investment_value = c(109000, 87200, 78480, 70632, 63569, 60391, 57371, 54502, 51777, 49188, 46729, 44400, 42180, 40071, 38067)
)

# Filter Tesla Roadster data within a specific date range (for example: 2015-01-01 to 2020-12-31)
filtered_roadster_value <- roadster_value %>%
  filter(date >= as.Date("2010-01-01") & date <= as.Date("2024-12-31"))

# Save the filtered Tesla Roadster depreciation data into the package
usethis::use_data(filtered_roadster_value, overwrite = TRUE)

