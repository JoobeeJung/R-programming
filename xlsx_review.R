library(RCurl)
library(xml2)
library(XML)
library(httr)
library(stringr)
library(rvest)

#citizen
#baseurl <-"https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;"

#AKA hotel
baseurl<-"https://www.booking.com/reviews/us/hotel/the-ludlow.ko.html?aid=304142;label=gen173nr-1BCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQGIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;"
baseurl<-"https://www.booking.com/reviews/us/hotel/blakely-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fd0e01db31c7c8e002f7e25f34486b83;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;"

end<-";r_lang=en;rows=75&"
review_p<-list()
review_n<-list()
for(i in 1:8){
  url <- paste0(baseurl, "page=", i, end)
  review <- read_html(url)
  review_neg <- html_nodes(review, ".review_neg")%>%
    html_text()
  html<-read_html(url)
  review_n<-rbind(review_n, review_neg)
  
  review_pos <-html_nodes(review, ".review_pos")%>%
    html_text()
  html<-read_html(url)
  review_p<-rbind(review_p,review_pos)
}
View(review_p)
#a <- as.list(review_p)
#str(a)
#head(a)
#a[[1]]
b <- unlist(review_p)
str(b)
View(b)
c <- as.data.frame(b)
View(c)

write_xlsx(c,"blakely-new-york-p.xlsx")
View(review_n)
d <- unlist(review_n)
e <- as.data.frame(d)
write_xlsx(e,"blakely-new-york-n.xlsx")
