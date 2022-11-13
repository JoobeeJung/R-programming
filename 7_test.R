##1
a <- data.frame(KPL=c(21.0,18.2,14.8,14.7,14.0,13.8,10.9,10.6,10.5,9.7,9.2),
                model=rep("A",2),rep("B",4),rep("C",3), rep("D",2))
a[1]
colMeans(a[1])
mean(a$KPL)

##2
pi
format(pi, digits = 20)

##3
#a
url <- "http://www.statsci.org/data/general/cherry.txt"
t <- read.table(url, header = TRUE, sep = "\t")
t
class(t)
#b
str(t)
mean(t$Height)

##4
#a
url <- "http://www.statsci.org/data/general/flicker.txt"
f <- read.table(url, header = TRUE, sep = "\t")
class(f)
str(f)
#b
mean(subset(f, subset =(Colour=="Brown"))$Flicker)
mean(f[1:8,]$Flicker)

##5
#a
url<-"https://www.itl.nist.gov/div898/strd/univ/data/PiDigits.dat"
p <- readLines(url, skip=60)
p <- read.table(url, skip=60)
head(p)
str(p)
#b
r <- table(p)
str(r)
class(r)
ratio <- r/length(p$V1)
ratio
length(p$V1)

##6
url <-"https://ww2.amstat.org/publications/jse/datasets/draft70mn.dat.txt"
#read.table(url, header = FALSE,sep=" ")
#s <- readLines(url)
#df <- as.data.frame(s)
#str(df)
#b
#class(df)
#names(df$s) <- c(month.abb[1:12])
#colnames(df)
#df
f <- read.fwf(url,widths=c(-1,rep(c(-1,3),12)),n=31)
f
str(f)         
#b
head(f)
colnames(f) <- month.abb
#c
f$day <- 1:31
f
median(c(f$Jan,f$Dec))
f$Feb[29]       
median(f$Jan)
median(f$Dec)

##7
url <- "http://www.airkorea.or.kr/file/download/?atch_id=71690"
read.xlsx()
local.copy <- "air.zip"
download.file(url, local.copy, mode="wb")
library(openxlsx)
aircon <- read.xlsx(unzip(zipfile=local.copy,"2017년 1분기.xlsx"),sheet=1)
str(aircon)
#b
head(aircon)
mean(aircon$PM10)
mean(subset(aircon, subset = (측정소명=="성북구"))$PM10, na.rm=TRUE)
mean(subset(aircon, subset = (측정소명=="종로구"))$PM10, na.rm=TRUE)

##8
url <-"http://tycho.usno.navy.mil/timer.pl.kr"
#readLines(url)
library(RCurl)
library(XML)
html <- getURL(url)
html.parsed <- htmlParse(html)
html.node <- xpathSApply(html.parsed,"//pre")
html.node[[1]]
a <- xmlValue(html.node[[1]])
str(a)

a <- strsplit(a, "\n")
a <- a[[1]][-1]
a <- as.vector(a)
clock <- strsplit(a, "\t+")
str(b)
clock

##9
url <-"http://loc.gov/rr/print/list/057_chron.html"
html.parsed <- htmlParse(url)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
str(html.tab)
presidents <- html.tab[[4]]
str(presidents)
presidents$START <- as.numeric(substr(presidents$YEAR,1,4),na.rm=TRUE)
presidents$END <- as.numeric(substr(presidents$YEAR,6,9),na.rm=TRUE)
str(presidents)
head(presidents)
max(presidents$END-presidents$START)
#c
table(presidents)
with(presidents,subset(presidents, select=c(YEAR, PRESIDENT), subset = (END-START) == max(END-START)))


years <- strsplit(presidents$YEAR, split = "-")
years <- do.call(rbind, years)
?do.call
years <- as.data.frame(years, stringsAsFactors = FALSE)
str(years)
years
names(years) <- c("START","END")
years$START <- as.numeric(years$START)
years$END <- as.numeric(years$END)

presidents <- cbind(presidents,years)
head(presidents)
presidents$END
with(presidents,subset(presidents, select=c(YEAR, PRESIDENT), subset=(YEAR$END-START)==max(END-START)))

##10
url <-"https://en.wikipedia.org/wiki/Heights_of_presidents_and_presidential_candidates_of_the_United_States"
html <- getURL(url)
html.parsed <- htmlParse(html)
html.tab <- readHTMLTable(html.parsed,stringsAsFactors=FALSE)
str(html.tab)
h <- html.tab[[4]]
str(h)
h$V1 <- as.numeric(h$V1)
h <- h[h$V1>=1948 & h$V1<=2016, c(1,4,7)]
h
head(h)
names(h) <-c("election.year", "winner", "opponent")
h$winner <- as.numeric(substr(h$winner, 1,3))
h$opponent <- as.numeric(substr(h$opponent, 1,3))
h$difference <- h$winner-h$opponent
str(h)
head(h)
h
#b
mean(h$difference)

#c
table(h)
length(h)
w <- h(h$difference>0,value=TRUE)
r <- sum(h$difference>0)
r/18 * 100
