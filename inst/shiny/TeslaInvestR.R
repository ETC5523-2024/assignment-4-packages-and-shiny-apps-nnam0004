library(shiny)
library(shinydashboard)
library(ggplot2)
library(TeslaInvestR)  # Load your package

# Load data directly from the package
tesla_stock_filtered <- TeslaInvestR::filtered_tesla_stock
roadster_value_filtered <- TeslaInvestR::filtered_roadster_value

# Ensure date columns are in Date format
tesla_stock_filtered$Date <- as.Date(tesla_stock_filtered$Date)
roadster_value_filtered$date <- as.Date(roadster_value_filtered$date)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Tesla Investment Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
    )
  ),
  dashboardBody(
    # Custom CSS to style background and panels
    tags$head(
      tags$style(HTML("
        body, .content-wrapper { background-color: #f0f2f5; }
        .box { background-color: #ffffff; border-radius: 8px; padding: 15px; }
        .box-primary { border-top: 3px solid #007bff; }
        .box-info { border-top: 3px solid #17a2b8; }
      "))
    ),
    tabItem(tabName = "dashboard",
            fluidRow(
              # Investment Comparison Controls with Explanations
              box(title = "Investment Comparison Controls", status = "primary", solidHeader = TRUE, width = 4,
                  p("Select a date range and investment type to compare Tesla Stock growth with Tesla Roadster depreciation."),
                  dateRangeInput("dateRange", "Select Date Range:",
                                 start = min(tesla_stock_filtered$Date),
                                 end = max(tesla_stock_filtered$Date)),
                  p(paste("The date range input allows you to filter the data within specific dates (",
                          format(min(tesla_stock_filtered$Date), "%Y-%m-%d"), "to",
                          format(max(tesla_stock_filtered$Date), "%Y-%m-%d"), ") for a more tailored analysis.")),
                  radioButtons("investment_type", "Choose Investment Type:",
                               choices = c("Tesla Stock" = "stock", "Tesla Roadster" = "roadster")),
                  p("The investment type selector changes the displayed data, allowing you to focus on either Tesla stock prices or Roadster depreciation.")
              ),

              # Investment Comparison Plot with Explanation
              box(title = "Investment Comparison Plot", status = "primary", solidHeader = TRUE, width = 8,
                  plotOutput("investmentPlot"),
                  p("The plot illustrates the investment or depreciation value over the selected date range.
              Blue lines represent Tesla Stock, while red lines show Tesla Roadster depreciation.")
              ),

              # Investment Summary Interpretation
              box(title = "Investment Summary", status = "info", solidHeader = TRUE, width = 12,
                  textOutput("summaryText"),
                  p("Interpretation: The summary provides insight into the general trend of the selected investment.
              Tesla stock tends to show growth over time, while the Tesla Roadster exhibits a depreciation curve.")
              )
            )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Filtered data based on input
  filtered_data <- reactive({
    if (input$investment_type == "stock") {
      data <- tesla_stock_filtered
      date_col <- "Date"
    } else {
      data <- roadster_value_filtered
      date_col <- "date"
    }

    filtered <- data[data[[date_col]] >= input$dateRange[1] & data[[date_col]] <= input$dateRange[2], ]
    if (nrow(filtered) == 0) return(NULL)
    return(filtered)
  })

  # Render Plot
  output$investmentPlot <- renderPlot({
    data <- filtered_data()
    if (is.null(data)) {
      ggplot() +
        labs(title = "No data available for the selected date range.") +
        theme_void()
    } else {
      ggplot(data, aes_string(x = if (input$investment_type == "stock") "Date" else "date",
                              y = "investment_value")) +
        geom_line(color = if (input$investment_type == "stock") "blue" else "red", size = 1.2) +
        geom_point(color = if (input$investment_type == "stock") "darkblue" else "darkred", size = 2) +
        labs(title = if (input$investment_type == "stock") "Tesla Stock Price Over Time" else "Tesla Roadster Depreciation",
             x = "Date", y = "Value (USD)") +
        theme_minimal(base_size = 14) +
        theme(
          plot.title = element_text(face = "bold", size = 16, hjust = 0.5),
          axis.title = element_text(face = "bold"),
          panel.grid.major = element_line(color = "gray80"),
          panel.grid.minor = element_blank()
        ) +
        scale_x_date(date_labels = "%Y", date_breaks = "2 years") +
        scale_y_continuous(labels = scales::dollar_format())
    }
  })

  # Render Summary Text
  output$summaryText <- renderText({
    data <- filtered_data()
    if (is.null(data)) return("No data available for the selected date range.")
    if (input$investment_type == "stock") {
      "Tesla stock has seen exponential growth over the years, providing significant returns."
    } else {
      "The Tesla Roadster has followed a typical depreciation curve, losing most of its value by 2024."
    }
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
