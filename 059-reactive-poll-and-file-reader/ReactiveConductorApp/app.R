# ReactiveConductorApp

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   textOutput("nthValue"),
   textOutput("nthValueInv")
   
)

fib <- function(n) ifelse(n<3, 1, fib(n-1)+fib(n-2))

server <- function(input, output) {
  currentFib <- reactive({ fib(as.numeric(input$n)) })
  
  output$nthValue <- renderText({ currentFib() })
  output$nthValueInv <- renderText({ 1 / currentFib() })
}

  

# Run the application 
shinyApp(ui = ui, server = server)

