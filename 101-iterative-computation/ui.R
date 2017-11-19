library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("New Application"),
  
  sidebarPanel(
    "Progress: ",
    textOutput("counter"),
    hr(),
    "Elapsed Time (seconds):",
    textOutput("elapsed")
  ),
  
  mainPanel(
    textOutput("x")
  )
))