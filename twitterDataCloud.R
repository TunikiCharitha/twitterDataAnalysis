install.packages('Scale', dependencies=TRUE, repos='http://cran.rstudio.com/')

install.packages('tm', dependencies=TRUE, repos='http://cran.rstudio.com/')


options(repos='http://cran.rstudio.com/')

install.packages("SnowballC")

install.packages("wordcloud")

install.packages("RColorBrewer")

install.packages("stringr")

install.packages("twitteR")


library(Scale)
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(stringr)
library(twitteR)


url <- "http://www.rdatamining.com/data/rdmTweets-201306.RData"
download.file(url, destfile = "d://two//rdmTweets-201306.RData")

load("C://Users//lenovo//Downloads//rdmTweets-201306.RData")

## load tweets into R
load(file = "d://two//rdmTweets-201306.RData")

text <- readLines("d://two//rdmTweets-201306.RData")
docs <- Corpus(VectorSource(text))


trans <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, trans, "/")
docs <- tm_map(docs, trans, "@")
docs <- tm_map(docs, trans, "\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("sudharsan","friendName"))
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, stemDocument)

#create the document term matrix
dtm <- TermDocumentMatrix(docs)
mat <- as.matrix(dtm)
v <- sort(rowSums(mat),decreasing=TRUE)

#Data frame
data <- data.frame(word = names(v),freq=v)
head(data, 10)

set.seed(1056)
wordcloud(words = data$word, freq = data$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))


