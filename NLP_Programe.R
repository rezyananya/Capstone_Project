#Loading Unigram, bigram, trigram and fourgram files

load("C:/Users/Priyanka/Documents/Capstone_Predict_Word/myapp/unigram.Rda")
load("C:/Users/Priyanka/Documents/Capstone_Predict_Word/myapp/bigram.Rda")
load("C:/Users/Priyanka/Documents/Capstone_Predict_Word/myapp/trigram.Rda")
load("C:/Users/Priyanka/Documents/Capstone_Predict_Word/myapp/fourgram.Rda")

Wordform <- function(sentence){
  value = "your word would be..."
  sen = unlist(strsplit(sentence,' '))
  if(length(sen)>=3){
    value = fourgram(sen[(length(sen)-2):length(sen)])
  }
  
  if(is.null(value)||length(sen)==2){
    value = trigram(sen[(length(sen)-1):length(sen)])
    
  }
  if(is.null(value)||length(sen)==1){
    value = bigram(sen[length(sen)])
    
  }
  if(is.null(value)){
    value = "the"
    
  }
  
  return(value)
}

#Creating four_gram

fourgram <- function(four_gm){
  four <- paste(four_gm,collapse = ' ')
  foursum <- data.frame(fourgram="test",frequency=0)
  k <- Trigram_Frequency[trigram==four]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in unigramlist$unigram){
    text = paste(four,string0)
    found <- Fourgram_Frequency[fourgram==text]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      foursum <- rbind(foursum,found)
      
    }
  }
  if(nrow(foursum)==1) return(NULL)
  foursum <- foursum[order(-frequency)]
  sen <- unlist(strsplit(as.String(foursum[1,fourgram]),' '))
  return (sen[length(sen)])
}

#Creating three_gram

trigram <- function(three_gm){
  three <- paste(three_gm,collapse = ' ')
  threesum <- data.frame(trigram="test",frequency=0)
  k <- Bigram_Frequency[bigram==three]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in Unigram_Frequency$unigram){
    text = paste(three,string0)
    found <- Trigram_Frequency[trigram==text]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      threesum <- rbind(threesum,found)
      
    }
  }
  if(nrow(threesum)==1) return(NULL)
  threesum <- threesum[order(-frequency)]
  sen <- unlist(strsplit(as.String(threesum[1,trigram]),' '))
  return (sen[length(sen)])
}

#Creating bi_gram

bigram <- function(two_gm){
  two <- paste(two_gm,collapse = ' ')
  twosum <- data.frame(bigram="test",frequency=0)
  k <- Unigram_Frequency[unigram==two]
  m <- as.numeric(k$frequency)
  if(length(m)==0) return(NULL)
  
  for(string0 in Unigram_Frequency$unigram){
    text = paste(two,string0)
    found <- Bigram_Frequency[bigram==text]
    n<- as.numeric(found$frequency)
    
    if(length(n)!=0){
      twosum <- rbind(twosum,found)
      
    }
  }
  
  if(nrow(twosum)==1) return(NULL)
  twosum <- twosum[order(-frequency)]
  
  sen <- unlist(strsplit(as.String(twosum[1,bigram]),' '))
  return (sen[length(sen)])
}