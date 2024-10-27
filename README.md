
# TeslaInvestR

## Overview

**TeslaInvestR** is an R package designed for analyzing Tesla investment
data. It provides users with access to historical Tesla stock price data
and Tesla Roadster depreciation data, enabling direct comparisons
between stock investment growth and vehicle depreciation. The package
includes easy-to-use functions for financial analysis, interactive data
visualization with `ggplot2`, and a user-friendly Shiny app.

## Key Features

- **Tesla Stock Data**: Access Tesla stock price data from 2011 to 2023,
  including adjusted close prices and computed investment values based
  on an initial investment.

- **Tesla Roadster Depreciation Data**: View simulated annual
  depreciation values for Tesla Roadsters from 2010 to 2024.

- **Interactive Visualization**: Use the Shiny app to explore and
  compare Tesla stock and Roadster depreciation trends in real time,
  including adjustable date ranges and investment type filtering.

- **Analysis Tools**: Built-in functions for filtering data by date,
  calculating investment growth, and visualizing both stock and
  depreciation data.

## Installation

Install the **TeslaInvestR** package directly from GitHub:

``` r
# Install TeslaInvestR from GitHub
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-nnam0004")
```

## Usage

### 1. Launching the Shiny App

Run the Shiny app to interactively explore Tesla investment data:

``` r
library(TeslaInvestR)
launch_shiny_app()
```

### 2. Comparing Stock and Depreciation Data with ggplot2

``` r
library(ggplot2)
# Load filtered data for analysis
tesla_data <- TeslaInvestR::filtered_tesla_stock
roadster_data <- TeslaInvestR::filtered_roadster_value

# Plotting Tesla stock vs. Roadster depreciation over time
ggplot() +
  geom_line(data = tesla_data, aes(x = Date, y = investment_value), color = "blue") +
  geom_line(data = roadster_data, aes(x = date, y = investment_value), color = "red") +
  labs(title = "Tesla Stock Investment vs. Roadster Depreciation",
       x = "Date", y = "Value (USD)") +
  theme_minimal()
```

## Data Sources

- **Tesla Stock Data**: Sourced from Yahoo Finance, covering the period
  from 2011 to 2023.
- **Tesla Roadster Depreciation Data**: Simulated data representing
  yearly depreciation of Tesla Roadsters from 2010 to 2024.

## License

This project is licensed under the MIT License. See the `LICENSE` file
for details.

## Contributions

Contributions are welcome! Feel free to fork the repository, submit pull
requests, or report issues to help improve the package.

## Documentation

For full documentation and tutorials, visit the pkgdown site here:
[TeslaInvestR
Documentation](https://etc5523-2024.github.io/assignment-4-packages-and-shiny-apps-nnam0004/).
