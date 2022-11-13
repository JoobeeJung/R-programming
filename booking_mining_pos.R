

bookingReview <- function(baseurl, n=NULL){
  library(httr)
  library(XML)
  library(stringr)
  library(rvest)
  
  library(stringr)
  booking.review <- data.frame()
  for(i in c(1:n)){
    if(i==1){url <- baseurl}
    else{
      spliturl <- unlist(strsplit(url,"featuredreviews;page="))
      url <- paste0(str_sub(spliturl[1], end=-2),"featuredreviews;page=",
                    gsub(str_sub(spliturl[2],1,1),i,spliturl[2]))##pgn=을 기준으로 뒤에 1~n까지 숫자 붙이기
      
    }
    
    url
    
    review <- read_html(url)
    
    
    review_pos <- html_nodes(review,".review_pos")%>%
      html_text()
    review_pos
    
    # review_pos <- html_nodes(review,".review_pos")%>%
    #  html_text()
    
    #  booking.r <- data.frame(review_pos=review_pos, review_pos=review_pos, stringsAsFactors = FALSE)
    #  booking.review <- rbind(booking.review, booking.r)
    
    Sys.sleep(sample(10,1)*0.1)
  }
  booking.review <- paste(review_pos, collapse = " ")
  #booking.review <- cbind(id=1:nrow(booking.review),booking.review)
  return(booking.review)
}

baseurl <-"https://www.booking.com/reviews/us/hotel/e-suites-new-york-new-york-new-york.ko.html?aid=304142;label=gen173nr-1DCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQPoAQGIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;orderfeaturedreviews;page=1;r_lang=en;rows=75&"
booking.review <- bookingReview(baseurl=baseurl, n=1)
names(booking.review)
view(booking.review)
booking.review

a <- bookingReview(baseurl=baseurl, n=1)
a
b <- bookingReview(baseurl = baseurl ,n=2)
b
c <- bookingReview(baseurl=baseurl,n=3)
c
d <- bookingReview(baseurl = baseurl,n=4)
d
e <- bookingReview(baseurl = baseurl,n=5)
e
f <- bookingReview(baseurl = baseurl, n=6)
f

pos_review_1 <- paste(a,b,c,d,e,f,collapse = " ")
pos_review_1

pos_review_1 <- gsub("\\s{2,}|\n","",pos_review_1)

##전처리 끝

library(tm)
doc <- Corpus(VectorSource(pos_review_1))
class(doc)
inspect(doc)

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
doc<-tm_map(doc,removeNumbers)
mystopwords <- c(stopwords("english"),
                 c("also","among","but","the","even","for","an","this",
                   "four","get","one","said","there","two","three","the","hotel","veri","room"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)

dtm <- DocumentTermMatrix(doc)
dtm

term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:20]

library(wordcloud)
library(RColorBrewer)
set.seed(1234)
term.freq <- colSums(as.matrix(dtm))
windows(20,20)
wordcloud(words=names(term.freq), freq=term.freq, scale=c(5,1), min.freq =7,
          rot.per = 0, random.order = FALSE, random.color = FALSE,
          colors = brewer.pal(5,"Set1"))
