Sys.getlocale()

ebayreview<- function(baseurl, n=NULL){#baseurl?? n�� ?μ??? ?ϴ? ?Լ??? ??????.
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- read_html(url) #url�� html ?????? ?о????δ?.
    html.parsed<-htmlParse(html) #html?????? ?Ľ??Ѵ?.
    total.pages<- xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue)
    total.pages<- substr((total.pages),1,3) #????Ʈ ??�� ?? 7?????? ???ķ? ???????? ?Ѿ?? ?ʾ? ?켱 ?? ???????? ?????Ѵ?.
    total.pages<- as.numeric(total.pages) #???ڷ? ?ٲ۴?.
    total.pages<-ceiling(total.pages/10) # ?? ???????? ???䰡 10???̹Ƿ? ?? ?????????? 10�� ???? ??�� ?ø??Ͽ? ?????? ???????? ã?´?.
    n<- total.pages 
  }
  ebay.review<-data.frame()
  Sys.setlocale("LC_TIME", "C") #?ð? ?????? ????�� ?Ϲ?ǥ??��?? ?Ͻ??? ??ȯ?Ѵ?.
  for (i in c(1:n)){
    url<- paste0(str_sub(baseurl, end=-2), i) #???? ???????? url�� ??��?ͼ? ?Ľ??Ѵ?.
    html<-read_html(url)
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']/a", xmlValue)
    
    pattern <- "(iPhone( )?(\\w{1,2}))"
    proudct <- str_extract_all(product, pattern)
    #��ǰ ?̸?�� ?????Ѵ?.
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val #???並 ?? ????�� ???? NULL?????? ??ĭ��?? ??ȯ?Ѵ?.
                         } #???並 ?????Ѵ?. 
    )
    date<-xpathSApply(html.parsed, "//span[@itemprop='datePublished']", xmlValue) #???? ?ۼ? ???ڸ? ?????Ѵ?.
    date<-as.Date(date, format ="%B %d, %Y") #??¥ ????�� ?????? ????��?? ?????Ѵ?.
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label') #???? ??���� ?????Ѵ?.
    rating<-rating[-1] #ù??° ??���� ??ü ?????? ??��?̹Ƿ? ��???Ѵ?.
    rating<-substr(rating, 1, 1)#??�� ?????? "5 stars" ?̹Ƿ? ?ʿ??? ù ??° ???ڸ? ??��?´?.
    rating<-as.numeric(rating)#????ȭ?Ѵ?. 
    helpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-up-link']",
                          function(x){
                            val <- unlist(xpathSApply(x, ".//span[@class='positive-h-c']",
                                                      xmlValue))
                            if (is.null(val)) val <- " "
                            else val #helpful?? ???? ???? NULL?????? ??ĭ��?? ??ȯ?Ѵ?.
                          } #???並 ?????Ѵ?. 
    )
    helpful<-as.numeric(helpful)
    unhelpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-down-link']",
                            function(x){
                              val <- unlist(xpathSApply(x, ".//span[@class='negative-h-c']",
                                                        xmlValue))
                              if (is.null(val)) val <- " "
                              else val #???並 ?? ????�� ???? NULL?????? ??ĭ��?? ??ȯ?Ѵ?.
                            } #???並 ?????Ѵ?. 
    )
    unhelpful<-as.numeric(unhelpful)
    ebay.r<-data.frame(product=product, date=date, review=review, rating=rating, helpful=helpful, unhelpful=unhelpful, stringsAsFactors = F) 
    ebay.review<-rbind(ebay.review, ebay.r) #?????? ????�� ???ڿ? ????��?? ?????? ?��???ȭ?Ѵ?.
    
    Sys.sleep(sample(10,1)*0.1) #��?????? ��?? ????�� ???????? ?????ϰ? ??ũ?????Ѵ?.
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review) #???? id?? ??????.
  return(ebay.review)
}

