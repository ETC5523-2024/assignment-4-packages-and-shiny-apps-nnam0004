#' Launch the Tesla Investment Analysis Shiny App
#'
#' This function opens a Shiny application to compare Tesla stock prices and Roadster depreciation.
#'
#' @return No return value. This function launches the Shiny app.
#' @export
TeslaViz <- function() {
  app_dir <- system.file("TeslaViz", package = "TeslaInvestR")
  if (app_dir == "") {
    stop("Could not find Shiny app directory. Ensure the app is located in inst/TeslaViz.")
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
