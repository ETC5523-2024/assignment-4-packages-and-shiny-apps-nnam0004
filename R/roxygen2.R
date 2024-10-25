#' Server function for Tesla Investment Comparison Shiny App
#'
#' This function manages the server-side logic of the Shiny app that compares
#' Tesla stock prices and Tesla Roadster depreciation.
#'
#' @param input Shiny input object containing user inputs such as date range
#' and investment type.
#' @param output Shiny output object for rendering the plot and text outputs.
#' @param session Shiny session object (optional).
#'
#' @return None. The function renders outputs directly to the Shiny UI.
#'
#' @examples
#' \dontrun{
#' shinyApp(ui = ui, server = server)
#' }
#'
#' @export
server <- function(input, output) {
  # Server logic here...
}


#' Filtered Tesla Stock Data
#'
#' This dataset contains filtered historical Tesla stock data, which includes
#' adjusted closing prices and calculated investment value based on an initial
#' investment of 28,385 shares. The dataset is filtered from 2011 to 2023.
#'
#' @format A data frame with 3567 rows and 8 variables:
#' \describe{
#'   \item{Date}{The date of the stock price in \code{Date} format.}
#'   \item{Adj_Close}{The adjusted closing price of Tesla stock.}
#'   \item{investment_value}{The investment value calculated based on an initial investment.}
#' }
#'
#' @source Yahoo Finance
#'
#' @examples
#' data(filtered_tesla_stock)
#' head(filtered_tesla_stock)
#'
#' @export
"filtered_tesla_stock"


#' Filtered Tesla Roadster Depreciation Data
#'
#' This dataset contains yearly depreciation values for the Tesla Roadster
#' from 2010 to 2024. The data represents the depreciation of the vehicle
#' over time.
#'
#' @format A data frame with 15 rows and 2 variables:
#' \describe{
#'   \item{date}{The year of depreciation in \code{Date} format.}
#'   \item{investment_value}{The depreciation value of the Tesla Roadster in USD.}
#' }
#'
#' @examples
#' data(filtered_roadster_value)
#' head(filtered_roadster_value)
#'
#' @export
"filtered_roadster_value"

