#ui.R
library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(

  #  Application title
  headerPanel("# Header Title Goes Here"),

  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    # Simple integer interval
    sliderInput("u1", "Name:",
                min=0, max=10000, value=10000),
    sliderInput("r1", "r1:",
                min=0, max=10000, value=10000)


  ),

  # Show a table summarizing the values entered
  mainPanel(
    tableOutput("values"),

    uiOutput("focal"))
)
)

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
