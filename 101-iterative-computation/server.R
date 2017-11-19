library(shiny)

shinyServer(function(input, output, session) {
  # The number of iterations to perform
  maxIter <- 50
  
  # Track the start and elapsed time
  startTime <- Sys.time()  
  output$elapsed <- renderText({
    vals$x
    round(Sys.time() - startTime)
  })
  
  # Create a reactiveValues object where we can track some extra elements
  # reactively.
  vals <- reactiveValues(x = 0, counter = 0)
  
  # Update the percentage complete
  output$counter <- renderText({
    paste0(round(vals$counter/maxIter * 100, 1), "%")
  })
  
  # Show the value of x
  output$x <- renderText({
    round(vals$x,2)
  })
  
  # Do the actual computation here.
  observe({
    isolate({
      # This is where we do the expensive computing
      sum <- 0
      for (i in 1:100000){
        sum <- sum + rnorm(1)
      }
      vals$x <- vals$x + sum
      
      # Increment the counter
      vals$counter <- vals$counter + 1  
    })
    
    # If we're not done yet, then schedule this block to execute again ASAP.
    # Note that we can be interrupted by other reactive updates to, for
    # instance, update a text output.
    if (isolate(vals$counter) < maxIter){
      invalidateLater(0, session)
    }
  })
  
})