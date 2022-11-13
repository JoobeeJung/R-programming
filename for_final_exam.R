library(RCurl)
url <- "https://www.imdb.com/title/tt0114709/?ref_=nv_sr_3"
html <- getURL(url)
html

library(httr)
html <- GET(url)

library(xml2)
html <- read_html(url)

library(XML)
html.parsed <- htmlParse(html)

rating <- xpathSApply(html.parsed, "//span[@itemprop='ratingValue']", xmlValue)
rating

rating <- xpathSApply(html.parsed, "//strong/span",xmlValue)
rating

rating <- as.numeric(rating)
str(rating)

poster <- xpathSApply(html.parsed,"//div/a/img[@alt='Toy Story Poster']",xmlGetAttr,"src")
poster

download.file(poster,'toystory.jpg',mode = "wb")

library(imager)
install.packages('imager')
par(mar=c(1,1,1,1))
plot(load.image("toystory.jpg"),axes = FALSE)

summary <- xpathSApply(html.parsed,"//div[@class='summary_text']",xmlValue)
summary

summary <- gsub("\\n","",summary)
summary
library(stringr)
summary <- str_trim(summary)
summary

storyline <- xpathSApply(html.parsed,"//div[@class='inline canwrap']/p/span",xmlValue)
storyline
storyline <- str_trim(storyline)
storyline <- gsub("\\t","",storyline)
nchar(storyline)
cat(storyline)
storyline <- gsub("\\s{2,}"," ",storyline)

url <- "https://archive.nytimes.com/www.nytimes.com/learning/general/onthisday/big/0911.html"
html <- getURL(url)
html <- GET(url)
html.parsed <- htmlParse(html)
text <- xpathSApply(html.parsed,"//p",xmlValue)
text <- str_trim(text)
head(text)

str(text)
text <- paste(text," ")
text <- gsub("\\s{2,}| \n","",text)

library(tm)
doc <- Corpus(VectorSource(text))

doc <- tm_map(doc, removePunctuation)
doc <- tm_map(doc, content_transformer(tolower))
doc <- tm_map(doc, removeNumbers)

mystopwords <- c(stopwords("english"),
                 c("also","among","but","even","four",
                   'get',"one","said","the","there","two","three"))
doc <- tm_map(doc, removeWords, mystopwords)
doc <- tm_map(doc, stripWhitespace)
doc <- tm_map(doc, stemDocument)

dtm <- DocumentTermMatrix(doc)
dtm
term.freq <- colSums(as.matrix(dtm))
term.freq[order(term.freq, decreasing = TRUE)][1:10]

##imdb
url <- "https://www.imdb.com/search/title?title_type=feature&release_date=2015-01-01,2015-12-31&count=100"
html <- getURL(url)
html.parsed <- htmlParse(html)
rank <- xpathSApply(html.parsed,"//span[@class='lister-item-index unbold text-primary']",xmlValue)
rank
rank <- as.numeric(rank)

title <- xpathSApply(html.parsed,"//span[@class='lister-item-index unbold text-primary']/following-sibling::a",xmlValue)
title

title2 <- xpathSApply(html.parsed,"//h3[@class='lister-item-header']/a",xmlValue)

description <- xpathSApply(html.parsed,"//p[@class='text-muted']",xmlValue, trim=TRUE)
head(description)
description<- gsub("\n | \\s{2,}","",description)

runtime <- xpathSApply(html.parsed,"//span[@class='runtime']",xmlValue)
runtime <- gsub(" min","",runtime)
runtime
runtime <- as.numeric(runtime)

genre <- xpathSApply(html.parsed,"//span[@class='genre']",xmlValue,trim=TRUE)

genre <- gsub(",.*","",genre)
head(genre)
genre <- as.factor(genre)

rating <- xpathSApply(html.parsed,"//span[@class='global-sprite rating-star imdb-rating']/following-sibling::strong",xmlValue)
head(rating)

rating2 <- xpathSApply(html.parsed,"//div[@class='inline-block ratings-imdb-rating']",xmlGetAttr,"data-value")
rating <- as.numeric(rating)
summary(rating)

director <- xpathSApply(html.parsed,"//p[@class='text-muted']/following-sibling::p/a[1]",xmlValue)
director2 <- xpathSApply(html.parsed,"//div[@class='lister-item-content']/p[@class='']/a[1]",xmlValue)

votes <- xpathSApply(html.parsed,"//p[@class='sort-num_votes-visible']/span[2]",xmlGetAttr,"data-value")
votes
votes2 <- xpathSApply(html.parsed,"")

