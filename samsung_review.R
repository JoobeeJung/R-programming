ebayreview<- function(baseurl, n=NULL){#baseurl�� n�� �μ��� �ϴ� �Լ��� �����.
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- read_html(url) #url�� html ������ �о���δ�.
    html.parsed<-htmlParse(html) #html������ �Ľ��Ѵ�.
    total.pages<- xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue)
    total.pages<- substr((total.pages),1,3) #����Ʈ ���� �� 7������ ���ķ� �������� �Ѿ�� �ʾ� �켱 �� ������� �����Ѵ�.
    total.pages<- as.numeric(total.pages) #���ڷ� �ٲ۴�.
    total.pages<-ceiling(total.pages/10) # �� �������� ���䰡 10���̹Ƿ� �� ��������� 10�� ���� ���� �ø��Ͽ� ������ �������� ã�´�.
    n<- total.pages 
  }
  ebay.review<-data.frame()
  Sys.setlocale("LC_TIME", "C") #�ð� ������ ������ �Ϲ�ǥ������ �Ͻ��� ��ȯ�Ѵ�.
  for (i in c(1:n)){
    url<- paste0(str_sub(baseurl, end=-2), i) #��� �������� url�� �����ͼ� �Ľ��Ѵ�.
    html<-read_html(url)
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']/a", xmlValue)
    
    pattern <- "(iPhone( )?(\\w{1,2}))"
    proudct <- str_extract_all(product, pattern)
    #��ǰ �̸��� �����Ѵ�.
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val #���並 �� ����� ��� NULL������ ��ĭ���� ��ȯ�Ѵ�.
                         } #���並 �����Ѵ�. 
    )
    date<-xpathSApply(html.parsed, "//span[@itemprop='datePublished']", xmlValue) #���� �ۼ� ���ڸ� �����Ѵ�.
    date<-as.Date(date, format ="%B %d, %Y") #��¥ ������ ������ �������� �����Ѵ�.
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label') #���� ������ �����Ѵ�.
    rating<-rating[-1] #ù��° ������ ��ü ������ �����̹Ƿ� �����Ѵ�.
    rating<-substr(rating, 1, 1)#���� ������ "5 stars" �̹Ƿ� �ʿ��� ù ��° ���ڸ� �����´�.
    rating<-as.numeric(rating)#����ȭ�Ѵ�. 
    helpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-up-link']",
                          function(x){
                            val <- unlist(xpathSApply(x, ".//span[@class='positive-h-c']",
                                                      xmlValue))
                            if (is.null(val)) val <- " "
                            else val #helpful�� ���� ��� NULL������ ��ĭ���� ��ȯ�Ѵ�.
                          } #���並 �����Ѵ�. 
    )
    helpful<-as.numeric(helpful)
    unhelpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-down-link']",
                            function(x){
                              val <- unlist(xpathSApply(x, ".//span[@class='negative-h-c']",
                                                        xmlValue))
                              if (is.null(val)) val <- " "
                              else val #���並 �� ����� ��� NULL������ ��ĭ���� ��ȯ�Ѵ�.
                            } #���並 �����Ѵ�. 
    )
    unhelpful<-as.numeric(unhelpful)
    ebay.r<-data.frame(product=product, date=date, review=review, rating=rating, helpful=helpful, unhelpful=unhelpful, stringsAsFactors = F) 
    ebay.review<-rbind(ebay.review, ebay.r) #������ ������ ���ڿ� �������� ������ ������ȭ�Ѵ�.
    
    Sys.sleep(sample(10,1)*0.1) #�������� ���� ������ �������� �����ϰ� ��ũ�����Ѵ�.
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review) #���� id�� �����.
  return(ebay.review)
}

#mac.review[297, ]$helpful <- 0 #�߸��� ������. ������ �ڵ� ����.
#mach<-mac.review[mac.review$helpful >= 3,]
#macuh<-mac.review[mac.review$unhelpful >=3, ]

