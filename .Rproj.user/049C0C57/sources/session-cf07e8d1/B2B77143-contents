library(shiny)
library(dplyr)
library(ggplot2)

# Load cleaned Tesla data and Roadster depreciation data from the package's data folder
tesla_stock <- readRDS(system.file("data", "cleaned_tesla_stock.rds", package = "TeslaInvestR"))
roadster_value <- readRDS(system.file("data", "roadster_depreciation.rds", package = "TeslaInvestR"))

# Ensure the 'date' column is in Date format
tesla_stock$date <- as.Date(tesla_stock$date)
roadster_value$date <- as.Date(roadster_value$date)

ui <- fluidPage(
  titlePanel("Tesla Stock vs. Tesla Roadster: Investment Comparison"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dateRange", "Select Date Range:", start = "2010-01-01", end = "2024-12-31"),
      radioButtons("investment_type", "Choose Investment Type:",
                   choices = c("Tesla Stock", "Tesla Roadster")),
      actionButton("update", "Update Plot")
    ),
    mainPanel(
      plotOutput("investmentPlot"),
      textOutput("summaryText")
    )
  )
)

server <- function(input, output) {
  # Filter stock data based on the date range
  filtered_stock_data <- reactive({
    tesla_stock %>%
      filter(date >= input$dateRange[1] & date <= input$dateRange[2])
  })

  # Filter roadster data based on the date range
  filtered_roadster_data <- reactive({
    roadster_value %>%
      filter(date >= input$dateRange[1] & date <= input$dateRange[2])
  })

  # Render plot using ggplot2
  output$investmentPlot <- renderPlot({
    if (input$investment_type == "Tesla Stock") {
      data <- filtered_stock_data()
      if (nrow(data) > 0) {  # Check if there are rows of data to plot
        ggplot(data, aes(x = date, y = investment_value)) +
          geom_line(color = "blue", size = 1) +
          labs(title = "Tesla Stock Investment Value Over Time",
               x = "Date", y = "Investment Value (USD)") +
          theme_minimal()
      } else {
        ggplot() +
          labs(title = "No data available for the selected range.") +
          theme_void()
      }
    } else {
      data <- filtered_roadster_data()
      if (nrow(data) > 0) {  # Check if there are rows of data to plot
        ggplot(data, aes(x = date, y = investment_value)) +
          geom_line(color = "red", size = 1) +
          labs(title = "Tesla Roadster Depreciation Over Time",
               x = "Date", y = "Value (USD)") +
          theme_minimal()
      } else {
        ggplot() +
          labs(title = "No data available for the selected range.") +
          theme_void()
      }
    }
  })

  # Display summary text based on investment type
  output$summaryText <- renderText({
    if (input$investment_type == "Tesla Stock") {
      "Tesla stock has seen exponential growth since 2010, providing significant returns to early investors."
    } else {
      "The Tesla Roadster has followed a typical depreciation curve for luxury vehicles, losing most of its value by 2024."
    }
  })
}

shinyApp(ui = ui, server = server)

