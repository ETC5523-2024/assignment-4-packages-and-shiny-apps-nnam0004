library(shiny)
library(ggplot2)
library(TeslaInvestR)  # Load your package

# Load data directly from the package
tesla_stock <- TeslaInvestR::filtered_tesla_stock
roadster_value <- TeslaInvestR::filtered_roadster_value

# Ensure date columns are in Date format
tesla_stock$Date <- as.Date(tesla_stock$Date)
roadster_value$date <- as.Date(roadster_value$date)

ui <- fluidPage(
  titlePanel("Tesla Stock vs. Tesla Roadster: Investment Comparison"),
  sidebarLayout(
    sidebarPanel(
      # Input for Date Range
      dateRangeInput("dateRange", "Select Date Range:",
                     start = min(tesla_stock$Date),
                     end = max(tesla_stock$Date)),

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
      date_col <- "Date"  # Use "Date" column for tesla_stock
    } else {
      data <- roadster_value
      date_col <- "date"  # Use "date" column for roadster_value
    }

    # Filter data based on date range
    filtered <- data[data[[date_col]] >= input$dateRange[1] & data[[date_col]] <= input$dateRange[2], ]

    # Return filtered data or NULL if no data is available
    if (nrow(filtered) == 0) {
      return(NULL)
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
      ggplot(data, aes_string(x = if (input$investment_type == "stock") "Date" else "date",
                              y = "investment_value")) +
        geom_line(color = if (input$investment_type == "stock") "blue" else "red") +
        labs(title = paste(input$investment_type == "stock" ? "Tesla Stock Price" : "Tesla Roadster Value"),
             x = "Date", y = "Investment/Depreciation Value (USD)")
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
