#아이포
https://www.ebay.com/b/Apple-iPhone/9355/bn_319682?_pgn=
  # 리뷰 수 코드 
basic_url <- 'https://www.ebay.com/b/Apple-iPhone/9355/bn_319682?_pgn='
urls <- NULL
for(i in 1:4){
  urls[i] <- paste0(basic_url, as.character(i))
}
for(i in 5:10){
  urls[i] <- paste0(basic_url, as.character(i), '&rt=nc')
}
links <- NULL
for(url in urls){
  library(XML)
  library(xml2)
  html <- read_html(url)
  html.parsed<-htmlParse(html)
  x <- xpathSApply(html.parsed, '//div[@class="b-starrating"]/following-sibling::span', xmlValue)
  print(as.numeric(gsub('p.*', "", x)))
}

#리뷰 데이터 추출
#iphone 6s
ebayreview<- function(baseurl, n=NULL){
  library(httr)
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- read_html(url)
    html.parsed<-htmlParse(html)
    total.pages<- xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue)
    total.pages<- substr((total.pages),1,3)
    total.pages<- as.numeric(total.pages)
    total.pages<-ceiling(total.pages/10)
    n<- total.pages
  }
  ebay.review<-data.frame()
  Sys.setlocale("LC_TIME", "C")
  for (i in c(1:n)){
    url<- paste0(str_sub(baseurl, end=-2), i)
    html<-read_html(url)
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']/a", xmlValue)
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val
                         }
    )
    date<-xpathSApply(html.parsed, "//span[@itemprop='datePublished']", xmlValue)
    date<-as.Date(date, format ="%B %d, %Y")
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label')
    rating<-rating[-1]
    rating<-substr(rating, 1, 1)
    rating<-as.numeric(rating)
    
    ebay.r<-data.frame(product=product, date=date, review=review, rating=rating, stringsAsFactors = F)
    ebay.review<-rbind(ebay.review, ebay.r)
    
    Sys.sleep(sample(10,1)*0.1)
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review)
  return(ebay.review)
  return(n)
}

baseurl <-"https://www.ebay.com/urw/Apple-iPhone-6s-64GB-Space-Gray-Unlocked-A1633-CDMA-GSM-/product-reviews/229250346?pgn=1" 
ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
#두번째 리뷰 

ebayreview<- function(baseurl, n=NULL){
  library(httr)
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- read_html(url)
    html.parsed<-htmlParse(html)
    total.pages<- xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue)
    total.pages<- substr((total.pages),1,3)
    total.pages<- as.numeric(total.pages)
    total.pages<-ceiling(total.pages/10)
    n<- total.pages
  }
  ebay.review<-data.frame()
  Sys.setlocale("LC_TIME", "C")
  for (i in c(1:n)){
    url<- paste0(str_sub(baseurl, end=-2), i)
    html<-read_html(url)
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']/a", xmlValue)
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val
                         }
    )
    date<-xpathSApply(html.parsed, "//span[@itemprop='datePublished']", xmlValue)
    date<-as.Date(date, format ="%B %d, %Y")
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label')
    rating<-rating[-1]
    rating<-substr(rating, 1, 1)
    rating<-as.numeric(rating)
    
    ebay.r<-data.frame(product=product, date=date, review=review, rating=rating, stringsAsFactors = F)
    ebay.review<-rbind(ebay.review, ebay.r)
    
    Sys.sleep(sample(10,1)*0.1)
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review)
  return(ebay.review)

}
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-16GB-Rose-Gold-Unlocked-A1688-CDMA-GSM-/product-reviews/216278648?pgn=1"


ebay.review2<- ebayreview(baseurl = baseurl)
ebay.review2$review<-str_trim(ebay.review2$review)
names(ebay.review2)
View(ebay.review2)
iphone.review <- rbind(ebay.review,ebay.review2)
View(iphone.review)

