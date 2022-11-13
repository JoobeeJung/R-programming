baseurl<-"https://www.booking.com/reviews/us/hotel/luma-times-square.ko.html?aid=373003;label=naver-brand-list3;sid=fd0e01db31c7c8e002f7e25f34486b83;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;"
review_p<-list()
review_n<-list()
for(i in 1:11){
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

write_xlsx(c,"luma-p.xlsx")
View(review_n)
d <- unlist(review_n)
e <- as.data.frame(d)
write_xlsx(e,"luma-n.xlsx")

