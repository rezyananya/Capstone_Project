#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(titlePanel("Next Word Prediction Application: Data Science Capstone Project"),
                  
                  hr(),
                  tags$head(tags$style(
                    HTML('
                         #mainpanel {
                         #background-color: #A6DAF7;
                         }'))),
 #mainPanel(
 #plotOutput("Plot", width = "50%",height = "200px")
 # ),
 
 fluidPage(
   
   mainPanel(
     h3("Introduction:"),
     h5("Type your word/phrase and predict the next word"),
     h3("Algorithm:"),
     h5("Used N-Gram algorithm"),
     
     textInput("Tcir",label=h3("Type your word/phrase here:")),
     submitButton('Predict'),
     h4('word/phrase you entered : '),
     verbatimTextOutput("inputValue"),
     h4('next word :'),
     verbatimTextOutput("prediction")
     
     
   )
 )))