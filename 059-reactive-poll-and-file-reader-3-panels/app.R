ui <- fluidPage(
  titlePanel("reactivePoll and reactiveFileReader"),
  fluidRow(
    column(12,
           p("This app has a log file which is appended to",
             "every second.")
    )
  ),
  fluidRow(
    column(4, wellPanel(
      "This side shows what is being written to the log file",
      "every 1 second.",
      verbatimTextOutput("logWriter")
    )),
    
    column(4, wellPanel(
      "This side uses a reactiveFileReader, which is monitoring",
      "the log file for changes every 0.5 seconds.",
      verbatimTextOutput("fileReaderText")
    )),
    
    column(4, wellPanel(
      "This side uses a reactivePoll, which is monitoring",
      "the log file for changes every 4 seconds.",
      verbatimTextOutput("pollText")
    ))
  )
)


server <- function(input, output, session) {
  
  # Create a random name for the log file
  logfilename <- paste0('logfile',
                        floor(runif(1, 1e+05, 1e+06 - 1)),  # round number to nearest low
                        '.txt')
  
  
  # ============================================================
  # This part of the code writes to the log file every second (1000 ms).
  # Writing to the file could be done by an external process.
  # In this example, we'll write to the file from inside the app.
  logwriter <- observe({
    # Invalidate this observer every second (1000 milliseconds)
    invalidateLater(1000, session)
    
    # Clear log file if more than 10 entries
    if (file.exists(logfilename) &&
        length(readLines(logfilename)) > 10) {
      unlink(logfilename)
    }
    
    # Add an entry to the log file
    stampTime <- Sys.time()
    cat(as.character(stampTime), '\n', file = logfilename,
        append = TRUE)
    
    # print to the first textbox from the logger itself
    output$logWriter <- renderText(as.character(stampTime))
  })
  
  # When the client ends the session, suspend the observer and
  # remove the log file.
  session$onSessionEnded(function() {
    logwriter$suspend()
    unlink(logfilename)
  })
  
  # ============================================================
  # This part of the code monitors the file for changes once per
  # 0.5 second (500 milliseconds).
  # fileReaderData() called by output$fileReaderText text box
  fileReaderData <- reactiveFileReader(500, session,
                                       logfilename, readLines)
  
  output$fileReaderText <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- fileReaderData()
    cat(length(text), "\n")
    length(text) <- 14            # set a fixed number of lines on textbox
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })
  
  
  # ============================================================
  # This part of the code monitors the file for changes once
  # every four seconds.
  # pollData() called by output$pollText box
  pollData <- reactivePoll(4000, session,
                           # This function returns the time that the logfile was last
                           # modified
                           checkFunc = function() {
                             if (file.exists(logfilename))
                               file.info(logfilename)$mtime[1]
                             else
                               ""
                           },
                           # This function returns the content of the logfile
                           valueFunc = function() {
                             readLines(logfilename)
                           }
  )
  
  output$pollText <- renderText({
    # Read the text, and make it a consistent number of lines so
    # that the output box doesn't grow in height.
    text <- pollData()
    length(text) <- 14
    text[is.na(text)] <- ""
    paste(text, collapse = '\n')
  })
}


shinyApp(ui, server)