product <- data.frame(id=c("A001", "A002","A003"),
                      name=c("Mouse","Keyboard","USB"),
                      price=c(30000, 90000, 50000))
product

product <- data.frame()
product

product <- edit(product)
fix(product)

p <- readClipboard()
p

p <- read.table(file = "clipboard", sep = "\t", header = TRUE)
p

p<- read.csv(file = "product.csv")
p

p  <- read.csv("product-with-no-header.csv", header = FALSE)
p

p<- read.csv("product.csv", stringsAsFactors = FALSE)
str(p)

p <- read.csv("product.csv", as.is = TRUE)

p <- read.table(file="product.txt")

p <- read.table("product.txt", header = TRUE)

?read.table()
?read.csv()

read.table("product-missing.txt", header = TRUE)
read.table("product-missing.txt", header = TRUE, na.strings = ".")
read.table("product-comment.txt", header = TRUE)

brand.eval <- read.table("brand-eval.csv", header = TRUE, row.names = "BrandID",sep=",",stringsAsFactors = FALSE)
brand.eval
str(brand.eval)
brand.eval <- read.table("brand-eval.csv", header = TRUE, row.names = "BrandID",sep=",",
                         colClasses = c("character","character","numeric","numeric","numeric"))
brand.eval
str(brand.eval)
read.fwf("product-fwf.txt", widths = c(4,-1,10,8))
readLines(con="won-dollar.txt",2)
scan("won-dollar.txt", what=character(0))
scan("won-dollar.txt", what=list(date=character(0),buy=numeric(0),sell=numeric(0)),nlines=2)

library(openxlsx)     
read.xlsx(xlsxFile="product.xlsx",sheet = 1)

###############웹###################
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris.UCI <- read.csv(url, header = FALSE)
head(iris.UCI)
local.copy <- "iris.csv"
download.file(url, destfile = local.copy)
iris.UCI <- read.csv(local.copy, header=FALSE)
head(iris.UCI)

url <- "http://seanlahman.com/files/database/baseballdatabank-master_2018-03-28.zip"
local.copy <- "lahman2018.zip"
download.file(url, local.copy)
baseball.salary <- read.csv(unzip(local.copy,"baseballdatabank-master/core/Salaries.csv"))
head(baseball.salary)

library("audio")
url <- "http://www.happybirthdaymusic.info/01_happy_birthday_song.wav"
local.copy <- tempfile()
download.file(url, local.copy)
hbday <- load.wave(local.copy)
unlink(local.copy)
play(hbday)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep="|", header=TRUE, stringsAsFactors = FALSE)
str(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format="%m/%d/%Y")
head(npower); tail(npower)

library(lattice)
some <- npower[npower$Unit == as.character(unique(npower$Unit)[1:12]),]
xyplot(Power ~ ReportDt | Unit, data = some,
       type="l", col.line="black", xlab="Time", ylab="Power")

