#server.R
library(shiny)

shinyServer(function(input, output) {

  # Reactive expression to compose a data frame containing all of the values
  sliderValues <- reactive({

    # Compose data frame
    data.frame(
      Name = c("u1", "r1"),

      Value = c(input$u1,
                input$r1),

      stringsAsFactors=FALSE)
  })

  f <- function(u1, r1) {
    u1 + r1
  }


  # Show the values using an HTML table
  output$values <- renderTable({
    sliderValues()
  })

  # Show the final calculated value
  output$focal <- renderText(
    {f(input$u1, input$r1)}
  )
})
