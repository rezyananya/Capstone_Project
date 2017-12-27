#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(NLP)
library(tm)
library(RWeka)
#library(rsconnect)
#library(data.table)
#library(dplyr)
#library(wordcloud)
source("NLP_Programe.R")


shinyServer(function(input, output) {
  output$inputValue <- renderPrint({input$Tcir})
  output$prediction <- renderPrint({Wordform(input$Tcir)})
  
  
  #output$Plot <- renderPlot({
  #wordcloud(Corpus_form, max.words = 100, random.order = FALSE,rot.per=0.45, 
  #  use.r.layout=FALSE,colors=brewer.pal(8, "Dark2"))}
  #)
  
})