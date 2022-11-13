ebayreview<- function(baseurl, n=NULL){
 ## Encoding("utf-8")
  library(httr)
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url= baseurl
    html <- read_html(Encoding("UTF-8"))
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
    html<-read_html(url, encoding = "UTF-8")
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']", xmlValue)
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div[normalize-space()]",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val
                         }
                        
    )
 ##   review <- gsub("\\.*?","",review)
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label')
    rating<-rating[-1]
    rating<-substr(rating, 1, 1)
    rating<-as.numeric(rating)
    
    ebay.r<-data.frame(review=review, stringsAsFactors = F)
    ebay.review<-rbind(ebay.review, ebay.r)
    
    Sys.sleep(sample(10,1)*0.1)
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review)
  return(ebay.review)
}

baseurl <- "https://www.ebay.com/urw/Invicta-Pro-Diver-8932OB-Wrist-Watch-for-Men/product-reviews/222453104?pgn=1"
ebay.review<- ebayreview(baseurl = baseurl, n=38)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)

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
  geom_bar(stat = "identity", color="lightslategray", width=0.8)+
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








review <- paste(ebay.review$review, collapse = " ")
review
ebay.review$review <- gsub("\\.*","",ebay.review$review)

review
review <- gsub("\\\\.*","",review)
review

ebay.review$review[[1]]


reviews <- unlist(ebay.review$review)
review <- gsub("\\s{2, } | \n","", review)
reviews
library(dplyr)
a <- ebay.review %>%  mutate_all(as.character)
str(a)
a$review
head(a)
str(ebay.review)
ebay.review$review

a<- lapply(ebay.review$review, as.character)
ebay.review$review <- data.frame(lapply(ebay.review$review, as.character), stringsAsFactors=FALSE)

head(reviews)
View(ebay.review)
ebay.review<- ebayreview(baseurl = baseurl, n<-ceiling(as.numeric(substr(xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue), 1, 3))/10))

review <- ebay.review$review
review <- gsub()

review

review <- paste(ebay.review$review, collapse = " ")
review <- gsub("\\s{2, } | \n","", review)

install.packages("SnowballC")
library(SnowballC)
install.packages("tm")
library(tm)

trace(utils:::unpackPkgZip, edit=TRUE)
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(6,0.2),min.freq = 4, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


#워드클라우드


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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(4,0.2),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

#6s두번쨰
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-16GB-Rose-Gold-Unlocked-A1688-CDMA-GSM-/product-reviews/216278648?pgn=1"