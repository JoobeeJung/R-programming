product <- data.frame()
product <- edit(product)
p <- readClipboard()
p
p<- read.table(file="clipboard",sep= "\t", header = TRUE)
p
mytxt <- "
id name price
A001 Mouse 30000
A002 Keyboard 900000
A003 USB 50000"
p <- read.table(text=mytxt, header=TRUE)
p
p <- read.csv("product.csv")
p
p <- read.csv("product.csv", stringsAsFactors = FALSE)
read.table("product-missing.txt", header = TRUE)

brand.eval <- read.table("brand-eval.csv",rt="C:\Users\Administrator\Desktop\7", header=TRUE, row.names="BrandID",sep=",")
read.fwf(file = "product-fwf.txt", widths = c(4,-1,10,8))
read.fwf("product-fwf.txt",widths = c(4,-1,10,8), col.names = c("id","name","price"))

readLines(con="won-dollar.txt", n=2)
scan("won-dollar.txt", what=character(0))
scan("won-dollar.txt", what=list(character(0),numeric(0),numeric(0)))

install.packages("openxlsx")
library(openxlsx)     
library()
library(openxlsx)
read.xlsx("product.xlsx", sheet=1)

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris.UCI <- read.csv(url, header = FALSE)
head(iris.UCI)

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data" 
local.copy <- "iris.csv"
download.file(url=url, destfile = local.copy)
iris.UCI <- read.csv(local.copy, header = FALSE)
head(iris.UCI)

url <- "http://seanlahman.com/files/database/baseballdatabank-master_2018-03-28.zip"
local.copy <- "lahman2018.zip"
download.file(url, local.copy)
baseball.salary <- read.csv(unzip(zipfile=local.copy, "baseballdatabank-master/core/Salaries.csv"))
head(baseball.salary); tail(baseball.salary)

install.packages("audio")
library("audio")
url <- "http://www.happybirthdaymusic.info/01_happy_birthday_song.wav"
local.copy <- tempfile()
download.file(url, local.copy, mode="wb")
hbday <- load.wave(local.copy)
unlink(local.copy)
play(hbday)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep="|", header = TRUE, stringsAsFactors = FALSE)
str(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format = "%m/%d/%Y")
head(npower); tail(npower);
library(lattice)
some <- npower[npower$Unit==as.character(unique(npower$Unit)[1:12]),]
windows(width=7.0, height=5.5)
xyplot(power ~ ReportDt | Unit, data=some,
       type="l",col.line="black", xlab="Time", ylab="Power")

cloud.seeding <- scan("http://lib.stat.cmu.edu/datasets/cloud", skip= 15, nlines = 108, 
                      what = list(period=character(0),
                                  seeded=character(0),
                                  season=character(0),
                                  te=numeric(0),
                                  tw=numeric (0),
                                  nc=numeric(0),
                                  sc=numeric(0),
                                  nwc=numeric(0)))

url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- readLines(url)
html
html[1:5]
pattern <- "<.*?>" #태그 제거하는 방법 *는 0또는 여러개를 의미 
text <- gsub(pattern,"",html) #패턴을 찾아서 대체하는 함수
html
text
text[1:5]
cat(paste(text, collapse="\n"))
text

install.packages("RCurl")
library(RCurl)
url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- getURL(url)
str(html)
length(html)
cat(html)

install.packages("XML")
library(XML)
html.parsed <- htmlParse(html)
str(html.parsed)
html.parsed
html.node <- xpathApply(doc = html.parsed, path = "//p")
str(html.node)
html.node
html.node[[2]]

text <- xmlValue(html.node[[2]])
text
cat(text)

url <- "http://www.nationmaster.com/country-info/stats/Cost-of-living/Average-monthly-disposable-salary/After-tax"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(doc=html.parsed,)