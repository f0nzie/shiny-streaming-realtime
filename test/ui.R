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