mac.review[297, ]$helpful <- 0 #?߸??? ??????. ??��?? ?ڵ? ????.
mach<-mac.review[mac.review$helpful >= 3,]
macuh<-mac.review[mac.review$unhelpful >=3, ]

baseurl<- "https://www.ebay.com/urw/Apple-iPhone-7-32GB-Black-Unlocked-A1778-GSM-/product-reviews/225300883?pgn=1"
ebay.review<- ebayreview(baseurl = baseurl)
iphone7.review <- ebay.review
View(iphone7.review)


baseurl <- "https://www.ebay.com/urw/Apple-iPhone-7-128GB-Black-Unlocked-A1778-GSM-/product-reviews/225158192?pgn=1"
iphone7.review.2 <- ebayreview(baseurl = baseurl)
iphone7.review.last <- rbind(iphone7.review,iphone7.review.2)
View(iphone7.review.last)
head(iphone7.review.last$product)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-7-128GB-Jet-Black-Unlocked-A1778-GSM-/product-reviews/225303708?pgn=1"
iphone7.review.3 <- ebayreview(baseurl = baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-7-32GB-Rose-Gold-Unlocked-A1778-GSM-/product-reviews/225209929?pgn=1"
iphone7.review.4 <- ebayreview(baseurl = baseurl)
iphone7.review.last2 <- rbind(iphone7.review.last, iphone7.review.3, iphone7.review.4)
View(iphone7.review.last2)
iphone7.review.last2$review<-gsub("[^[:alnum:]///' ]", "",iphone7.review.last2$review)

review <- paste(iphone7.review.last2$review, collapse = " ")
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,1),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


##???????? 7 
#iphonex
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-X-256GB-Space-Grey-Unlocked-A1901-GSM-/product-reviews/239165288?pgn=1"
iphonex.review <- ebayreview(baseurl= baseurl)

iphonex.review$product

str_extract_all(iphonex.review$product,"iPhone\\d{1}")
regmatches(iphonex.review$product, gregexpr("iPhone",iphonex.review$product))
str_detect(iphonex.review$product,"iPhone.")

iphone7.review.last2$product
pattern <- "(iPhone( )?(\\w{1,2}))"
str_extract_all(iphone7.review.last2$product, pattern)

iphone7.review.last2$product
pattern <- "(iPhone( )?(\\w{1,2}))"
str_extract_all(iphonex.review$product, pattern)

##word cloud 

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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,1),min.freq = 2, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

##iphone6
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6-16GB-Silver-Unlocked-A1586-CDMA-GSM-/product-reviews/203708502?pgn=1"
iphone6.review.1 <- ebayreview(baseurl=baseurl)
View(iphone6.review.1)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6-16GB-Silver-Verizon-A1549-CDMA-GSM-/product-reviews/203706964?pgn=1"
iphone6.review.2 <- ebayreview(baseurl=baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6-128GB-Space-Grey-Unlocked-A1586-CDMA-GSM-/product-reviews/203684395?pgn=1"
iphone6.review.3 <- ebayreview(baseurl=baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6-64GB-Silver-Unlocked-A1586-CDMA-GSM-/product-reviews/203684345?pgn=1"
iphone6.review.4 <- ebayreview(baseurl=baseurl)

iphone6.review.last <- rbind(iphone6.review.1,iphone6.review.2,iphone6.review.3,iphone6.review.4)
View(iphone6.review.last)


iphone6.review.last$review<-gsub("[^[:alnum:]///' ]", "",iphone6.review.last$review)

review <- paste(iphone6.review.last$review, collapse = " ")
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,1),min.freq = 4, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


###iphone5s
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-5s-16GB-Space-Grey-Unlocked-A1457-GSM-/product-reviews/168512729?pgn=1"
iphone5s.review <- ebayreview(baseurl=baseurl)

iphone5s.review$review<-gsub("[^[:alnum:]///' ]", "",iphone5s.review$review)

review <- paste(iphone5s.review$review, collapse = " ")
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,1),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


