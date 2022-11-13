library(RCurl)
url <- "https://www.imdb.com/title/tt0114709/?ref_=nv_sr_2"
html <- getURL(url)
library(httr)
library(XML)
html.parsed <- htmlParse(html)
rating <- xpathSApply(doc=html.parsed, path = )

storyline <-xpathSApply(doc = html.parsed, path="//div[@class='inline canwrap']", fun = xmlValue)
storyline
storyline <- str_trim(storyline)
storyline <- gsub("\n","",storyline)
storyline <- gsub("\\s{2,}"," ",storyline)
nchar(storyline)
library(stringr)

install.packages("tm")
library(tm)
library(wordcloud)
install.packages("wordcloud")


#####2015sus dlsrldudghk
url <- "https://www.imdb.com/search/title?title_type=feature&release_date=2015-01-01,2015-12-31&count=100"
html <- getURL(url)
library(RCurl)
library(XML)
library(httr)
library(xml2)
url <- "https://www.amazon.com/Who-Moved-My-Cheese-Amazing/product-reviews/0399144463/ref=cm_cr_getr_d_paging_btm_1?ie=UTF8&reviewerType=all_reviews&pageNumber=1"
html <- read_html(url)
html.parsed <- htmlParse(html)

product <- xpathSApply(html.parsed, "//h1/a[@data-hook='product-link']",xmlValue)
author <- xpathApply()