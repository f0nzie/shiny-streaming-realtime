
library(highcharter)
library(dplyr)
library(tidyr)

# A. Load data   ===============================================================


# B. UI   ======================================================================

ui <- fluidPage(
  titlePanel("Motion bars"),
  mainPanel(
    highchartOutput("hcontainer", height = "500px"))
)


# C. Server   ==================================================================

server = function(input, output) {
  
  output$hcontainer <- renderHighchart({
    
    hc <- highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_yAxis(max = 6, min = 0) %>% 
      hc_add_series(name = "A", data = c(2,3,4, 3, 1), zIndex = -10) %>% 
      hc_add_series(name = "B",
                    data = list(
                      list(sequence = c(1,2,3,4)),
                      list(sequence = c(3,2,1,3)),
                      list(sequence = c(6,2,1,3)),
                      list(sequence = c(6,2,1,5)),
                      list(sequence = c(2,5,4,3))
                    )) %>% 
      hc_add_series(name = "C",
                    data = list(
                      list(sequence = c(3,2,1,3)),
                      list(sequence = c(2,5,4,3)),
                      list(sequence = c(6,5,4,3)),
                      list(sequence = c(6,5,4,2)),
                      list(sequence = c(1,2,3,4))
                    )) %>% 
      hc_motion(enabled = TRUE,
                labels = 2000:2005,
                series = c(1,2, 3))
    
    hc
  })
}

# D. Run Application    ========================================================
shinyApp(ui = ui, server = server)