#iphone8
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-8-64GB-Space-Grey-Unlocked-A1905-GSM-/product-reviews/238941601?pgn=1"
iphone8.review <- ebayreview(baseurl=baseurl)
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(5,1),min.freq = 3, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))



#iphone6s
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-16GB-Rose-Gold-Unlocked-A1688-CDMA-GSM-/product-reviews/216278648?pgn=1"
iphone6s.review.1 <- ebayreview(baseurl=baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-64GB-Space-Gray-Unlocked-A1633-CDMA-GSM-/product-reviews/229250346?pgn=1"
iphone6s.review.2 <- ebayreview(baseurl=baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-16GB-Space-Grey-Unlocked-A1688-CDMA-GSM-/product-reviews/216189046?pgn=1"
iphone6s.review.3 <- ebayreview(baseurl=baseurl)

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-6s-Plus-128GB-Space-Gray-Unlocked-A1634-CDMA-GSM-/product-reviews/216278028?pgn=1"
iphone6s.review.4 <- ebayreview(baseurl=baseurl)

iphone6s.review <- rbind(iphone6.review.1,iphone6s.review.2, iphone6s.review.3, iphone6s.review.4)


iphone6s.review$review<-gsub("[^[:alnum:]///' ]", "",iphone6s.review$review)

review <- paste(iphone6s.review$review, collapse = " ")
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,1),min.freq = 5, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))






iphone.review <- rbind(iphone7.review.last2, iphonex.review, iphone6.review.last,iphone5s.review, iphone8.review, iphone6s.review)
View(iphone.review ) #?????? 5s ???? x???? ?? ?????? 
iphone.review$review<-gsub("[^[:alnum:]///' ]", "",iphone.review$review)

library(writexl)
write_xlsx(a,"iphone_review_final_real.xlsx")
write_xlsx(iphone.review,"iphone_review_raw.xlsx")
View(a)
pattern <- "(iPhone( )?(\\w{1,2}))"
iphone.review$product <- regmatches(iphone.review$product,gregexpr(pattern, iphone.review$product))
View(iphone.review)
write_xlsx(iphone.review,"iphone_review_after_final.xlsx")

##
iphoneh <- iphone.review[iphone.review$helpful >=3,]
iphoneuh <- iphone.review[iphone.review$unhelpful >=3,]

library(reshape2)
iphoneh$unhelpful<-NA
iphoneuh$helpful<-NA
iphonehuh<-rbind(iphoneh, iphoneuh)
iphonehuh<-iphonehuh[5:7]
m <- melt(iphonehuh, id.vars=1)
m %>% 
  drop_na(value) %>%
  ggplot(aes(x=rating, fill=variable))+
  geom_bar(position='stack')

library(tidyr)
library(ggplot2)

##iphone ??ü Ŭ?????? 


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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(8,1),min.freq = 10, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

##?ƺ? ?̸? ??ó?? 
a <-c( "Apple MacBook Pro 13.3\" - (Mid-2012, 4GB, Intel Core i5) Original box & more"   
,"Apple MacBook A1342 13.3\" Laptop (May, 2010) C2D 2.4Ghz 250GB 4GB Siera Office "
, "Apple Macbook Pro Retina 13\" Early 2015 | 2.7 i5 8Gb Ram 128Gb SSD | NICE UNIT ")

a <- toupper(a)
pattern <- "MACBOOK( )?(\\w{1,10})( )?(\\w{1,11})?( )?(\\d{2})?(\\.)?(\\d{1,1})?"
str_extract_all(a, pattern)



##???????? ??��?��?

library(openxlsx)
library(excel)
library(readxl)

a <- read.xlsx("iphone_review_final_real.xlsx")
View(a)
a <- read_excel("iphone_review_final_real.xlsx")
saveRDS(a,"iphone_review.rda")
iphone.review<-readRDS("iphone_review.rda")

b <- read_excel("iphone_reiew_raw.xlsx")
saveRDS(b,"iphone_review_raw.rda")
b<-readRDS("iphone_review_raw.rda")
View(b)
