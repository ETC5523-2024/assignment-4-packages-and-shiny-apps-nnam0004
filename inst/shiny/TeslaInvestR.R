library(shiny)
library(ggplot2)
library(TeslaInvestR)  # Load your package

# Load data directly from the package
tesla_stock <- TeslaInvestR::tesla_stock
roadster_value <- TeslaInvestR::roadster_value

ui <- fluidPage(
  titlePanel("Tesla Stock vs. Tesla Roadster: Investment Comparison"),
  sidebarLayout(
    sidebarPanel(
      # Input for Date Range
      dateRangeInput("dateRange", "Select Date Range:", start = min(tesla_stock$date), end = max(tesla_stock$date)),

      # Radio button to choose investment type
      radioButtons("investment_type", "Choose Investment Type:",
                   choices = c("Tesla Stock" = "stock", "Tesla Roadster" = "roadster"))
    ),
    mainPanel(
      # Output for plot
      plotOutput("investmentPlot"),

      # Output for summary text
      textOutput("summaryText")
    )
  )
)

server <- function(input, output) {
  # Filtered data based on input
  filtered_data <- reactive({
    if (input$investment_type == "stock") {
      data <- tesla_stock
    } else {
      data <- roadster_value
    }

    # Check if the date range is valid and return the filtered data
    filtered <- data[data$date >= input$dateRange[1] & data$date <= input$dateRange[2], ]

    # Return the filtered data or a message if no data is available
    if (nrow(filtered) == 0) {
      return(NULL)  # No data available
    }

    return(filtered)
  })

  # Render Plot
  output$investmentPlot <- renderPlot({
    data <- filtered_data()

    # Check if there is data to plot
    if (is.null(data)) {
      ggplot() +
        labs(title = "No data available for the selected date range.") +
        theme_void()
    } else {
      if (input$investment_type == "stock") {
        ggplot(data, aes(x = date, y = investment_value)) +
          geom_line(color = "blue") +
          labs(title = "Tesla Stock Price", x = "Date", y = "Investment Value (USD)")
      } else {
        ggplot(data, aes(x = date, y = investment_value)) +
          geom_line(color = "red") +
          labs(title = "Tesla Roadster Value", x = "Date", y = "Depreciation Value (USD)")
      }
    }
  })

  # Render Summary Text
  output$summaryText <- renderText({
    data <- filtered_data()

    # Display appropriate text based on the investment type
    if (is.null(data)) {
      return("No data available for the selected date range.")
    }

    if (input$investment_type == "stock") {
      return("Tesla stock has seen exponential growth over the years, providing significant returns.")
    } else {
      return("The Tesla Roadster has followed a typical depreciation curve, losing most of its value by 2024.")
    }
  })
}

shinyApp(ui = ui, server = server)

