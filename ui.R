#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("n", "Sample Size:", 1000, min = 1, max = 1000000),
            numericInput("tasks", "Tasks:", 70, min = 1, max = 1000000),
            fileInput("upload_file", NULL, accept = c(".csv", ".tsv")),
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("head"),
            plotOutput("distPlot")
        )
    )
)
