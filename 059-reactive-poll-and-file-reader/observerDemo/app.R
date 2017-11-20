#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Observer demo"),
  fluidRow(
    column(4, wellPanel(
      sliderInput("n", "N:",
                  min = 10, max = 1000, value = 200, step = 10)
    )),
    column(8,
           verbatimTextOutput("text"),
           br(),
           br(),
           p("In this example, what's visible in the client isn't",
             "what's interesting. The server is writing to a log",
             "file each time the slider value changes.")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),
                        '.txt')
  
  
  # This observer adds an entry to the log file every time
  # input$n changes.
  obs <- observe({    
    cat(input$n, '\n', file = logfilename, append = TRUE)
  })
  
  
  session$onSessionEnded(function() {
    # When the client ends the session, clean up the log file
    # for this session.
    unlink(logfilename)
  })
  
  
  output$text <- renderText({
    paste0("The value of input$n is: ", input$n)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