cloud.seeding <- scan("http://lib.stat.cmu.edu/datasets/cloud",
                      skip=15,
                      nlines=108,
                      what=list(period=character(0),
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
colMeans(subset(cloud.seeding, select=c(te,tw),
                subset = (seeded=="S"& season=="AUTUMN")))
colMeans(subset(cloud.seeding, select=c(te,tw),
                subset = (seeded=="U" & season=="AUTUMN")))

url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- readLines(url)
html[1:5]
pattern <- "<.*?>"
text <-gsub(pattern, "", html)
length(text)
text[1:5]
cat(paste(text, collapse = "\n"))
text
td
child::td

library(RCurl)
url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- getURL(url)
str(html)
length(html)
cat(html)
?cat

library(XML)
html.parsed <- htmlParse(html)
str(html.parsed)
html.parsed
html.node <- xpathSApply(html.parsed, path="//p")
str(html.node)
html.node

html.node[[2]]

text <- xmlValue(html.node[[2]])
str(text)
text
cat(text)

text <- sapply(html.node, xmlValue)
text
str(text)
text[2]
text[4]
cat(paste(text, collapse = "\n"))

text <- xpathSApply(html.parsed, path = "//p", xmlValue)
text

text <- xpathSApply(html.parsed, path = "//text()", xmlValue)
text[1:10]
cat(paste(text, collapse = " "))

text <- xpathSApply(html.parsed, "//text()[not(ancestor::script)][not(ancestor::style)])[not(ancestor::noscript)][not(ancestor::form)]", xmlValue)

library(XML)
url <- "http://www.nationmaster.com/country-info/stats/Cost-of-living/Average-monthly-disposable-salary/After-tax"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors =FALSE)
str(html.tab)
length(html.tab)

head(html.tab[[1]])
salary <- html.tab[[1]]
str(salary)
salary <- readHTMLTable(html.parsed, which=1, stringsAsFactors=FALSE)
str(salary)

salary <- salary[-5]
salary$AMOUNT <- sapply(salary[,3], function(x) gsub(",", "", as.character(x)))
salary$AMOUNT <- as.numeric(substring(salary$AMOUNT, 2))
str(salary)
head(salary)
summary(salary$AMOUNT)

library(XML)
url <- "http://news.bbc.co.uk/2/hi/uk_politics/8044207.stm"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
str(html.tab)
length(html.tab)
head(html.tab[[3]])
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

head(html.tab[[tabi]])[,c(1:2, 14)]
tail(html.tab[[tabi]])[,c(1:2, 14)]
expense.mps <- html.tab[[tabi]]
head(expense.mps)[,c(1:2, 14)]

str(expense.mps)
money <- sapply(expense.mps[,-1:-3],
                function(x) as.numeric(gsub(",","", as.character(x))))
expense.mps <- cbind(expense.mps[,1:3], money)
str(expense.mps)

summary(expense.mps$Total)

library(quantmod)
ibm <- getSymbols(Symbols = "IBM", auto.assign = FALSE)
head(ibm)

library(WDI)
WDIsearch("gdp")[1:5,]
WDIsearch("gdp.*capita.*current")
WDIsearch("Unemployment, Total")

WDI(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"),
    start = 2005,end = 2014)

library(wbstats)
wbsearch("gdp.*capita.*current")
wbsearch("Unemployment, Total")

wb(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"),
   startdate = 2005, enddate = 2014)

wb.data <- wb(country = "KR",indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"),
              startdate = 2005, enddate = 2014)

wbsearch("crude oil")
library(lubridate)
crude.oil <- wb(indicator = c("CRUDE_DUBAI", "CRUDE_BRENT","CRUDE_WTI","CRUDE_PETRO"),
                startdate = "2011M01", enddate = "2015M12", freq = "M", POSIXct = TRUE)

cat("The square root of 3 is", sqrt(3), "\b.","\n")

name <- "Jenny"
cat("Hello",name,"\b.\n","\bIsn\'t it", "\t", "A LOVELY DAY?\n")

hero <- list("B", "S", "I")
cat(unlist(hero))

z <- c(0, 1.64, 1.96, 2.58)
ptbl <- data.frame(z, Lower=pnorm(-z), Upper=pnorm(z))
ptbl
print(ptbl, digits = 3)

prime <- c(2,3,5,6,11,13,17,19)
cat(prime, file="prime.txt", sep="\t", "\n")
con <- file("product-cat.txt", open="w")
cat(id, file=con, sep = "\t","\n")

fah <- readline("Fahrenheit? ")
fah <- as.numeric(fah)
print(paste("Fahrenheit =", fah))
cel <- (fah-32)/1.8
print(paste("Celsius =", cel))
Orange
write.csv(x=Orange, file="orange.csv", row.names = FALSE)

library(RODBC)
install.packages("RODBC")
saledb <- odbcConnect(dsn="Sale")
class(saledb)
odbcGetInfo(channel=saledb)
sqlTables(channel = saledb)

sa <- sqlFetch(channel=saledb, sqtable = "Orders")
str(sa)
sa$order_no <- as.character(sa$order_no)
head(sa)
names(sa)

sa <- sqlFetch(saledb, "Orders")
subset(sa,
       select=c("order_date", "customer_no", "product_no", "amount"),
       subset=(sa$amount >= 5000000))

sqlQuery(channel=saledb,
         query="SELECT order_date, customer_no, product_no, amount
         From Orders WHERE amount >= 5000000")
sqlQuery(saledb, "SELECT customer_no, grade, sex, age 
          FROM Customer WHERE grade= 'VIP등급'", max=10)
sqlGetResults(saledb)
odbcClose(channel=saledb)

install.packages("RSQLite")
library(RSQLite)
drv <- dbDriver("SQLite")
class(drv)
saledb <- dbConnect(drv, "Sale.sqlite")
saledb <- dbConnect(SQLite(), "Sale.sqlite")
dbListTables(conn=saledb)
dbListFields(saledb, "Customer")
irisdb <- dbConnect(SQLite(), "iris.sqlite")
list.files(pattern="iris.sqlite")
dbWriteTable(conn=irisdb, name="iristable", value = iris)
dbDisconnect(irisdb)

#1
a <- c(21.0, 18.2)
b <- c(14.8, 14.7, 14.0, 13.8)
c <- c(10.9, 10.6, 10.5)
d <- c(9.7, 9.2)
KPL <- c(21.0, 18.2,14.8, 14.7, 14.0, 13.8,10.9, 10.6, 10.5,9.7, 9.2 )
KPL
class(KPL)
#a <- as.data.frame(a)
#b <- as.data.frame(b)
#c <- as.data.frame(c)
#d <- as.data.frame(d)
#str(x)
#data.frame("A"=c(21.0, 18.2), "B"=c(14.8, 14.7, 14.0, 13.8), )
x <- paste(a,b,c,d)
data.frame(x)
KPL <- c(a,b,c,d)
KPL
model <- c(rep("A",2),rep("B",4),rep("C",3),rep("D",2))
data.frame(KPL, model)
mean(KPL)

##2
pi
format(pi, digits = 20)

##3
#a
url <- "http://www.statsci.org/data/general/cherry.txt"
cherry <- read.table(url, header = TRUE)
cherry <- as.data.frame(cherry, stringsAsFactors = FALSE)
cherry
str(cherry)
#b
colMeans(cherry[2])

##4
url <- "http://www.statsci.org/data/general/flicker.txt"
flicker <- read.table(url, header = TRUE )
flicker <- as.data.frame(flicker)
#b
class(flicker)
head(flicker)
colMeans(flicker[1:8,][2])

##5
url <- "https://www.itl.nist.gov/div898/strd/univ/data/PiDigits.dat"
PiDigits <- scan(url, skip = 60)
PiDigits <- as.data.frame(PiDigits)
head(url)
str(PiDigits)
unique(PiDigits)
table(PiDigits)/5000

##6
url <- "http://ww2.amstat.org/publications/jse/datasets/draft70mn.dat.txt"
d <- read.fwf(url, n=31)
d <- as.data.frame(d)
str(d)
#b
colnames(d) <- month.abb[12]
d
head(d)
#c

##7
library(openxlsx)
url <- "http://www.airkorea.or.kr/file/download/?atch_id=71690"
local.copy <- "air.zip"
download.file(url, destfile=local.copy, mode="wb")
#air <- read.xlsx(unzip(zipfile=local.copy, "2017년 1분기.xlsx"), sheet=1)
air <- read.xlsx(unzip(zipfile = local.copy, "2017년 1분기.xlsx"), sheet=1)

##8
url <- "http://tycho.usno.navy.mil/timer.pl"
library(RCurl)
html <- getURL(url)
cat(html)
library(XML)
html.parsed <- htmlParse(html)
html.node <- xpathApply(html.parsed, "//pre")
html.node
text <- xmlValue(html.node[[1]])
text
text <- strsplit(text, "\n")
text <- text[[1]][-1]

clock <- strsplit(text,"\t")
clock
#????????????????????????????????????

##9
url <- "http://www.loc.gov/rr/print/list/057_chron.html"
library(RCurl)
html <- getURL(url)
cat(html)
library(XML)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
str(html.tab)

presidents <- html.tab[[4]]
str(presidents)
head(presidents,2)

##10
url <- "https://en.wikipedia.org/wiki/Heights_of_presidents_and_presidential_candidates_of_the_United_States"
html <- getURL(url)
cat(html)
html.tab <- readHTMLTable(html.parsed, stringsAsFactprs=FALSE)
str(html.tab)