##
url <- "https://www.amazon.com/Who-Moved-My-Cheese-Amazing/product-reviews/0399144463/ref=cm_cr_arp_d_paging_btm_2?ie=UTF8&reviewerType=all_reviews&pageNumber=1"
html <- getURL(url)
library(RCurl)
library(xml2)
library(XML)
html <- read_html(url)
html.parsed <- htmlParse(html)

product <- xpathSApply(html.parsed, "//h1/a[@data-hook='product-link']",xmlValue)
product 

author <- xpathSApply(html.parsed,"//div[@class='a-row product-by-line']/a",xmlValue)

author <- xpathSApply(html.parsed,"//span[@class='a-profile-name']",xmlValue)

url2 <- "https://www.amazon.com/Who-Moved-My-Cheese-Amazing/product-reviews/0399144463/ref=cm_cr_arp_d_paging_btm_2?ie=UTF8&reviewerType=all_reviews&pageNumber=23"
html2 <- read_html(url2)
html.parsed2 <- htmlParse(html2)
author2 <- xpathSApply(html.parsed2, "//span[@class='a-profile-name']", xmlValue)
author2

author <- xpathSApply(html.parsed,"//span[@data-hook='review-date']/parent::div",
                      function(x){
                        val <- unlist(xpathSApply(x,".//span[@class='a-profile-name']",
                                                  xmlValue))
                        if(is.null(val)) val <- "Amazon Customer"
                        else val
                      }
)

date <- xpathSApply(html.parsed,"//span[@data-hook='review-date']",xmlValue)
Sys.setlocale("LC_TIME","C")
date <- as.Date(date,format="%B %d, %Y")
date

quote <- xpathSApply(html.parsed,"//a[@data-hook='review-title']",xmlValue)

review <- xpathSApply(html.parsed,"//span[@data-hook='review-body']",xmlValue)

rating <- xpathSApply(html.parsed,"//span[@class='a-icon-alt']",xmlValue)
rating <- gsub(" of.*","",rating)
rating
helpful <- xpathSApply(html.parsed,"//span[@data-hook='helpful-vote-statement']",xmlValue)
helpful <- gsub("One","1",helpful)
helpful <- as.numeric(str_extract(helpful,"\\d{1,}"))
library(stringr)

total.pages <- xpathSApply(html.parsed,"//li[@data-reftag='cm_cr_arp_d_paging_btm'][5]/a",xmlValue)
total.pages

amazonReview <- function(baseurl,n=NULL){
  library(httr)
  library(XML)
  library(xml2)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- GET(url)
    html.parsed <- htmlParse(html)
    total.pages <- xpathSApply(html.parsed,"//li[@data-reftag='cm_cr_arp_d_paging_btm'][5]/a",xmlValue)
    total.pages <- as.numeric(gusb(",","",total.pages))
    n<- total.pages
  }
  amazon.review <- data.frame()
  Sys.setlocale("LC_TIME","C")
  for (i in c(1:n)){
    spliturl <- unlist(strsplit(baseurl,"\\?"))
    url <- paste0(str_sub(spliturl[1],end=-2),i,"?",
                  str_sub(spliturl[2],end=-2),i)
    html <- GET(url)
    html.parsed <- htmlParse(html)
    product <-
      }
}

url <- "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=%s&solMonth=%s&ServiceKey=%s"
year <- "2018"
month <- "05"
key <- "i0TZyaw8tFN7b%2B1bwQq0j%2B4eqzSsZmnz64zlf6z%2Blk9i4Xb%2FxIXWvD2xO7oxqHJpje6gRGiLexKgpExUalxtug%3D%3D"
sprintf(url,year,month,key)

library(XML)
library(RCurl)
library(xml2)
library(httr)
xml <- getURL(sprintf(url,year,month,key),encoding="UTF-8")
xml.parsed <- xmlParse(xml)
holiday <- xpathSApply(xml.parsed,"//datetime",xmlValue)
date <- xpathSApply(xml.parsed,"//locdate",xmlValue)
holiday; date

library(rvest)
url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
pop <- read_html(url) %>%
  html_nodes("table")
pop
Sys.setlocale("LC_ALL","English")
pop <- html_table(pop[[1]])
class(pop)
pop
head(pop,3); tail(pop,3)
Sys.setlocale()

