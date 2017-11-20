# sessionClientDataApp
# https://shiny.rstudio.com/articles/client-data.html

ui <- pageWithSidebar(
  headerPanel("Shiny Client Data"),
  sidebarPanel(
    sliderInput("obs", "Number of observations:",
                min = 0, max = 1000, value = 500)
  ),
  mainPanel(
    h3("clientData values"),
    verbatimTextOutput("clientdataText"),
    plotOutput("myplot")
  )
)

server <- function(input, output, session) {
  # Store in a convenience variable
  cdata <- session$clientData
  
  # Values from cdata returned as text
  output$clientdataText <- renderText({
    cnames <- names(cdata)
    
    allvalues <- lapply(cnames, function(name) {
      paste(name, cdata[[name]], sep = " = ")
    })
    paste(allvalues, collapse = "\n")
  })
  
  # A histogram
  output$myplot <- renderPlot({
    hist(rnorm(input$obs), main = "Generated in renderPlot()")
  })
}

shinyApp(ui, server)