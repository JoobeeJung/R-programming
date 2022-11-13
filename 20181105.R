install.packages("rvest")
library(rvest)
page <- read_html(x="moviequotes.html")
page
class(page)

node <- html_nodes(x=page, css ="div i")
node

text <- html_text(x=node)
text[1]

url <- "https://www.imdb.com/title/tt0114709/?ref_=nv_sr_2"
url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=1;r_lang=en;rows=75&"
url <- "https://www.booking.com/reviews/us/hotel/citizenm-new-york-times-square-new-york.ko.html?aid=304142;label=gen173nr-1FCAEoggI46AdIM1gEaH2IAQGYARe4ARfIAQzYAQHoAQH4AQyIAgGoAgM;sid=fbda4097fd1a54e9a879050610e2ce87;customer_type=total;hp_nav=0;old_page=0;order=featuredreviews;page=2;r_lang=en;rows=75&"
review <- read_html(url)
reviews <- html_nodes(review, ".review_neg")%>%
  html_text()
reviews
View(reviews)

rating <- read_html(url)%>%
  html_nodes("strong span")%>%
  html_text()%>%
  as.numeric()
View(rating)

url <- "https://www.imdb.com/chart/top?ref_=nv_mv_250"
page<- read_html(url)
page

title <- html_nodes(page,".titleColumn a")%>%
  html_text()

library(RCurl)
url <- "http://www.nationmaster.com/country-info/stats/Cost-of-living/Average-monthly-disposable-salary/After-tax"
html <- getURL(url)
html.parsed <- htmlParse(html)

install.packages("maps")
library(maps)
map.data <- map_data(map="world")
head(map.data)

url <- "https://www.usnews.com/education/best-global-universities/rankings"
library(googleway)
install.packages("googleway")
addr <- enc2utf8("±¹¹Î´ëÇÐ±³")
loc <- google_geocode(addr, gapi.key)