names(pop) <-c("rank","country","population","date","percent","source")
pop$rank <- gsub("\U2013","-",pop$rank)
pop$country <-gsub("\\[Note.*\\]","",pop$country)
pop$population <- as.numeric(gsub(",","",pop$population))
pop$percent <- as.numeric(gsub("%","",pop$percent))
View(pop)

library(dplyr)
summarise(pop,
          Min=min(population),
          Median=median(population),
          Mean=mean(population),
          SD=sd(population),
          Max=max(population),
          N=n())
pop20 <- pop[order(pop$population, decreasing = TRUE),][1:20,]

tail(pop$country,3)

library(stringr)
pop$country2 <- pop$country %>%
  str_replace_all("\\(.*?\\)","")%>%
  str_trim
tail(pop$country2,3)

library(googleway)
gapi.key <- "AIzaSyBAZIdN3Ojy2zrRzEKzXUrGp7tFC9ojs3s"
getGeocode <- function(address, key){
  library(googleway)
  geo.result <- data.frame()
  for (i in address){
    geo.each <- geocode_coordinates(google_geocode(i, key=key))
    geo.each$address <- i
    geo.result <- rbind(geo.result, geo.each[1,])
    Sys.sleep(sample(10,1)*0.1)
  }
  return(geo.result)
}
str(pop$country2)
names(pop$country2)

geo.result <- getGeocode(pop$country2, key=gapi.key)
head(geo.result, 3); tail(geo.result,3)

names(geo.result)

pop <- inner_join(pop, geo.result, by=c("country2"="address"))
head(pop,3)

library(dplyr)
install.packages("viridis")
library(viridis)
library(maps)
library(maptools)
library(ggmap)
install.packages("ggmap")
map.data <- map_data(map="world")
mybreaks <- c(0.01,0.1,1,10,100,1000)
mylabels <- c("10 Thousands","100 Thousands","Millions","10 Millions","100 Millions","Billions")
windows(7,5)
ggplot(map.data)+
  geom_map(aes(map_id=region),map=map.data,
           fill="peachpuff", color="gray40", size=0.5)+
  expand_limits(x=map.data$long, y=map.data$lat)+
  coord_fixed(xlim=c(-180,180),ylim=c(-55,90),ratio=1.3)+
  geom_point(data=arrange(pop,population),shape=20,
             aes(x=geo.result$lng,y=geo.result$lat,size=population/1000000,
                 color=population/1000000,alpha=population/1000000))+
  scale_size_continuous(name="Population",trans="sqrt",range=c(2,8),
                        breaks=mybreaks, labels = mylabels)+
  scale_alpha_continuous(name="Population",trans="sqrt",range=c(0.1,0.9),
                        breaks=mybreaks, labels = mylabels)+
  scale_color_viridis(name="Population",option="plasma",trans="sqrt",
                        breaks=mybreaks, labels = mylabels)+
  theme_void()+
  guides(size=guide_legend(nrow=1),color=guide_legend(nrow=1),
         alpha=guide_legend(nrow=1))
  
map.data <- left_join(map.data, population, by=c("region"="country"))
population2 <- pop$population2
pop.plot <- ggplot(data=map.data, mapping = aes(x=long, y=lat))+
  geom_polygon(aes(fill=population2, group=group), color="white")+
  coord_fixed(xlim=c(-180,180),ylim=c(-55,90),ratio=1.3)+
  scale_fill_viridis(name=NULL, option = "plasma",
                     breaks=c(0.01,0.1,1,10,100,1000),
                     labels=c("10 Thousands","100 Thousands","Millions",
                              "10 Millions","100 Millions","Billions"))+
  theme_void()+
  guides(color=guide_legend(),
         fill=guide_colorbar(barwidth = 15, barheight = 0.7))+
  theme(plot.title = element_text(face="bold"),
        legend.position = "bottom",
        legend.text = element_text(size=8))
windows(8,5.5)
pop.plot

str(pop$population)
pop$population2 <- pop$population/1000000
head(pop$population2)
View(pop)


string <- c("a","ac","abc","abbc","abbbc","abababc","abab","abababab","abcabcabc")
grep("ab?c",string, value=TRUE)
grep("ab*c",string, value=TRUE)
grep("ab+c",string, value=TRUE)
grep("ab{2}c",string, value=TRUE)
grep("ab{2,}c",string, value=TRUE)
grep("ab{2,3}c",string, value=TRUE)
grep("(ab){2,3}",string, value=TRUE)
grep("ab{2,3}",string, value=TRUE)