baseurl<-"https://www.ebay.com/urw/Samsung-Galaxy-S6-SM-G920F-32GB-Black-Sapphire-Unlocked-Smartphone/product-reviews/210522964?pgn=1"
galaxy6.review<- ebayreview(baseurl = baseurl)
View(galaxy6.review)
galaxy6.review.raw <- galaxy6.review
pattern <- "(Galaxy( )?(\\w{1,2}))"
galaxy6.review$product <- regmatches(galaxy6.review$product,gregexpr(pattern, galaxy6.review$product))
galaxy6.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy6.review$review)
View(galaxy6.review)

saveRDS(galaxy6.review, file="galaxy6_review.rda")
a <- readRDS("galaxy6_review.rda")
View(a)

saveRDS(galaxy6.review.raw, file="galaxy6_review_raw.rda")
b <- readRDS("galaxy6_review_raw.rda")
View(b)

#����Ŭ���� 

review <- paste(galaxy6.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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

##galaxy s7
baseurl1 <- "https://www.ebay.com/urw/Samsung-Galaxy-S7-SM-G930-32GB-Black-Onyx-Verizon-Smartphone/product-reviews/220053197?pgn=1"
galaxy7.review1<- ebayreview(baseurl = baseurl1)

baseurl2 <- "https://www.ebay.com/urw/SAMSUNG-Galaxy-S7-SM-G930-32GB-Black-Onyx-Unlocked-Smartphone/product-reviews/220053037?pgn=1"
galaxy7.review2<- ebayreview(baseurl = baseurl2)

baseurl3 <- "https://www.ebay.com/urw/Samsung-Galaxy-S7-SM-G930F-32GB-Black-Onyx-Unlocked-Smartphone/product-reviews/220054417?pgn=1"
galaxy7.review3<- ebayreview(baseurl = baseurl3)

baseurl4 <- "https://www.ebay.com/urw/Samsung-Galaxy-S7-edge-SM-G935-32GB-Gold-Platinum-Unlocked-Smartphone/product-reviews/220023426?pgn=1"
galaxy7.review4<- ebayreview(baseurl = baseurl4)

#baseurl <- "https://www.ebay.com/urw/Samsung-Galaxy-S7-SM-G930-32GB-Black-Onyx-Verizon-Smartphone/product-reviews/220053197?pgn=1"
#galaxy7.review5<- ebayreview(baseurl = baseurl)

galaxy7.review <- rbind(galaxy7.review1,galaxy7.review2,galaxy7.review3,galaxy7.review4)
galaxy7.review.raw <- galaxy7.review

pattern <- "(Galaxy( )?(\\w{1,2}))"
galaxy7.review$product <- regmatches(galaxy7.review$product,gregexpr(pattern, galaxy7.review$product))
galaxy7.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy7.review$review)

View(galaxy7.review)

saveRDS(galaxy7.review, file="galaxy7_review.rda")
a <- readRDS("galaxy7_review.rda")
View(a)

saveRDS(galaxy7.review.raw, file="galaxy7_review_raw.rda")
b <- readRDS("galaxy7_review_raw.rda")
View(b)

#����Ŭ���� 

review <- paste(galaxy7.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(7,1),min.freq = 10, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))

#galaxy s5
baseurl <- "https://www.ebay.com/urw/Samsung-Galaxy-S5-16GB-Charcoal-Black-Unlocked-Smartphone/product-reviews/193909440?pgn=1"
galaxy5.review1<- ebayreview(baseurl = baseurl)

#baseurl <- "https://www.ebay.com/urw/Samsung-Galaxy-S5-16GB-Charcoal-Black-Unlocked-Smartphone/product-reviews/193909440?pgn=1"
#galaxy5.review2<- ebayreview(baseurl = baseurl)

baseurl1 <- "https://www.ebay.com/urw/Samsung-Galaxy-S5-Active-SM-G870A-16GB-Ruby-Red-Unlocked-Smartphone/product-reviews/195479659?pgn=1"
galaxy5.review3<- ebayreview(baseurl = baseurl1)

