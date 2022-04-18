#Prince's song sentiment filtered.

#load the necessary libraries to run the analysis
library(tidytext)
library(dplyr)
library(stringr)
library(wordcloud2)
library(sentimentr)
library(ggplot2)

# Read the dataset that contains the lyrics to Prince's songs
prince.df <- read.csv("prince_data.csv")

ncr_sent <- get_sentiments("nrc")

#create a token of words - separate the sentences into individual words
princeTable <- prince.df %>% 
  unnest_tokens(word, text)

nrc_joy <- get_sentiments("nrc") %>% filter(sentiment == "joy")
nrc_fear <- get_sentiments("nrc") %>% filter(sentiment == "fear")


prince_year <- princeTable %>% filter(year == "1999")
prince_album <- princeTable %>% filter(album == "Purple Rain")
prince_joy <- prince_year %>% inner_join(nrc_joy) %>% count(word, sort = TRUE)
prince_fear <- prince_year %>% inner_join(nrc_fear) %>% count(word, sort = TRUE)
prince_all <- prince_year %>% inner_join(get_sentiments("nrc")) %>% count(word, sort = TRUE)

wordcloud2(prince_joy)

wordcloud2(prince_fear)
