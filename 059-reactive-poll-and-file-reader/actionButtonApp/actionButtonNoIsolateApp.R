# actionButtonApp
# press a button to change the plot
  
  ui <- fluidPage(
    titlePanel("actionButton with no isolate()"),
    sliderInput("obs", "Number of observations", 0, 1000, 500),
    actionButton("goButton", "Go!"),
    plotOutput("distPlot"),
    textOutput("mn")
  )
  
  server <- function(input, output) {
    output$distPlot <- renderPlot({
      # Take a dependency on input$goButton. This will run once initially,
      # because the value changes from NULL to 0.
      input$goButton
      
      # Use isolate() to avoid dependency on input$obs
      # this means that if the slider is being moved the plot does not change
        # dist <- isolate(rnorm(input$obs))
      
      # if we do not use isolate, then the plot instantly redraws
        dist <- rnorm(input$obs)
      
      mn <- mean(dist)
      output$mn <- renderText(mn)
      hist(dist)
    })
    

    
  }
  
  shinyApp(ui, server)
  