baseurl2 <- "https://www.ebay.com/urw/Samsung-Galaxy-S5-SM-G900F-16GB-Charcoal-Black-Unlocked-Smartphone/product-reviews/203779332?pgn=1"
galaxy5.review4<- ebayreview(baseurl = baseurl2)

baseurl3 <- "https://www.ebay.com/urw/Samsung-Galaxy-S5-SM-G900V-16GB-Charcoal-Black-Verizon-Smartphone/product-reviews/182487966?pgn=1"
galaxy5.review5<- ebayreview(baseurl = baseurl3)


galaxy5.review <- rbind(galaxy5.review1,galaxy5.review3,galaxy5.review4,galaxy5.review5)
galaxy5.review.raw <- galaxy5.review

pattern <- "(Galaxy( )?(\\w{1,2}))"
galaxy5.review$product <- regmatches(galaxy5.review$product,gregexpr(pattern, galaxy5.review$product))
galaxy5.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy5.review$review)

View(galaxy5.review)

saveRDS(galaxy5.review, file="galaxy5_review.rda")
a <- readRDS("galaxy5_review.rda")
View(a)

saveRDS(galaxy5.review.raw, file="galaxy5_review_raw.rda")
b <- readRDS("galaxy5_review_raw.rda")
View(b)
#����Ŭ���� 

review <- paste(galaxy5.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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


#galaxy s8
baseurl <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G950U-64GB-Midnight-Black-Unlocked-Smartphone/product-reviews/235346440?_itm=163371335312&pgn=1"
galaxy8.review1<- ebayreview(baseurl = baseurl)

baseurl1 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G955U-64GB-Midnight-Black-T-Mobile-Smartphone/product-reviews/235308402?pgn=1"
galaxy8.review2<- ebayreview(baseurl = baseurl1)

baseurl2 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-64GB-Maple-Gold-Smartphone/product-reviews/235373465?pgn=1"
galaxy8.review3<- ebayreview(baseurl = baseurl2)

baseurl3 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G955U-64GB-Arctic-silver-Verizon-Smartphone/product-reviews/235308382?pgn=1"
galaxy8.review4<- ebayreview(baseurl = baseurl3)

baseurl4 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-Active-SM-G892-64GB-Meteor-Gray-Unlocked-Smartphone/product-reviews/238843356?pgn=1"
galaxy8.review5<- ebayreview(baseurl = baseurl4)

baseurl5 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G955U-64GB-Midnight-Black-AT-T-Smartphone/product-reviews/235391277?pgn=1"
galaxy8.review6<- ebayreview(baseurl = baseurl5)

baseurl6 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G950U-64GB-Midnight-Black-T-Mobile-Smartphone/product-reviews/235365084?pgn=1"
galaxy8.review7<- ebayreview(baseurl = baseurl6)

baseurl7 <- "https://www.ebay.com/urw/Samsung-Galaxy-S8-SM-G950F-64GB-Orchid-Gray-Unlocked-Smartphone/product-reviews/235346480?pgn=1"
galaxy8.review8<- ebayreview(baseurl = baseurl7)


galaxy8.review <- rbind(galaxy8.review1,galaxy8.review2,galaxy8.review3,galaxy8.review4,galaxy8.review5,galaxy8.review6,galaxy8.review7,galaxy8.review8)
galaxy8.review.raw <- galaxy8.review

pattern <- "(Galaxy( )?(\\w{1,2}))"
galaxy8.review$product <- regmatches(galaxy8.review$product,gregexpr(pattern, galaxy8.review$product))
galaxy8.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy8.review$review)

View(galaxy8.review)

saveRDS(galaxy8.review, file="galaxy8_review.rda")
a <- readRDS("galaxy8_review.rda")
View(a)

saveRDS(galaxy8.review.raw, file="galaxy8_review_raw.rda")
b <- readRDS("galaxy8_review_raw.rda")
View(b)
#����Ŭ���� 

