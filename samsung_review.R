ebayreview<- function(baseurl, n=NULL){#baseurl과 n을 인수로 하는 함수를 만든다.
  library(xml2)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- read_html(url) #url을 html 문서로 읽어들인다.
    html.parsed<-htmlParse(html) #html문서를 파싱한다.
    total.pages<- xpathSApply(html.parsed, "//h2[@class='p-rvw-count ']", xmlValue)
    total.pages<- substr((total.pages),1,3) #사이트 문제 상 7페이지 이후로 페이지가 넘어가지 않아 우선 총 리뷰수를 추출한다.
    total.pages<- as.numeric(total.pages) #숫자로 바꾼다.
    total.pages<-ceiling(total.pages/10) # 한 페이지당 리뷰가 10개이므로 총 리뷰수에서 10을 나눈 것을 올림하여 마지막 페이지를 찾는다.
    n<- total.pages 
  }
  ebay.review<-data.frame()
  Sys.setlocale("LC_TIME", "C") #시간 로케일 형식을 북미표준으로 일시적 변환한다.
  for (i in c(1:n)){
    url<- paste0(str_sub(baseurl, end=-2), i) #모든 페이지의 url을 가져와서 파싱한다.
    html<-read_html(url)
    html.parsed<-htmlParse(html)
    
    product<- xpathSApply(html.parsed, path="//h1[@class='header-title vertical-align']/a", xmlValue)
    
    pattern <- "(iPhone( )?(\\w{1,2}))"
    proudct <- str_extract_all(product, pattern)
    #제품 이름을 추출한다.
    review<- xpathSApply(html.parsed, "//span[@itemprop='datePublished']/ancestor::div[@class='ebay-review-section-l']/following-sibling::div",
                         function(x){
                           val <- unlist(xpathSApply(x, ".//p[@itemprop='reviewBody']",
                                                     xmlValue))
                           if (is.null(val)) val <- " "
                           else val #리뷰를 안 써놓은 경우 NULL값에서 빈칸으로 변환한다.
                         } #리뷰를 추출한다. 
    )
    date<-xpathSApply(html.parsed, "//span[@itemprop='datePublished']", xmlValue) #리뷰 작성 날자를 추출한다.
    date<-as.Date(date, format ="%B %d, %Y") #날짜 형식을 연월일 형식으로 변경한다.
    rating<-xpathSApply(doc = html.parsed, path="//span[(@class='star-rating')]", xmlGetAttr, 'aria-label') #리뷰 평점을 추출한다.
    rating<-rating[-1] #첫번째 평점은 전체 리뷰의 평점이므로 제외한다.
    rating<-substr(rating, 1, 1)#평점 형식이 "5 stars" 이므로 필요한 첫 번째 문자만 가져온다.
    rating<-as.numeric(rating)#숫자화한다. 
    helpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-up-link']",
                          function(x){
                            val <- unlist(xpathSApply(x, ".//span[@class='positive-h-c']",
                                                      xmlValue))
                            if (is.null(val)) val <- " "
                            else val #helpful이 없는 경우 NULL값에서 빈칸으로 변환한다.
                          } #리뷰를 추출한다. 
    )
    helpful<-as.numeric(helpful)
    unhelpful<- xpathSApply(html.parsed, "//a[@class='review-signal vote-down-link']",
                            function(x){
                              val <- unlist(xpathSApply(x, ".//span[@class='negative-h-c']",
                                                        xmlValue))
                              if (is.null(val)) val <- " "
                              else val #리뷰를 안 써놓은 경우 NULL값에서 빈칸으로 변환한다.
                            } #리뷰를 추출한다. 
    )
    unhelpful<-as.numeric(unhelpful)
    ebay.r<-data.frame(product=product, date=date, review=review, rating=rating, helpful=helpful, unhelpful=unhelpful, stringsAsFactors = F) 
    ebay.review<-rbind(ebay.review, ebay.r) #추출한 값들을 문자열 형식으로 데이터 프레임화한다.
    
    Sys.sleep(sample(10,1)*0.1) #웹페이지 접속 간격을 지연시켜 안전하게 스크래핑한다.
  }
  Sys.setlocale()
  ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review) #리뷰 id를 만든다.
  return(ebay.review)
}

#mac.review[297, ]$helpful <- 0 #잘못된 데이터. 없으면 코드 생략.
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

#워드클라우드 

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

#워드클라우드 

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
#워드클라우드 

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
#워드클라우드 

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
#워드클라우드 

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

#전체데이터 모으기
galaxy.review <- rbind(galaxy5.review, galaxy6.review, galaxy7.review,galaxy8.review, galaxy9.review)
View(galaxy.review ) #아이폰 5s 부터 x까지 총 데이터 
galaxy.review$review<-gsub("[^[:alnum:]///' ]", "",galaxy.review$review)
galaxy.review$product <- unlist(galaxy.review$product)

##갤럭시, 아이폰 합치기
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

#워드클라우드 

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
