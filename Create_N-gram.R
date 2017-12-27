#Reading all the three (twitter, blogs and news)files

Data_blog <- readLines("en_US.blogs.txt",skipNul = TRUE, warn = TRUE)
#Data_news <- readLines("~/Data Science Capstone/Predict_Next_Word/en_US.news.txt",skipNul = TRUE, warn = TRUE)
Data_twitter <- readLines("en_US.twitter.txt",skipNul = TRUE, warn = TRUE)

library(ggplot2)
library(NLP)
library(tm)
library(RWeka)
library(data.table)
library(dplyr)

#Taking sample from the files
set.seed(1234)
sample_size =800

sample_blog <- Data_blog[sample(1:length(Data_blog),sample_size)]
#sample_news <- Data_news[sample(1:length(Data_news),sample_size)]
sample_twitter <- Data_twitter[sample(1:length(Data_twitter),sample_size)]

sample_data<-rbind(sample_blog,sample_twitter)
rm(Data_blog,Data_twitter)

#Removing unwanted parts from sample data

Corpus_form <- VCorpus(VectorSource(sample_data))
# Converting to lowercase
Corpus_form <- tm_map(Corpus_form, content_transformer(tolower)) 
# Removing all the punctuation
Corpus_form <- tm_map(Corpus_form, removePunctuation) 
# Removing all the numbers
Corpus_form <- tm_map(Corpus_form, removeNumbers) 
# Removing all the  multiple whitespace
Corpus_form <- tm_map(Corpus_form, stripWhitespace) 
# Adjusting the space
Space_form <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
Corpus_form <- tm_map(Corpus_form, Space_form, "/|@|\\|")

#WordCloud
#library(wordcloud)
#wordcloud(Corpus_form, max.words = 100, random.order = FALSE,rot.per=0.45, 
          #use.r.layout=FALSE,colors=brewer.pal(8, "Dark2"))

# Formation of tokenizer

Unigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
Bigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
Trigram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
Fourgram_tokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))

One_token <- NGramTokenizer(Corpus_form, Weka_control(min = 1, max = 1))
One_gram <- TermDocumentMatrix(Corpus_form, control = list(tokenize = Unigram_tokenizer))
Two_gram <- TermDocumentMatrix(Corpus_form, control = list(tokenize = Bigram_tokenizer))
Three_gram <- TermDocumentMatrix(Corpus_form, control = list(tokenize = Trigram_tokenizer))
Four_gram <- TermDocumentMatrix(Corpus_form, control = list(tokenize = Fourgram_tokenizer))

# Creating Frequency for (uni,bi,tri and fourgram)

Frequency_1 <- findFreqTerms(One_gram, lowfreq = 5)
Frequency_gm1 <- rowSums(as.matrix(One_gram[Frequency_1,]))
Frequency_gm1 <- data.frame(unigram=names(Frequency_gm1), frequency=Frequency_gm1)
Frequency_gm1 <- Frequency_gm1[order(-Frequency_gm1$frequency),]
Unigram_Frequency <- setDT(Frequency_gm1)
save(Unigram_Frequency,file="unigram.Rda")

Frequency_2 <- findFreqTerms(Two_gram, lowfreq = 3)
Frequency_gm2 <- rowSums(as.matrix(Two_gram[Frequency_2,]))
Frequency_gm2 <- data.frame(bigram=names(Frequency_gm2), frequency=Frequency_gm2)
Frequency_gm2 <- Frequency_gm2[order(-Frequency_gm2$frequency),]
Bigram_Frequency <- setDT(Frequency_gm2)
save(Bigram_Frequency,file="bigram.Rda")

Frequency_3 <- findFreqTerms(Three_gram, lowfreq = 2)
Frequency_gm3 <- rowSums(as.matrix(Three_gram[Frequency_3,]))
Frequency_gm3 <- data.frame(trigram=names(Frequency_gm3), frequency=Frequency_gm3)
Trigram_Frequency <- setDT(Frequency_gm3)
save(Trigram_Frequency,file="trigram.Rda")

Frequency_4 <- findFreqTerms(Four_gram, lowfreq = 1)
Frequency_gm4 <- rowSums(as.matrix(Four_gram[Frequency_4,]))
Frequency_gm4 <- data.frame(fourgram=names(Frequency_gm4), frequency=Frequency_gm4)
Fourgram_Frequency <- setDT(Frequency_gm4)
save(Fourgram_Frequency,file="fourgram.Rda")
