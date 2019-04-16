
install.packages("SnowballC")
install.packages("tm")
install.packages("twitteR")
install.packages("syuzhet")

library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")

consumer_key <- 'ABCDEFGHI1234567890'
consumer_secret <- 'ABCDEFGHI1234567890'
access_token <- 'ABCDEFGHI1234567890'
access_secret <- 'ABCDEFGHI1234567890'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("realDonaldTrump", n=200)
n.tweet <- length(tweets)
tweets.df <- twListToDF(tweets) 
head(tweets.df)

tweets.df=read.csv("D:\\two\\Sentiment.csv")
head(tweets.df$text)
dim(tweets.df)

head(tweets.df$text)
tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)

#tweets.df2 <- gsub("#.*","",tweets.df$text)
tweets.df2 <- gsub("@.*","",tweets.df2)

tweets.df2 <- gsub("////","",tweets.df2)
head(tweets.df2)

word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df) 
head(emotion.df2,100)

sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive
most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 
most.positive
most.negative

sent.value

positive.tweets <- word.df[sent.value > 0]
head(positive.tweets)

#Negative Tweets
negative.tweets <- word.df[sent.value < 0] 
head(negative.tweets)

#Neutral tweets
neutral.tweets <- word.df[sent.value == 0]
head(neutral.tweets)

category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)

head(category_senti)

table(category_senti)





