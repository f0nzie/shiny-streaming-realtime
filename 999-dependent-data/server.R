#server.R
#########

library(shiny)
library(filehash)

set.seed(1)

dates    <- format(seq(Sys.Date() - 10, Sys.Date(), "days"), "%Y-%m-%d")
products <- LETTERS
prices   <- sample(10:100, size = length(products), replace = TRUE)
names(prices) <- LETTERS

if (file.exists("exampledb")) {

  db <- dbInit("exampledb")

} else {

  dbCreate("exampledb")
  db <- dbInit("exampledb")

  for (d in dates) {
    no.sales <- sample(50:100, size = 1)
    x <- data.frame(
      product     = sample(products, size = no.sales, replace = TRUE)
      ,hour        = sample(8:20, size = no.sales, replace = TRUE)
      ,order.size  = sample(1:10, size = no.sales, replace = TRUE)
    )
    x$price <- prices[x$product]
    dbInsert(db, paste0("sales", gsub("-", "", d)), x)
  }
}


current <- reactiveValues()

shinyServer(function(input, output) {

  inputDates <- reactive({
    sort(strptime(unique(substr(names(db), 6, 13)), "%Y%m%d"))
  })

  output$dateInput <-  renderUI({ dateInput(
    inputId    = "date",
    label      = "Choose hour",
    min        = min(inputDates()),
    max        = max(inputDates()),
    format     = "yyyy-mm-dd",
    startview  = "month",
    weekstart  = 0,
    language   = "en")
  })

  inputProducts <- reactive({
    current$data <<- dbFetch(db, paste0("sales", format(input$date, "%Y%m%d")))
    sort(unique(current$data$product))
  })

  output$prodInput <- renderUI({ selectInput(
    inputId    = "product",
    label      = "Choose Product",
    choices    = inputProducts(),
    selected   = 1)
  })

  output$salesplot <- renderPlot({
    pdata <- aggregate(I(order.size*price) ~ hour,
                       data = subset(current$data, product == input$product),
                       FUN  = sum)
    colnames(pdata)[2] <- "value"
    plot(value ~ hour, data = pdata, xlim = c(8, 20))
  })


})
