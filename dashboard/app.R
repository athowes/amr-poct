library(shiny)

source("functions.R")

ui <- fluidPage(
  titlePanel("Cost effectiveness analysis for an AMR point-of-care test"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "sensitivity",
                   label = "Sensitivity:",
                   value = 0.9),
      numericInput(inputId = "specificity",
                   label = "Specificity:",
                   value = 0.95),
      numericInput(inputId = "amr_burden_per_abx",
                   label = "AMR burden per antibiotic:",
                   value = 0.3)
    ),
    mainPanel(
      htmlOutput(outputId = "ceaOutput")
    )
  )
)

server <- function(input, output) {
  output$ceaOutput <- renderText({
    out <- run_cea(input$sensitivity, input$specificity, input$amr_burden_per_abx)
    text <- paste0(
      "ICER: ", out$icer, "<br>",
      "Incremental cost ($): ", out$cost_incremental, "<br>",
      "Incremental benefit (DALYs): ", out$benefit_incremental
    )
    return(text)
  })
}

shinyApp(ui = ui, server = server)
