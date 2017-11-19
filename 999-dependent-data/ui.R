# ui.R
######

library(shiny)

shinyUI(pageWithSidebar(

  headerPanel("New Application"),

  sidebarPanel(
    htmlOutput("dateInput"),
    htmlOutput("prodInput")
  ),

  mainPanel(
    plotOutput("salesplot")
  )

))
