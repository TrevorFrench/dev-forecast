#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# add loading modal and modular function
library(shiny)

monte_carlo <- function(n, tasks, data) {
  i <- 1
  output <- c()
  while (i <= n) {
    total <- 0
    y <- 1
    while (y <= tasks) {
      picked <- sample(data, 1)
      total <- total + picked
      y <- y + 1
    }
    output <- append(output, total)
    i <- i + 1
  }
  return(output)
}

# Define server logic required to draw a histogram
function(input, output, session) {
    # HANDLE UPLOAD FILE
    data <- reactive({
      req(input$upload_file)
      
      ext <- tools::file_ext(input$upload_file$name)
      switch(ext,
             csv = vroom::vroom(input$upload_file$datapath, delim = ","),
             tsv = vroom::vroom(input$upload_file$datapath, delim = "\t"),
             validate("Invalid file; Please upload a .csv or .tsv file")
      )
    })
    output$head <- renderTable({head(data(), 5)}, digits = 9)
    output$distPlot <- renderPlot({
        data <- data()
        print(data)
        # generate bins based on input$bins from ui.R
        x <<- monte_carlo(input$n, input$tasks, data$time)
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        x <- as.vector(x)
        print(x)
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })

}
