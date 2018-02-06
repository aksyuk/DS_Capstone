
# Data Science Capstone: 
# Application for Word Prediction

# server

library(shiny)

source('add.R', local = TRUE)

shinyServer(function(input, output, session) {
    
    observeEvent(input$bttn.predict, {
        
        predictions <- findNextWord(input$txt.input)
        
        output$gen.prediction <- 
            renderUI(HTML(paste('Prediction in general:', '<b>', 
                                predictions['gen'], '</b>')))
        output$news.prediction <- 
            renderUI(HTML(paste('Prediction by news corpus:', '<b>', 
                                predictions['news'], '</b>')))
        output$blog.prediction <- 
            renderUI(HTML(paste('Prediction by blogs corpus:', '<b>', 
                                predictions['blog'], '</b>')))
        output$twit.prediction <- 
            renderUI(HTML(paste('Prediction by twits corpus:', '<b>', 
                                predictions['twit'], '</b>')))
    })
})