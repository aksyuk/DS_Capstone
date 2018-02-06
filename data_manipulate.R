
# https://github.com/TomLous/coursera-data-science-capstone/blob/master/5.dataproduct/data/ngramLookupTables.en_US.RData
load('../ngramLookupTables.en_US.RData')

str(ngramLookupTables)

str(ngramLookupTables[[1]])
ngramLookupTables[[1]]
head(ngramLookupTables[[2]])
head(ngramLookupTables[[3]])
head(ngramLookupTables[[4]])
head(ngramLookupTables[[5]])
head(ngramLookupTables[[6]])
head(ngramLookupTables[[7]])

predictions <- list(by.1N = ngramLookupTables[[2]],
                    by.2N = ngramLookupTables[[3]],
                    by.3N = ngramLookupTables[[4]],
                    by.4N = ngramLookupTables[[5]],
                    by.5N = ngramLookupTables[[6]],
                    by.6N = ngramLookupTables[[7]],
                    not.found = ngramLookupTables[[1]])

for (i in 1:length(predictions)) {
    predictions[[i]] <- predictions[[i]][, c(-4, -5)]
    colnames(predictions[[i]]) <- c('word', 'next.gen', 'p.gen')
    predictions[[i]] <- cbind(predictions[[i]],
                              next.news = predictions[[i]]$next.gen,
                              p.news = predictions[[i]]$p.gen,
                              next.blog = predictions[[i]]$next.gen,
                              p.blog = predictions[[i]]$p.gen,
                              next.twit = predictions[[i]]$next.gen,
                              p.twit = predictions[[i]]$p.gen)
}

predictions$not.found <- cbind(predictions$not.found,
                               next.news = predictions$not.found$next.gen,
                               p.news = predictions$not.found$p.gen,
                               next.blog = predictions$not.found$next.gen,
                               p.blog = predictions$not.found$p.gen,
                               next.twit = predictions$not.found$next.gen,
                               p.twit = predictions$not.found$p.gen)

for (i in 1:length(predictions)) {
    for (j in c(1, seq(2, 8, by = 2))) {
        predictions[[i]][, j] <- as.character(predictions[[i]][, j])
    }
}

str(predictions[[1]])
head(predictions[[1]])

rm(ngramLookupTables, i, j)

save.image('./data/predictions.RData')
