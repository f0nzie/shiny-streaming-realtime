
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(highcharter)
library(lubridate)
shinyUI(fluidPage(
  # Application title
  titlePanel("Real-time stock trading chart (Only update realtime from 9h to 15h)"),
  sidebarLayout(fluid = TRUE,
                sidebarPanel(
                  selectInput("theme", label = "Pick theme", width = "100%",
                              choices = c(FALSE, "fivethirtyeight", "economist",
                                          "darkunica", "gridlight", "sandsignika",
                                          "null", "handdrwran", "chalk","google", "sparkline")),
                  selectInput("kl", label = "Last matched number", width = "100%",
                              choices = c("10","20", "30", "40", "50", "100", "all")), width = 3)
                ,
                mainPanel(
                  if (hour(now()))
                  highchartOutput("stockPlot")
                )
  )
))
