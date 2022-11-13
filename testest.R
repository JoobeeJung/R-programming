##1
x <- c(5:10)
x[c(1,2)] <-2:3
x
x[-1] <- 1:5
x

##2
mtcars$weight[mtcars$wt>median(mtcars$wt)] <- "heavy"
mtcars$weight[mtcars$wt<median(mtcars$wt)] <- "light"
head(mtcars)

##3
head(mtcars)
mtcars[,order(colnames(mtcars))]
head(mtcars[,order(colnames(mtcars))])

##4
##6
library(reshape2)
methods("sample")
sample_frac(iris, 0.7)
iris[sample(1:nrow(iris), 0.7*nrow(iris),replace = FALSE),]

##7
#a
names <- c("Gates","Jobs","Bezos")
lapply(names, nchar)
#b
sapply(names, nchar)
##8
lst1 <- list(A=matrix(1:12, nrow=3), B=matrix(1:12, nrow=2), C=1:12)
lst2 <- list(A=matrix(1:12, nrow=3), B=matrix(1:12, nrow=6), C=12:1)
mapply(identical, lst1,lst2)

##9
state.x77
apply(state.x77, 2, mean)
apply(state.x77, 2, sd)

##10
df <- data.frame(ID=c(1,1,2,2),Type=c("T1","T2","T1","T2"),X1=c(4,7,2,5),X2=c(3,6,4,1))
#a
library(reshape2)
df.long <- melt(df,id.vars = c("ID","Type"))
#b
df.wide <- dcast(df.long, formula =ID+Type ~ variable)
df.wide
df.wide2 <- dcast(df.long, ID + variable ~ Type)
df.wide2
df.wide3 <- dcast(df.long, ID ~ variable+Type)
df.wide3

##c
df.wide4 <- dcast(df.long, ID ~ variable, mean)
df.wide4
#2
df.wide5 <- dcast(df.long, Type~ variable, mean)
df.wide5
#3
df.wide6 <- dcast(df.long, ID ~ Type, mean)
df.wide6

##11
ChickWeight
head(ChickWeight)
#a
library(reshape2)
c.long <- melt(ChickWeight, id.vars = c("Time", "Chick", "Diet"))
c.long
head(c.long)
#b
c.wide <- dcast(c.long, Time+Chick+Diet ~ variable)
c.wide
head(c.wide)
#a
c.wide1 <- dcast(c.long, Time ~ variable, mean)
c.wide2  <- dcast(c.long, Diet ~ variable, mean)
c.wide2
head(c.wide2)


###################8
#1
for(month in month.name){
  cat("The month of",month,"\n")
}

#2
f.even <- function(x) x%%2==0
x <- c(-5:5, Inf, -Inf, NA, NaN)
f.even(x)
#3
c.even <- function(x){
  count <- 0
  for(val in x) 
    if(!is.na(val %%2 ==0) & (val%%2==0))
  count <- count+1
  return(count)
  }
c.even(x)

##3
count.even <- function(x){
  count <-0
  for(val in x)
    if(!is.na(val%%2==0) & (val%%2==0))
      count <- count+1
    return(count)
}
count.even(x)

##4
f.pi <- function(x){
  
  ifelse(x > pi,"A","B")}

c <- c(3, 1:5)
f.pi(3)
f.pi(1:5)
f.pi(c)

##5
f.sd <- function(x){
  x <- x[!is.na(x)]
    z <- (x-mean(x))/sd(x)
  return(z)
}
x <- c(1,2,3,4,5,NA)
f.sd(x)

##6
f.d <- function(x,i){
  gsub(i,"",x)
}
c <- "I saw her standing there; Misery; Anna (Go to him); Chains; Boys Ask me Why"
f.d(c,";")
##7
show.d <- function(x){
  if(is.data.frame(x) | is.matrix(x)){
  for(i in 1:ncol(x)) cat(colnames(x[i]),"is",class(x[,i]),"\n")}
  else cat("It is neither a data frame nor a matrix.","\n")
}
iris
show.d(iris)

##8
md <- function(x, med=FALSE){
  cat("Mean is",mean(x),", and Standard Deviation is",round(sd(x),1),"\b.\n")
  if(med==TRUE)
    cat("Also Median is",median(x),"\b.\n")
}
md(1:50)
md(1:50, med=TRUE)

##9
alice <- c("Alice", "was","beginning","to","get","very","tired","of",
           "sitting","by","her","sister","on","the","bank","and","of",
           "having","nothing","to","do","once","or","twice","she","had",
           "peeped","into","the","book","her","sister","was","reading",
           "but","it","had","no","pictures","or","conversations","in",
           "it","and","what","is","the","use","of","a","book","thought",
           "Alice","without","pictures","or","conversations")
af <- function(x){
  nchar.x <- nchar(x)
  for(i in min(nchar.x):max(nchar.x))
    {cat("These words have",i,"letter(s):\n")
  print(toString(unique(x[nchar.x==i])))
  }}
af(alice)

