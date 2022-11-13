mode(1.414)

methods(print)
vec <- 1:6
vec
as.list(vec)
list(vec)

cbind(vec)
as.matrix(vec)
as.matrix(vec)
rbind(vec)
matrix(vec,2,3)
as.data.frame(vec)
as.data.frame(rbind(vec))

mat <- matrix(1:6, 3,2)
mat

lst <- list(odd=c(1,3,5), even=c(2,4,6))
lst
unlist(lst)

##################################################
url <- "https://finance.yahoo.com/quote/005930.KS/history?period1=1492873200&period2=1524754800&interval=1d&filter=history&frequency=1d"
library(XML)
install.packages("RCurl")
library(RCurl)
html
html <- getURL(url)
html.parsed <- htmlParse(html)
price.table <- readHTMLTable(html.parsed, stringsAsFactor=FALSE)
str(price.table)
price.table <- price.table[[2]]
price.table
?strptime
Sys.setlocale("LC_TIME","English")
price.table$Date <- as.Date(price.table$Date, format="%b %d %y")

period <- c("2018-04-23", "2018-04-27")

vec <- c(10,9,8,7,6,5,4,3,2,1)
match(7, vec)
match(c(11,9,8,7,0), vec)
