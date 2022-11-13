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

baseurl <-"https://www.ebay.com/urw/Canon-EOS-7D-18-0MP-Digital-SLR-Camera-Black-Body-Only-/product-reviews/108937837?pgn=1" 
ebay.review<- ebayreview(baseurl = baseurl,n=33)
ebay.review$review<-str_trim(ebay.review$review)
names(ebay.review)
View(ebay.review)
ebay.review$review[101]


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
                   "two","three","with","this","and","<99>","ever","will","review"))
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
windows(15,15)
wordcloud(words = names(term.freq), freq = term.freq, scale = c(10,0.5),min.freq = 10, rot.per = 0, random.order = FALSE,
          random.color = FALSE, colors = brewer.pal(10, "Set2"))

#iphone 8

