
ebayReview <- function(baseurl, n=NULL){
  library(httr)
  library(XML)
  library(stringr)
  if(is.null(n)){

    url <- baseurl
    html <- GET(url)
    html.parsed <- htmlParse(html)
    total.pages <- xpathSApply(html.parsed,
                               "//a[@class='current spf-link']",xmlValue) ##현재 페이지 번호 가지고 오기
    total.pages <- substring(total.pages, -2) ##숫자만 가지고 오기
    n <- total.pages
  }
  
  ebay.review <- data.frame()
  Sys.setlocale("LC_TIME","C")
  for(i in c(1:10)){
  spliturl <- unlist(strsplit(url,"pgn=?"))
  secondurl <- paste0(str_sub(spliturl[1], end=-2),i,"?pgn=",
                      str_sub(spliturl[2], end=-2),i)##pgn=을 기준으로 뒤에 1~n까지 숫자 붙이기
a<-spliturl
b <-secondurl}
  a
  b
  spliturl
  secondurl
  
    html <- GET(url)
  html.parsed <- htmlParse(html)
  
  quote<- xpathSApply(html.parsed,"//div[@class='ebay-review-section-r']/h3[@itemprop='name']",xmlValue)기 ##리뷰 제목 추출
  star <- xpathSApply(html.parsed,"//span[@class='star-rating']",xmlGetAttr,"aria-label")  ## 별점 추출
  star <- unlist(strsplit(star,"stars"))
  star <- str_trim(star)
  
    ebay.r <- data.frame(quote=quote, star=star, stringsAsFactors = FALSE)
    ebay.review <- rbind(ebay.review, ebay.r)
  
  Sys.sleep(sample(10,1)*0.1)
}
Sys.setlocale()
ebay.review <- cbind(id=1:nrow(ebay.review), ebay.review)
return(ebay.review)
}

baseurl <- "https://www.ebay.com/urw/Apple-iPhone-X-64GB-Space-Grey-Unlocked-A1901-GSM-/product-reviews/239057380?pgn=1"
ebay.review <- ebayReview(baseurl=baseurl, n=5)
names(ebay.review)
view(ebay.review)

url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1DCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQPoAQGIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=1;r_lang=en;rows=75&"
url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1DCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQPoAQGIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=1;r_lang=en;rows=75&"
url <- "https://www.ebay.com/urw/Apple-iPhone-7-128GB-Black-Unlocked-A1778-GSM-/product-reviews/225158192?pgn=1"
url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1DCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQPoAQGIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=2;r_lang=en;rows=75&"

url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=1;r_lang=en;rows=75&"
url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=2;r_lang=en;rows=75&"
library(httr)
library(XML)
library(stringr)
html <- GET(url)
html.parsed <- htmlParse(html)
neg_review <- xpathSApply(html.parsed, ".review_item_review_content",xmlValue)
neg_review
 pos_review <- xpathSApply(html.parsed, "//p[@class='review_neg selectorgadget_selected']/span[@itemprop='reviewBody']",xmlValue)
pos_review

review<- xpathSApply(html.parsed, "//svg[@class='bk-icon -fonticon-removecircle review_item_icon']/following-sibling::span",xmlValue)


node <- html_nodes(x=page, css ="div i")
node

product <- xpathSApply(html.parsed, "//a[@_sp='p2266119.m3959.l7248']",xmlGetAttr,"title")
product ## 제품명

quote<- xpathSApply(html.parsed,"//div[@class='ebay-review-section-r']/h3[@itemprop='name']",xmlValue) ##리뷰 제목 추출
quote
star <- xpathSApply(html.parsed,"//span[@class='star-rating']",xmlGetAttr,"aria-label")  ## 별점 추출
star <- (strsplit(star,"stars"))
star <- str_trim(star)
star <- star[2:11]
star

review <- xpathSApply(html.parsed, "//p[@itemprop='reviewBody']",xmlValue)
review <- gsub("Read full review...","",review)
review <- gsub("\n","", review)
review

date <- xpathSApply(html.parsed,"//span[@itemprop='datePublished']",xmlValue)
Sys.setlocale("LC_TIME","C")
date <- as.Date(date, format="%B %d, %Y")
date
str(date)
Sys.setlocale()

total<- xpathSApply(html.parsed, "/div[@class='reviews-divider']/following-sibling::span",xmlValue)
total
##/div[@class='top-Reviews-Wrapper']/
total <- xpathSApply(html.parsed, "//nav[@class='pagination-warpper']/span",xmlValue)
total <- xpathSApply(html.parsed, "//nav[@class='pagination-warpper']/div[@class='reviews-divider']/following-sibling::span",xmlValue)
total
total <- xpathSApply(html.parsed, "//nav[@role='navigation']/span",xmlValue)
total

total.pages <- xpathSApply(html.parsed,"//a[@class='disabled spf-link']/parent::li/following-sibling::li[last()-1]", xmlValue) #마지막 페이지 찾기. [last()-1] 제외하면 전체 페이지 나


ebayReview <- function(baseurl,n=NULL){
  library(httr)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- GET(url)
    html.parsed <- htmlParse(html)
    total.pages <- xpathSApply(html.parsed,"//a[@class='disabled spf-link']/parent::li/following-sibling::li[last()-1]", xmlValue)
    n <- total.pages
  }
  ebay.review <- data.frame()
  Sys.setlocale("LC_TIME","C")
  
  for (i in c(1:n)){
    spliturl <- unlist(strsplit(baseurl,"pgn=?"))
    url <- paste0(str_sub(spliturl[1], end=-2),i,"?pgn=",
                        str_sub(spliturl[2], end=-2),i)
    html <- GET(url)
    html.parsed <- htmlParse(html)
    
    #product <- xpathSApply(html.parsed, "//a[@_sp='p2266119.m3959.l7248']",xmlGetAttr,"title")
    
    #date <- xpathSApply(html.parsed,"//span[@itemprop='datePublished']",xmlValue)
    #date <- as.Date(date, format="%B %d, %Y")

    
    quote<- unlist(xpathSApply(html.parsed,"//div[@class='ebay-review-section-r']/h3[@itemprop='name']",xmlValue)) ##리뷰 제목 추출
    
    star <- xpathSApply(html.parsed,"//span[@class='star-rating']",xmlGetAttr,"aria-label")  ## 별점 추출
    star <- (strsplit(star,"stars"))
    star <- str_trim(star)
    star <- star[2:11]
    star <- unlist(as.numeric(star))
    
    review <- xpathSApply(html.parsed, "//p[@itemprop='reviewBody']",xmlValue)
    review <- gsub("Read full review...","",review)
    review <- unlist(gsub("\n","", review))
    #if(length(date)>0){
    ebay.r <- data.frame(quote=quote,star=star, review=review, stringsAsFactors = FALSE)
    ebay.review <- rbind(ebay.review, ebay.r)
  #  }
   # Sys.sleep(sample(10,1)*0.1)
  }
  Sys.setlocale()
  ebay.review<- cbind(id=1:nrow(ebay.review), ebay.review)
  return(ebay.review)
}
baseurl <-"https://www.ebay.com/urw/Apple-iPhone-X-64GB-Space-Grey-Unlocked-A1901-GSM-/product-reviews/239057380?pgn=1"
ebay.review <- ebayReview(baseurl = baseurl,n=6)
names(ebay.review)
View(ebay.review)
