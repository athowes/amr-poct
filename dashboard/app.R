library(shiny)

source(here::here("functions.R"))

ui <- fluidPage(
  titlePanel("Cost effectiveness analysis for an AMR point-of-care test"),
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
        p("As compared with treating all low-risk neonates with antibiotics, use of an AMR point of care test, with parameters as specified on the input panel, would result in:"),
        p(htmlOutput(outputId = "ceaOutput")),
        p("For more details about the model, see", tags$a(href = "https://athowes.github.io/amr-poct/model", "athowes.github.io/amr-poct/model.")),
        p("This analysis is a project of ", tags$a(href = "https://www.amrfundingcircle.com/", "AMR Funding Circle."))
    )
  )
)

server <- function(input, output) {
  output$ceaOutput <- renderText({
    out <- run_cea(input$sensitivity, input$specificity, input$amr_burden_per_abx)
    text <- paste0(
      "<b>Incremental cost</b>: $", round(out$cost_incremental), "<br>",
      "<b>Incremental benefit</b>: ", round(out$benefit_incremental), " DALYs <br>",
      "<b>Incremental cost effectiveness ratio</b>: ", round(out$icer, 2), "<br>",
      "<b>DALYs per dollar</b>: ", round(1 / out$icer, 4), "<br>"
    )
    return(text)
  })
}

shinyApp(ui = ui, server = server)
