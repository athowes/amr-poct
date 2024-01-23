library(shiny)

source("functions.R")

ui <- fluidPage(
  titlePanel("CEA for an AMR point-of-care test"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId = "sensitivity",
                        label = "Sensitivity:",
                        value = 0.9,
                        min = 0,
                        max = 1,
                        step = 0.01),
      numericInput(inputId = "specificity",
                        label = "Specificity:",
                        value = 0.95,
                        min = 0,
                        max = 1,
                        step = 0.01),
      numericInput(inputId = "amr_burden_per_abx",
                        label = "AMR burden per antibiotic:",
                        value = 0.3,
                        min = 0,
                        step = 0.01)
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
      "Incremental cost: $", round(out$cost_incremental), "<br>",
      "Incremental benefit: ", round(out$benefit_incremental), " DALYs <br>",
      "Incremental cost effectiveness ratio: ", round(out$icer, 2), "<br>",
      "DALYs per dollar: ", round(1 / out$icer, 4), "<br>"
    )
    return(text)
  })
}

shinyApp(ui = ui, server = server)
