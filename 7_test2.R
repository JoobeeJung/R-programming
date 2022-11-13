url <- "http://loc.gov/rr/print/list/057_chron.html"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
str(html.tab)
presidents <- html.tab[[4]]
str(presidents)

years <- strsplit(presidents, split = "-")
str(years)
presidents <- cbind(presidents, years)
max(presidents$END-presidents$START)

subset(presidents, select=c(YEAR, PRESIDENT), subset=(presidents$END-presidents$START)==8)

