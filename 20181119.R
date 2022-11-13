#twitter
install.packages("rtweet")
library(rtweet)

install.packages("devtools")
library(devtools)

install.packages("install_github")
#library(install_github)

install_github("mkearney/rtweet")
library(rtweet)
library(rlang)

app.name <- "jbDataCollector"
consumer.key <- "XEue1ND9XIR0ZkXAne9PjjKJz"
consumer.secret <- "glF6tlYlu7epCJ5CSWTN5Ada4NpOSRmJb0ycQAPFCnc6xX8TcL"
my.token <- create_token(app=app.name,
             consumer_key = consumer.key,
             consumer_secret = consumer.secret)
save(my.token, file="myTwOAuth.Rdata")
load("myTwOAuth.Rdata")
tweets <- search_tweets(q="artificial intelligence",n=300)
tweets
View(tweets)
names(tweets)
tweets[1:3, c("screen_name","text")]

length(unique(tweets$text))

tweets.cont <- search_tweets(q="artificial intelligence",n=36000, include_rts = FALSE, retryonratelimit = TRUE)
nrow(tweets.cont)

ts_data(data=tweets.cont, by="2 hours")

ts_data(data=tweets.cont, by="2 hours", trim=1)

library(ggplot2)
Sys.setlocale("LC_TIME","English")
ts_plot(data=tweets.cont, by="hours", trim=1)+
  geom_ribbon(aes(ymin=n-100, ymax=n+100),fill="gray90")+
  geom_line(size=1.5, color="darn")


query <- enc2utf8("인공지능")
tweets.kor <- search_tweets(query, n=300, include_rts=FALSE)
tweets.kor[1:3, c("screen_name","text")]

tweets.kor <- search_tweets(geocode="37.663998,127.978458,540km",n=1000)
tweets.kor

tweets.kor <- lat_lng(tweets.kor)
View(tweets.kor)

library(maps)
library(dplyr)
windows(4.5,5.5)
map(database = "world", regions = c("south korea","north korea"),
    fill=TRUE, col="beige",mar = c(0,0,1,0))

trennds <- trends_available()
