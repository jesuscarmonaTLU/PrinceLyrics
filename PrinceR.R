# Prince's Lyrics Analysis
#load the necessary libraries to run the analysis
library(tidytext)
library(dplyr)
library(stringr)
library(wordcloud2)
library(ggplot2)
library(sentimentr)

# Read the dataset that contains the lyrics to Prince's songs
prince.df <- read.csv("prince_data.csv")

#**************************** Using bag of word ********************************

#create a token of words - separate the sentences into individual words
princeTable <- prince.df %>% 
  unnest_tokens(word, text)

#load dictionary with stop words like 'a', 'the', 'about', etc.
data(stop_words)

#get rid of the stop words 
princeTable <- princeTable %>%
  anti_join(stop_words)

#do a word count
princeTable <- princeTable %>%
  count(word, sort = TRUE) 

#display the elements on princeTable
princeTable

#get rid of insignificant words
princeTable <-princeTable %>%
  filter(!word %in% c('2', 'ooh', '4', "la", 'chorus', 'da', 'uh', 'ha',  'x2'))

#Display a Word Cloud
wordcloud2(princeTable, size=0.7)

library(wordcloud)
princeTable %>% with(wordcloud(word, n, max.words=100))

#get the top 15 words of the princeTable
princeTableTop <- top_n(princeTable, 15)

#Plot the 15 most used words in Prince's lyrics
ggplot(princeTableTop, aes(x=reorder(word, -n), y=n)) +
  geom_bar(stat="identity")

#************************* Using semantic parsing ******************************

#Extract sentiment from the lyrics
prince_sentiment <- sentiment(prince.df$text)

#Display summary statistics on sentiment
summary(prince_sentiment$sentiment)

#Plot a density chart of the sentiment on the lyrics.
prince_sentiment %>% ggplot()+geom_density(aes(sentiment))+ ggtitle("Prince Lyric Sentiment")


