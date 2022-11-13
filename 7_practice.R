product <- data.frame(id=c("A001", "A002", "A003"),
                      name = c("Mouse", "Keyboard", "USB"),
                      price = c(30000, 90000, 50000))
product

product <- data.frame()
product <- edit(product)

p <- readClipboard()
p
p <- read.table(file = "clipboard", sep="\t", header = TRUE)
p

mytxt <- "
id name price
A001 Mouse 30000
A002 Keyboard 90000
A003 USB 50000"
p <- read.table(text = mytxt, header = TRUE)
p

p <- read.csv(file="product.csv")
p

p <- read.csv("product-with-no-header.csv", header = FALSE)
p
p <- read.csv("product.csv", stringsAsFactors = FALSE)
str(p)

p <- read.table(file="product.txt")
p

read.table("product-colon.txt", sep=":", stringsAsFactors = FALSE)
read.table("product-missing.txt", header = TRUE, na.strings = ".")

brand.eval <- read.table("brand-eval.csv", header = TRUE, row.names = "BrandID", sep=",")
brand.eval
str(brand.eval)

brand.eval <- read.table("brand-eval.csv", header = TRUE,
                         row.names = "BrandID", sep=",",
                         colClasses = c("character","character",
                                        "numeric","numeric", "numeric"))
brand.eval

read.fwf("product-fwf.txt", widths = c(4, -1, 10,8))
read.fwf("product-fwf.txt", widths = c(4, -1, 10,8), col.names = c("id","name","price"))

readLines(con="won-dollar.txt", n=2)
scan("won-dollar.txt", what=list(date=character(0), buy=numeric(0), sell=numeric(0)))

library(openxlsx)
read.xlsx(xlsxFile = "product.xlsx", sheet = 1)

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris.UCI <- read.csv(url, header = FALSE)
head(iris.UCI)

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
local.copy <- "iris.csv"
download.file(url=url, destfile = local.copy)
iris.UCI <- read.csv(local.copy, header = FALSE)
head(iris.UCI)

url <- "http://seanlahman.com/files/database/baseballdatabank-master_2018-03-28.zip"
local.copy <- "lahman2017.zip"
download.file(url, local.copy)
baseball.salary <- read.csv(unzip(zipfile = local.copy, "baseballdatabank-master/core/Salaries.csv"))
head(baseball.salary)

library("audio")
url <- "http://www.happybirthdaymusic.info/01_happy_birthday_song.wav"
local.copy <- tempfile()
download.file(url, local.copy, mode = "wb")
hbday <- load.wave(local.copy)
unlink(local.copy)
play(hbday)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep = "|", header = TRUE, stringsAsFactors = FALSE)
str(npower)

npower$ReportDt <- as.Date(npower$ReportDt, format = "%m/%d/%Y")
head(npower); tail(npower)

library(lattice)
some <- npower[npower$Unit==as.character(unique(npower$Unit)[1:12]),]
xyplot(Power ~ ReportDt | Unit, data=some,
       type="l", col.line="black", xlab = "Time", ylab = "Power")

cloud.seeding <- scan("http://lib.stat.cmu.edu/datasets/cloud", 
                      skip=15,
                      nlines = 108,
                      what = list(period=character(0),
                                  seeded=character(0),
                                  season=character(0),
                                  te=numeric(0),
                                  tw=numeric(0),
                                  nc=numeric(0),
                                  sc=numeric(0),
                                  nwc=numeric(0)))

str(cloud.seeding)
cloud.seeding
cloud.seeding <- as.data.frame(cloud.seeding)
cloud.seeding

summary(cloud.seeding[4:8])

url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- readLines(url)
html[1:5]
pattern <- "<.*?>"
text <- gsub(pattern, "", html)
length(text)
text[1:5]
cat(paste(text, collapse = "\n"))

library(RCurl)
url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- getURL(url)
str(html)
length(html)
cat(html)

library(XML)
html.parsed <- htmlParse(html)
str(html.parsed)
html.parsed

html.node <- xpathSApply(doc=html.parsed, path = "//p")
str(html.node)
html.node

html.node[[2]]

text <- xmlValue(html.node[[2]])
str(text)
text
cat(text)

library(XML)
url <- "http://www.nationmaster.com/country-info/stats/Cost-of-living/Average-monthly-disposable-salary/After-tax"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(doc=html.parsed, stringAsFactors=FALSE)

str(html.tab)
length(html.tab)

head(html.tab[[1]])
salary <- html.tab[[1]]
str(salary)

salary <- salary[,-5]
salary$AMOUNT <- sapply(salary[,3], function(x) gsub(",","",as.character(x)))
salary$AMOUNT <- as.numeric(substring(salary$AMOUNT, 2))
str(salary)
head(salary)
summary(salary$AMOUNT)

library(XML)
url <- "http://news.bbc.co.uk/2/hi/uk_politics/8044207.stm"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(html.parsed, stringAsFactors=FALSE)
str(html.tab)
length(html.tab)
head(html.tab[[1]])
tail(html.tab[[1]])

head(html.tab[[5]])[,c(1:2, 14)]
tail(html.tab[[5]])[,c(1:2, 14)]

first <- "Abbott, Ms Diane"
last <- "157,841"
for(i in 1:length(html.tab)){
  lastrow <- nrow(html.tab[[i]])
  lastcol <- ncol(html.tab[[i]])
  if(!is.null(lastrow)){
    if(as.character(html.tab[[i]][1,1])==first &
       as.character(html.tab[[i]][lastrow, lastcol])==last)
    {tabi <- i}
  }
}
tabi
summary(expense.mps$Total)