review <- paste(galaxy8.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(6,1),min.freq = 5, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))


#galaxy s9
baseurl1 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G965-64GB-Coral-Blue-Unlocked-Smartphone/product-reviews/243309649?pgn=1"
galaxy9.review1<- ebayreview(baseurl = baseurl1)

baseurl2 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G960-64GB-Midnight-Black-Unlocked-Smartphone/product-reviews/243306776?pgn=1"
galaxy9.review2<- ebayreview(baseurl = baseurl2)

baseurl3 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G960-64GB-Coral-Blue-Unlocked-Smartphone/product-reviews/243237212?pgn=1"
galaxy9.review3<- ebayreview(baseurl = baseurl3)

baseurl4 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G965-64GB-Midnight-Black-Unlocked-Smartphone/product-reviews/243277240?pgn=1"
galaxy9.review4<- ebayreview(baseurl = baseurl4)

baseurl5 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G965-64GB-Midnight-Black-Unlocked-Smartphone-CA-/product-reviews/243293234?pgn=1"
galaxy9.review5<- ebayreview(baseurl = baseurl5)

baseurl6 <- "https://www.ebay.com/urw/Samsung-Galaxy-S9-SM-G960-64GB-Midnight-Black-Unlocked-Smartphone/product-reviews/243315735?_itm=223236795617&pgn=1"
galaxy9.review6<- ebayreview(baseurl = baseurl6)


galaxy9.review <- rbind(galaxy9.review1,galaxy9.review2,galaxy9.review3,galaxy9.review4,galaxy9.review5,galaxy9.review6)
galaxy9.review.raw <- galaxy9.review

pattern <- "(Galaxy( )?(\\w{1,2}))"
galaxy9.review$product <- regmatches(galaxy9.review$product,gregexpr(pattern, galaxy9.review$product))
galaxy9.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy9.review$review)

View(galaxy9.review)

saveRDS(galaxy9.review, file="galaxy9_review.rda")
a <- readRDS("galaxy9_review.rda")
View(a)

saveRDS(galaxy9.review.raw, file="galaxy9_review_raw.rda")
b <- readRDS("galaxy9_review_raw.rda")
View(b)
#����Ŭ���� 

review <- paste(galaxy9.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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

#��ü������ ������
galaxy.review <- rbind(galaxy5.review, galaxy6.review, galaxy7.review,galaxy8.review, galaxy9.review)
View(galaxy.review ) #������ 5s ���� x���� �� ������ 
galaxy.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy.review$review)
galaxy.review$product <- unlist(galaxy.review$product)

##������, ������ ��ġ��
smartphone.review <- rbind(iphone.review, galaxy.review)
View(smartphone.review)
unique(smartphone.review$product)

saveRDS(smartphone.review,"smartphone_review.rda")
smartphone.review<-readRDS("smartphone_review.rda")

library(writexl)
#write_xlsx(a,"iphone_review_final_real.xlsx")
write_xlsx(galaxy.review,"galaxy_review_final.xlsx")
View(galaxy.review.raw)
galaxy.review.raw <- rbind(galaxy5.review.raw, galaxy6.review.raw, galaxy7.review.raw,galaxy8.review.raw, galaxy9.review.raw)
write_xlsx(galaxy.review.raw,"galaxy_review_raw.xlsx")

saveRDS(galaxy.review, file="galaxy_review.rda")
a <- readRDS("galaxy_review.rda")
View(a)

saveRDS(galaxy.review.raw, file="galaxy_review_raw.rda")
b <- readRDS("galaxy_review_raw.rda")
View(b)

#����Ŭ���� 

review <- paste(galaxy.review$review, collapse = " ")
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
                   "two","three","with","this","and","<99>","iphon","phone"))
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
wordcloud(words = names(term.freq), freq = term.freq, scale = c(6,1),min.freq = 10, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(5, "Set1"))