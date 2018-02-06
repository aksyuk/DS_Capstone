
# Data Science Capstone: 
#  Application for Word Prediction 

# UI ...........................................................................

fluidPage(
    
    titlePanel('Predict Next Word'),
    
    sidebarLayout(
        sidebarPanel(
            # input phrase for prediction
            textInput('txt.input', 'Type a phrase to finish:'),
            
            # button to make a prediction
            actionButton('bttn.predict', 'Show me next word!')
        ),
        
        # some visualisations
        mainPanel(
            htmlOutput('gen.prediction'),
            htmlOutput('news.prediction'),
            htmlOutput('blog.prediction'),
            htmlOutput('twit.prediction')
            # plotOutput('plot')
        )
    )
)