#워드 클라우드 코드 

review <- paste(iphone.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,0.5),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

###############iphone5s

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-5s-16GB-Space-Grey-Unlocked-A1457-GSM-/product-reviews/168512729?pgn=1"

ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)

#워드 클라우드  
review <- paste(ebay.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(6,0.7),min.freq = 5, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

###iphone 4s
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-4s-16GB-Black-Unlocked-A1387-CDMA-GSM-/product-reviews/109303245?pgn=1"

iphone4s.review<- ebayreview(baseurl = baseurl)
iphone4s.review$review<-str_trim(iphone4s.review$review)
View(iphone4s.review)

grep('blah',iphone4s.review$reivew)
grep('Blah',iphone4s.review$reivew)
iphone4s.review <- iphone4s.review[-416,]

#워드 클라우드  
review <- paste(ebay.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","black","blah","just","the","blah"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,0.8),min.freq = 5, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

#iphone 6 리뷰
baseurl <-"https://www.ebay.com/urw/Apple-iPhone-6-64GB-Space-Grey-Unlocked-A1586-CDMA-GSM-/product-reviews/203711866?pgn=1"

ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6-16GB-Silver-Unlocked-A1586-CDMA-GSM-/product-reviews/203708502?pgn=1"
ebay.review2<- ebayreview(baseurl = baseurl)
ebay.review2$review<-str_trim(ebay.review2$review)
iphone6.review <- rbind(ebay.review, ebay.review2 )
View(iphone6.review)
review <- paste(iphone6.review$review, collapse = " ")

doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","black","blah","just","the","blah"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,0.8),min.freq = 5, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

##iphone7
baseurl <-"https://www.ebay.com/urw/Apple-iPhone-7-32GB-Black-Unlocked-A1660-CDMA-GSM-/product-reviews/232669172?pgn=1"

ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-7-32GB-Black-Unlocked-A1778-GSM-/product-reviews/225300883?pgn=1"
ebay.review2<- ebayreview(baseurl = baseurl)
ebay.review2$review<-str_trim(ebay.review2$review)
iphone7.review222 <- rbind(ebay.review, ebay.review2 )
View(iphone6.review)
review <- paste(iphone6.review$review, collapse = " ")

doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","black","blah","just","the","blah"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,0.8),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


##감성단어
install.packages("tidytext")
library(tidytext)
install.packages("backports")
bing <- get_sentiments("bing")
bing


#감성단
install.packages("tidyverse")
library(tidyverse)
ebay.review.words <-
  unnest_tokens(tbl=ebay.review, output=word, input=review, token="words")%>%
  anti_join(stop_words, by="word")%>%
  as_tibble(.)

ebay.review.words

ebay.sent.review <- ebay.review.words %>%
  inner_join(bing, by="word") %>%
  count(id, word, sentiment)%>%
  spread(sentiment, n, fill=0) %>%
  mutate(sentiments=positive - negative) %>%
  ungroup()

ebay.sent.review

summary(ebay.sent.review$sentiments)

ebay.sent.review <- ebay.review.words %>%
  inner_join(bing, by="word")%>%
  count(sentiment, word)%>%
  ungroup() %>%
  filter(n >2)%>%
  mutate(nsign=ifelse(sentiment=="negative",-n,n))

#windows(width = 10.0, height = 10)
ggplot(ebay.sent.review,
       aes(x=reorder(word,nsign), y=nsign,
           fill=factor(sentiment,levels = c("positive","negative"))))+
  geom_bar(stat = "identity", color="lightslategray", width=8)+
  geom_text(aes(label=n),size=3, color="black",
            hjust=ifelse(ebay.sent.review$nsign <0, 1.1, -0.1))+
  scale_fill_manual(values=c("cornflowerblue","tomato"))+
  coord_flip()+
  labs(x="Word",y="Count",
       title="Review of Watch",
       subtitle="Top words contributing to sentiment",
       caption="Source : Ebay")+
  theme_minimal()+
  theme(text=element_text(family = "sans"),
        plot.title = element_text(face="bold"),
        axis.text = element_text(size=10),
        legend.position = "bottom",
        legend.title = element_blank())

##iphonex
baseurl <-"https://www.ebay.com/urw/Apple-iPhone-X-64GB-Space-Grey-Unlocked-A1901-GSM-/product-reviews/239057380?pgn=1"
ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-X-256GB-Space-Gray-Unlocked-A1865-CDMA-GSM-/product-reviews/240420150?pgn=1"
ebay.review2<- ebayreview(baseurl = baseurl)
ebay.review2$review<-str_trim(ebay.review2$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-X-256GB-Silver-Unlocked-A1865-CDMA-GSM-/product-reviews/240377022?pgn=1"
ebay.review3<- ebayreview(baseurl = baseurl)
ebay.review3$review<-str_trim(ebay.review3$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-X-64GB-Space-Grey-Unlocked-A1901-GSM-/product-reviews/239057380?pgn=1"
ebay.review4<- ebayreview(baseurl = baseurl)
ebay.review4$review<-str_trim(ebay.review4$review)

iphonex.review <- rbind(ebay.review, ebay.review2, ebay.review3, iphonex.review )
View(iphonex.review)


iphonex.review$review<-gsub("[^[:alnum:]///' ]", "",iphonex.review$review)

review <- paste(iphonex.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","iphon"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(50, 50)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,1),min.freq =3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))




review <- paste(iphonex.review$review, collapse = " ")

doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","black","blah","just","the","blah"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)

dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,0.8),min.freq = 4, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

##iphone8
baseurl <-"https://www.ebay.com/urw/Apple-iPhone-8-64GB-Space-Grey-Unlocked-A1905-GSM-/product-reviews/238941601?pgn=1"
ebay.review<- ebayreview(baseurl = baseurl)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Space-Gray-AT-T-A1905-GSM-/product-reviews/239054120?pgn=1"
ebay.review2<- ebayreview(baseurl = baseurl)
ebay.review2$review<-str_trim(ebay.review2$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Silver-Unlocked-A1905-GSM-/product-reviews/239009722?pgn=1"
ebay.review3<- ebayreview(baseurl = baseurl)
ebay.review3$review<-str_trim(ebay.review3$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Space-Gray-Unlocked-A1905-GSM-/product-reviews/239093015?pgn=1"
ebay.review4<- ebayreview(baseurl = baseurl)
ebay.review4$review<-str_trim(ebay.review4$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Space-Gray-Unlocked-A1863-CDMA-GSM-/product-reviews/240377032?pgn=1"
ebay.review5<- ebayreview(baseurl = baseurl)
ebay.review5$review<-str_trim(ebay.review5$review)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Gold-Unlocked-A1905-GSM-/product-reviews/239054200?pgn=1"
ebay.review6<- ebayreview(baseurl = baseurl)
ebay.review6$review<-str_trim(ebay.review6$review)

iphone8.review <- rbind(ebay.review, ebay.review2, ebay.review3, ebay.review4, ebay.review5, ebay.review6)
View(iphone8.review)

iphone8.review$review<-gsub("[^[:alnum:]///' ]", "",iphone8.review$review)

review <- paste(iphone8.review$review, collapse = " ")
#install.packages("SnowballC")
library(SnowballC)
#install.packages("tm")
library(tm)

#trace(utils:::unpackPkgZip, edit=TRUE)
doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","iphon"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)
dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(50, 50)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,1),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))



doc <- Corpus(VectorSource(review))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four","get","one","said","the","there",
                   "two","three","with","this","and","<99>","black","blah","just","the","blah"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)

dtm <- DocumentTermMatrix(doc)
dtm
inspect(dtm[,1:10])
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]


library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,0.8),min.freq = 4, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))
