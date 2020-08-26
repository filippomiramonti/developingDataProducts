#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

covidIta <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv")
covidIta <- covidIta[, c(1, 9, 11, 14)]
covidIta$data <- as.Date(covidIta$data)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$barPlot <- renderPlot({
        date <- input$date
        covidItaSub <- subset(covidIta, data <= date)
        if(input$choice == "newCases")  covidItaSub$y <- covidItaSub$nuovi_positivi
        else if(input$choice == "totCases") covidItaSub$y <- covidItaSub$totale_casi
        else if(input$choice == "totDeaths") covidItaSub$y <- covidItaSub$deceduti
        
        p <- ggplot(data = covidItaSub, 
                     aes(x = data, y = y)) + geom_bar(stat = "identity", fill = "orange")
        p <- p + xlab("Date") + xlim(covidItaSub$data[1] - 1, Sys.Date())
        if(input$choice == "newCases")  p <- p + ylab("New Cases") + ylim(0, max(covidIta$nuovi_positivi))
        else if(input$choice == "totCases") p <- p + ylab("Total Cases") + ylim(0, max(covidIta$totale_casi))
        else if(input$choice == "totDeaths") p <- p + ylab("Total Deaths") + ylim(0, max(covidIta$deceduti))
        p
    })
    
    output$text <- renderText({
        date <- input$date
        covidItaSub <- subset(covidIta, data <= date)
        paste("On", input$date, "the new cases of Covid-19 in Italy were", 
              covidItaSub$nuovi_positivi[covidItaSub$data == input$date], "bringing the total to", 
              covidItaSub$totale_casi[covidItaSub$data == input$date], "and", 
              covidItaSub$deceduti[covidItaSub$data == input$date], "deaths")
        
        })
})
