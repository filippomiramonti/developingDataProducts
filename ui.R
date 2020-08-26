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
shinyUI(fluidPage(
    tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: orange}")),
    # Application title
    titlePanel("Trend of the spread of Covid-19"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            h4("Select Data"),
            radioButtons(inputId="choice", "What do you want to see?",
                               choices=c("New Cases" = "newCases", "Total Cases" = "totCases", "Total Deaths" = "totDeaths"), selected = "newCases"),
            h4("Select a Date"),
            sliderInput("date",
                        "",
                        min = as.Date("2020-02-24","%Y-%m-%d"),
                        max = Sys.Date() - 1,
                        value = as.Date("2020-02-24","%Y-%m-%d"),
                        timeFormat = "%Y-%m-%d",
                        animate = animationOptions(interval = 300, loop = TRUE),
                        )
        ),

        mainPanel(
            plotOutput("barPlot"),
            h4(textOutput("text"))
        )
    )
))
