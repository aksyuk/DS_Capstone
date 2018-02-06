
# Data Science Capstone: 
# Application for Word Prediction

# add

txt.in <- '"I am a, new comer","to r,"please help","me:out","here"'

library('stringr')

load('./data/predictions.RData')

findNextWord <- function(txt.in) {
    
    if (txt.in == '') {
        rslt <- rep('ERROR: string is empty', 4)
        names(rslt) <- c('gen', 'blog', 'news', 'twit')
    } else {
        
        # clean input text
        txt.in <- trimws(tolower(gsub('[[:punct:] ]+', ' ', txt.in)))
        if (nrow(str_locate_all(txt.in, pattern = ' ')[[1]]) == 0) {
            txt.in <- paste0(' ', txt.in)
        }
        sp <- str_locate_all(txt.in, pattern = ' ')[[1]]
        n <- nrow(sp)
        
        df.n.grams <- data.frame(n = 1:6, word = '', 
                                 next.gen = '', p.gen = 0,
                                 next.news = '', p.news = 0, 
                                 next.blog = '', p.blog = 0, 
                                 next.twit = '', p.twit = 0,
                                 stringsAsFactors = F)
        for (i in 1:6) {
            # get N-gram
            word <- ifelse(n >= i, substr(txt.in, 
                                          start = sp[nrow(sp) - i + 1, 1] + 1, 
                                          stop = nchar(txt.in)), '')
            df.n.grams[i, 'word'] <- word
            df.n.grams[i, 'n'] <- paste0('n', i)
            
            # find prediction
            if (word != '') {
                pr.line <- 
                    predictions[[paste0('by.', i, 'N')]][predictions[[paste0('by.', i, 'N')]]$word == word, , drop = F]
                if (nrow(pr.line) == 0) {
                    df.n.grams[i, seq(3, 9, by = 2)] <- ''
                    df.n.grams[i, seq(4, 10, by = 2)] <- 0
                } else {
                    df.n.grams[i, 3:10] <- pr.line[, -1]
                }
            }
        }
        
        rslt <- c(df.n.grams[df.n.grams$p.gen == max(df.n.grams$p.gen),
                             'next.gen'],
                  df.n.grams[df.n.grams$p.news == max(df.n.grams$p.news),
                             'next.news'],
                  df.n.grams[df.n.grams$p.blog == max(df.n.grams$p.blog),
                             'next.blog'],
                  df.n.grams[df.n.grams$p.twit == max(df.n.grams$p.twit),
                             'next.twit'])
        names(rslt) <- c('gen', 'blog', 'news', 'twit')
        
        for (i in 1:length(rslt)) {
            # if word is not found
            if (rslt[i] == '') {
                rslt[rslt == ''] <- 
                    predictions[['not.found']][, paste0('next.', names(rslt)[i])]
            }
        }
    }
    
    return(rslt)
}