##10
remove.outlier <- function(x,remove=FALSE, b=2){
  x <- x[!is.na(x)]
  if(remove==FALSE) result <- mean(x)
  if(remove==TRUE) {
    outlier <- (x>(mean(x)+b*sd(x)) | x <(mean(x)-b*sd(x)))
    new.x <- x[!outlier]
    result <- mean(new.x)
  }
  return(result)
}
cars
install.packages("cars")
Salaries$salary
library(car)
remove.outlier(Salaries$salary)

##########################
r <- data.frame(KPL=c(21.0,18.2,14.8,14.7,14.0,13.8,10.9,10.6,10.5,9.7,9.2),
                model=c(rep("A",2),rep("B",4),rep("C",3),rep("D",2)))
r                

mean(r$KPL)

format(pi, digits=20)

#
url <-"http://www.statsci.org/data/general/cherry.txt"
cherry <- read.table(url,header = TRUE)
class(cherry)
head(cherry)
#b
str(cherry)
mean(cherry$Height)
##
url <- "http://www.statsci.org/data/general/flicker.txt"
#a
f <- read.table(url,header = TRUE,stringsAsFactors = FALSE)
f
head(f)
str(f)
class(f)
#b
mean()
a <- as.vector(unlist(subset(f,select = "Flicker", subset = (Colour=="Brown"))))
mean(a)

##5
url <- "https://www.itl.nist.gov/div898/strd/univ/data/PiDigits.dat"
u <- readLines(url)
head(u)
a <- read.table(url,header = FALSE,skip=60)
head(a)
str(a)
#b
table(a)/nrow(a)

##6
url <- "https://ww2.amstat.org/publications/jse/datasets/draft70mn.dat.txt"
form <- read.fwf(url,widths = c(-1,rep(c(-1,3),12)), n=31)
str(form)
#b
colnames(form) <- month.abb
head(form)
#d
form$day <- c(1:31)
head(form)
form[,c(13,1:12)]
#d
form[29,3]
median(as.vector(unlist(form[2:13])))
form$Feb[29]
median(form$Jan,na.rm = FALSE)
median(form$Dec, na.rm=FALSE)

#7
library(openxlsx)
library(XML)
url <- "http://www.airkorea.or.kr/file/download/?atch_id=71690"
local.copy <- "airquality.zip"
download.file(url, destfile = local.copy,mode="wb")
air <- read.xlsx(unzip(local.copy,"2017斥 3盒扁.xlsx"),sheet=1)
head(air)
str(air)
#2
mean(subset(air,select=air$PM10,subset = (air$螟沥家疙=="己合备")))
mean(subset(air, subset = (螟沥家疙=="己合备"))$PM10, na.rm=TRUE)

s <- air[air$螟沥家疙=="己合备",]$PM10
s
str(s)
mean(s, na.rm=TRUE)


##8
url <- "http://tycho.usno.navy.mil/timer.pl.kr"
readLines(url)
html <- getURL(url)
html.parsed <- htmlParse(u)
readHTMLTable(html.parsed)
library(RCurl)
cat(html)
html.node <- xpathSApply(html.parsed,"//pre")
html.node <- html.node[[1]]

url <-"http://tycho.usno.navy.mil/timer.pl.kr"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
cat(html)
html.parsed


###################33
url <- "http://tycho.usno.navy.mil/timer.pl.kr"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
html.node <- xpathSApply(html.parsed,"//pre")
html.node <- html.node[[1]]
text <- xmlValue(html.node)
text <- strsplit(text,"\n")
text <- text[[1]][-1]
text <- strsplit(text,"\t+")
text
#############
url <- "http://tycho.usno.navy.mil/timer.pl.kr"
library(XML)
library(RCurl)
html <- getURL(url)
cat(html)
html.parsed <- htmlParse(html)
html.node <- xpathSApply(html.parsed,"//pre")
html.node <- html.node[[1]]
html.node <- xmlValue(html.node)
html.node
text <- strsplit(html.node, "\n")
text <- text[[1]][-1]
text <- strsplit(text,"\t+")
text

##9
url <- "http://loc.gov/rr/print/list/057_chron.html"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
html.tab[[4]]
str(html.tab)
presidents <- html.tab[[4]]
str(presidents)
head(presidents)
years <- strsplit(presidents$YEAR,"-")
years<- do.call(rbind,years)
years <- as.data.frame(years, stringsAsFactors = FALSE)
str(years)

#b
presidents$START <- as.numeric(years$V1)
presidents$END <- as.numeric(years$V2)
str(presidents)
#c
max(presidents$END-presidents$START)
a <- presidents[(presidents$END-presidents$START) == 8,]
subset(presidents, select = c("PRESIDENT","YEAR"),subset = (presidents$END-presidents$START) == 8)

##10
url <- "https://en.wikipedia.org/wiki/Heights_of_presidents_and_presidential_candidates_of_the_United_States"
library(XML)
library(RCurl)
html <- getURL(url)
cat(html)
html.parsed <- htmlParse(html)
html.tab <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
str(html.tab)
html.tab <- html.tab[[4]]
t <- html.tab
str(html.tab)

k <-html.tab[,c(1,4,7)]
t<- t[t$V1>=1948 & t$V1 <= 2016,]
t

###########
