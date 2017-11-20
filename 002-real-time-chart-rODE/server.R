# Do not use UTC zone, otherwise we get different time plotted
hcGopts <- getOption("highcharter.global")
hcGopts$useUTC <- FALSE
options(highcharter.global = hcGopts)


shinyServer(function(input, output, session) {
  
  newvalue <- reactive({
    invalidateLater(1000)
    newvalue <- runif(1)
    newtime  <- Sys.time()
    # message(sprintf("New value at %s is %s", newtime, newvalue))
    list(newtime, newvalue)
  })
  
  output$valtoupdate <- renderText({
    newvalue()[[2]]
  })
  
  output$timetoupdate <- renderText({
    # cat(newvalue()[[1]], "\n")
    # strftime(newvalue()[[1]])  # without conversion the number: 1510969473
    newvalue()[[1]]
  })
  
  
  
  
  output$hc <- renderHighchart({
    
    hc <- data.frame(time = datetime_to_timestamp(Sys.time()), value = 0) %>%
      hchart("line", hcaes(time, value)) %>% 
      hc_xAxis(type = "datetime")   
    
    hc$x$type <- "stock"
    hc
  })
})