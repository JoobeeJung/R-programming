mode(1.414)
mode(c(1.414, 1.732))
mode("Batman")
mode(c("Batman","Superman","Spiderman"))
mode(factor("High","Medium","Low"))
mode(as.Date("2020-12-31"))

d <- as.Date("2020-12-31")
mode(d)
length(d)
as.integer(d)
class(d)
d +1

as.numeric(1.618)
as.integer(1.618)
as.character(1.618)
as.numeric("gold")

as.numeric(c("-1","1.618","3.14"))
as.numeric(FALSE)
as.numeric(TRUE)

logical.v <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
sum(logical.v)
days.of.months <- c(31, 28, 31, 30, 31, 31, 31, 30, 31, 30, 31)
sum(days.of.months > 30)

vec <- 1:6
as.list(vec)
list(vec)
vec <- 1:6
cbind(vec)
as.matrix(vec)
rbind(vec)

matrix(vec, 2, 3)
vec <- 1:6
as.data.frame(vec)
as.data.frame(rbind(vec))

mat <- matrix(1:6, 3, 2)
mat
as.vector(mat)
as.list(mat)
as.data.frame(mat)

lst <- list(odd=c(1,3,5), even=c(2,4,6))
lst 
unlist(lst)
as.vector(lst)
identical(lst, as.vector(lst))
lst2 <- list(odd=c(1,3,5), even=c("two","four","six"))
lst2
unlist(lst2)

lst <- list(odd=c(1,3,5), even=c(2,4,6))
matrix(unlist(lst),3,2)
matrix(unlist(lst), 3, 2, dimnames=list(NULL, names(lst)))
matrix(lst)
as.matrix(lst)

lst2 <- list(odd=c(1,3,5), even=c("two", "four", "six"))
as.data.frame(lst2)
str(as.data.frame(lst2)$odd)
str(as.data.frame(lst2)$even)

dfm <- data.frame(odd=c(1,3,5), even=c(2,4,6))
dfm
str(dfm[1,])
dfm[,1]
str(dfm[,1])
dfm[[1]]
str(dfm[[1]])

dfm <- data.frame(odd=c(1,3,5), even=c(2,4,6))
as.vector(as.matrix(dfm))

dfm <- data.frame(odd=c(1,3,5), even=c(2,4,6))
as.vector(as.matrix(dfm))
dfm2 <- data.frame(odd=c(1,3,5), even=c("two","four","six"))
as.vector(as.matrix(dfm2))

dfm <- data.frame(odd=c(1,3,5), even=c(2,4,6))
as.matrix(dfm)
dfm2 <- data.frame(odd=c(1,3,5), even=c("two","four","six"))
as.matrix(dfm2)

url <- "https://finance.yahoo.com/quote/005930.KS/history?period1=1524409200&period2=1524754800&interval=1d&filter=history&frequency=1d"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
price.table <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
price.table <- price.table[[2]]
price.table

Sys.setlocale("LC_TIME","English")
price.table$Date <- as.Date(price.table$Date, format = "%b %d, %Y")
Sys.setlocale()
number <- sapply(price.table[,-1], function(x) as.numeric(gsub(",","",x)))
price.table <- cbind(price.table[1], as.data.frame(number))
price.table

period <- c("2018-04-23", "2018-04-27")
as.integer(as.POSIXct(paste(period,"000000"), format="%Y-%m-%d %H%M%S"))

getPrices <- function(symbol,
                      from=Sys.Date()-30,
                      to=Sys.Date(),
                      interval="id"){
  library(XML)
  library(RCurl)
  head <- "https://finance.yahoo.com/quote"
  stock <- paste0(symbol, "/history?")
  period1 <- paste0("period1=",
                   as.integer(as.POSIXct(paste(from, "000000"),
                                         format="%Y-%m-%d %H%M%S")), "&")
  period2 <- paste0("period2=",
                    as.integer(as.POSIXct(paste(to, "000000"),
                                          format="%Y-%m-%d %H%M%S")),"&")
  interval <- paste0("interval=", interval, "&filter=history&frequency", interval)
  url <- paste0(head, stock, period1, period2, interval)
  html <- getURL(url)
  html.parsed <- htmlParse(html)
  price.table <- readHTMLTable(html.parsed, which=2, stringsAsFactors=FALSE)
  price.table <- cbind(symbol=symbol, price.table, stringsAsFactors=FALSE)
  Sys.setlocale("LC_TIME", "English")
  price.table$Date <- as.Date(price.table$Date, format = "%b %d, %Y")
  Sys.setlocale()
  number <- sapply(price.table[-c(1,2)], function(x) as.numeric(gsub(",","", x)))
  cbind(price.table[c(1,2)], as.data.frame(number))
}

getPrices("005930.KS")

getMultiplePrices <- function(symbols,
                              from=Sys.Date()-30,
                              to=Sys.Date(),
                              interval="id"){
  prices.table <- NULL
  for(symbol in symbols){
    if(is.null(symbol))
      prices.table <- getPrices(symbol, from, to, interval)
    else
      prices.table <- rbind(prices.table, getPrices(symbol, from, to , interval()))
  }
  return(prices.table)
}
symbols <- c("005930.KS", "017670.KS", "005387.KS")
getMultiplePrices(symbols)

vec <- c(10,9,8,7,6,5,4,3,2,1)
match(7, vec)
match(c(11,9,8,7,0), vec)

head(mtcars)
car <- mtcars
car$name <- row.names(car)
row.names(car) <- NULL
head(car)

highhp.car <- car[car$hp > 145,]
highhp.car
lightwt.car <- car[car$wt < 3.2,]
lightwt.car

index <- match(highhp.car$name, lightwt.car$name)
index

lightwt.car[na.omit(index),]
vec <- c(10,9,8,7,6,5,4,3,2,1)
7 %in%vec
c(11,9,8,7,0) %in% vec

match(c(11,9,8,7,0), vec)
!is.na(match(c(11,9,8,7,0), vec))

index <- highhp.car$name %in% lightwt.car$name
index

highhp.car[index,]

str(mtcars)
mtcars$mpg
mtcars[[1]]
mtcars[c(1,4)]
mtcars[c("mpg","hp")]
mtcars[-c(2,3,5,7:11)]
mtcars[-1]
mtcars[1] <- NULL
mtcars[c(-1,2)]
str(iris)
iris[1:5,]
iris[,c("Sepal.Length", "Sepal.Width")]
iris[,"Sepal.Length"]
iris[, "Sepal.Length", drop=FALSE]
iris["Sepal.Length"]
iris[1:5, c("Sepal.Length", "Sepal.Width")]
iris[iris$Sepal.Length >7,]

iris[iris$Sepal.Length >7, c("Sepal.Width", "Sepal.Length", "Species")]
subset(iris, select=c("Sepal.Width", "Sepal.Length", "Species"),
       subset= (Sepal.Length > 7))
sample(x=1:10, size=5)
sample(x=10, size=5)
sample(1:10, 5, replace=TRUE)
sample(1:10)
set.seed(1)
sample(1:10, 5, replace = TRUE)
sample(iris,3)
set.seed(1)
index <- sample(1:nrow(iris),3)
index
iris[index,]
duplicated(c(1,2,3,1,1,4,3))
id <- c("A001","A002","A003")
name <- c("Mouse", "Keyboard","USB")
price <- c(30000, 90000, 50000)
product <- data.frame(id=id, name=name, price=price)
product

product <- rbind(product, c("A001","Mouse",30000))
product

duplicated(product)
product.unique <- product[!duplicated(product),]
product.unique

which(duplicated(product))
index <- which(duplicated(product))
product.unique <- product[-index,]
product.unique

unique(product)
str(airquality)

complete.cases(airquality)
airquality.nona <- airquality[complete.cases(airquality),]
str(airquality.nona)
airquality.nona <- na.omit(airquality)

cut(x=iris$Sepal.Width, breaks = c(0,1,2,3,4,5))
iris.cut1 <- cut(iris$Sepal.Width, breaks = c(0,1,2,3,4,5))
table(iris.cut1)
summary(iris.cut1)

cut(iris$Sepal.Width,
    breaks = c(0,1,2,3,4,5),
    labels = c("Smaller","Small","Medium","Big", "Bigger"))
iris.cut2 <- cut(iris.cut2)
summary(iris.cut1)
cut(iris$Sepal.Width,
    breaks = c(0,1,2,3,4,5),
    labels = c("Smaller","Small","Medium","Big","Bigger"))

iris.cut2 <- cut(iris$Sepal.Width,
                 breaks = c(0,1,2,3,4,5),
                 labels = c("Smaller","Small","Medium","Big","Bigger"))
table(iris.cut2)
summary(iris.cut2)
cut(iris$Sepal.Width, breaks = 5, include.lowest = TRUE)
iris.cut3 <- cut(iris$Sepal.Width,
                 breaks = 5,
                 labels = c("Smaller","Small","Medium","Big","Bigger"),
                 include.lowest = TRUE)
table(iris.cut3)
summary(iris.cut3)

x <- c(3,7,5,1,2,5)
sort(x)

x <- c(3,7,5,1,2,5)
sort(x, decreasing = TRUE)

x <- c(3,7,5,1,2,5)
length(x)
length(x) <- 7
sort(x)
sort(x, na.last = TRUE)
sort(x, na.last = FALSE)

y <- c(11,22,33,55,44)

order(y)
y[order(y)]

y <- c(11,22,33,55,44)
z <- c("Superman","batman","ironman","antman","spiderman")
df <- data.frame(y,z)
df

df[order(df$y),]
df[order(df$y, decreasing = TRUE),]

w <- c("can fly", "cannot fly", "can fly", "cannot fly", "cannot fly")
df <- data.frame(y,z,w)
df

df[order(df$w, df$y),]
xtfrm(df$w)
index <- order(-xtfrm(df$w), df$y)


##
url <- "https://finance.yahoo.com/quote/005930.KS/history?period1=1524409200&period2=1524754800&interval=1d&filter=history&frequency=1d"
library(XML)
library(RCurl)
html <- getURL(url)
html.parsed <- htmlParse(html)
price.table <- readHTMLTable(html.parsed, stringsAsFactors=FALSE)
price.table <- price.table[[2]]
price.table

Sys.setlocale("LC_TIME","English")
price.table$Date <- as.Date(price.table$Date, format="%b %d, %Y")
Sys.setlocale()
number <- sapply(price.table[-1], function(x) as.numeric(gsub(",","",x)))
price.table <- cbind(price.table[1], as.data.frame(number))
price.table

period <- c("2018-04-23", "2018-04-27")
as.integer(as.POSIXct(paste(period, "000000"), format="%Y-%m-%d %H%M%S"))


getPrices <- function(symbol, from=Sys.Date()-30, 
                      to=Sys.Date(), interval="1d"){
  library(XML)
  library(RCurl)
  head <- "https://finance.yahoo.com/quote/"
  stock <- paste0(symbol, "/history?")
  period1 <- paste0("period1=",
                  as.integer(as.POSIXct(paste(from, "000000"),
                                        format="%Y-%m-%d %H%M%S")),"&")
  period2 <- paste0("period2=",
                  as.integer(as.POSIXct(paste(from, "000000"),
                                        format="%Y-%m-%d %H%M%S")),"&")
  interval <- paste0("interval=",interval, "&filter=history&frequency=",interval)
  url <- paste0(head, stock, perio d1, period2, interval)
  html <- getURL(url)
  html.parsed <- htmlParse(html)
  price.table <- readHTMLTable(html.parsed, which=2, stringsAsFactors=FALSE)
  price.table <- cbind(Symbol=symbol, price.table, stringsAsFactors=FALSE)
  Sys.setlocale("LC_TIME","English")
  price.table$Date <- as.Date(price.table$Date, format = "%b %d, %Y")
  Sys.setlocale()
  number <- sapply(price.table[-c(1,2)], function(x) as.numeric(gsub(",","",x)))
  cbind(price.table[c(1,2)],as.data.frame(number))
  }

getPrices("005930.KS")

#####변수 변환

iris.copy <- iris
class(iris.copy$Species)
iris.copy$Species <- as.character(iris.copy$Species)
class(iris.copy$Species)

iris.copy$Sepal.Ratio <- iris.copy$Sepal.Length / iris.copy$Sepal.Length
head(iris.copy)

iris.copy <- iris
iris.trans <- transform(iris.copy,
                        Species=as.character(Species),
                        Sepal.Ratio = Sepal.Length/Sepal.Width)
class(iris.trans$Species)
head(iris.trans)

x <- 1:20
dim(x) <- c(4,5)
x

apply(X=x, MARGIN=1, FUN=max)
apply(x, 2, min)

y <- 1:24
dim(y) <- c(4,3,2)
y
apply(y, 1, paste,collapse=",")
apply(y, 2, paste,collapse=",")
apply(y, 3, paste,collapse=",")

apply(y, c(1,2), paste, collapse=",")
str(Titanic)
apply(Titanic,1,sum)
apply(Titanic, 2, sum)
apply(Titanic, 3, sum)
apply(Titanic, 4, sum)

apply(Titanic, c(1,4), sum)

exams <- list(s17=c(78,89,91,85,95,98),
              s18=c(85,86,97,99,90),
              s19=c(98,96,89,90,93,85,92),
              s20=c(98,96,91,88,93,99))
exams
lapply(exams, length)
sapply(exams, length)

sapply(exams,mean)
sapply(exams.sd)
sapply(exams, range)

lapply(iris, class)

library("level")

car <- mtcars

car <- within(car, am <- factor(am,levels=c(0,1),labels=c("Automatic", "Manual")))
g <- split(x=car$mpg, f=car$am)
g

mean(g[[1]])
mean(g[["Manual"]])
sapply(g, mean)

unstack(data.frame(car$mpg, car$am))

iris
gg <- unstack(data.frame(iris$Sepal.Length , iris$Species))
str(gg)
gg
summary(gg)

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species, length)

with(car, tapply(mpg, list(cyl,am), mean))
with(car, tapply(mpg, list(Cylinder=cyl, Transmission=am), mean))

aggregate(car[c(1:6)], list(Group.cyl=car$cyl, Group.am=car$am), mean)

aggregate(iris[1:4], list(Species=iris$Species), mean)
by(data=iris, INDICES=iris$Species, FUN=summary)

by(iris, iris$Species, function(x) mean(x$Sepal.Length))   

rowsum(x=iris[-5], group = iris$Species)

gear.counts <- tabulate(car$gear)
gear.counts
names(gear.counts) <- 1:length(gear.counts)
gear.counts

table(car$gear)
table(car$am)

table(car$am, car$gear)
mpg.cut <- cut(car$mpg, breaks=5, include.lowest = TRUE)
table(mpg.cut)

xtabs(~am + gear, car)
aggregate(formula=mpg ~ cyl + am, data=car, FUN = mean)

with(car, aggregate(mpg, list(cyl=cyl, am=am),mean))
?aggregate

library(dplyr)
head(airquality)

library(dplyr)
air <- filter(airquality, Month==6)
head(air)
airquality[airquality$Month==6,]
subset(airquality, subset = (Month==6))
head(air)
airquality[airquality$Month==6,]
subset(airquality, subset = (Month==6))
head(air)
air <- filter(airquality, Month==6, Temp>90)
air <- filter(airquality, Month==6 & Temp>90)
head(air)

air <- filter(airquality, Ozone >80 | Temp >90)
head(air)

slice(airquality, 6:10)

air <- arrange(airquality, Temp, Month, Day)
head(air)
air <- arrange(airquality, desc(Temp), Month, Day)
head(air)

airquality[order(airquality$Temp, airquality$Month, airquality$Day),]
airquality[order(desc(airquality$Temp), airquality$Month, airquality$Day),]

air <- select(airquality, Month, Day, Temp)
head(air)
air <- select(airquality, Temp:Day)
head(air)
air <- select(airquality, -(Ozone:Wind))
head(air)

air <- select(airquality, Solar=Solar.R)
head(air)

air <- rename(airquality, Solar=Solar.R)
head(air)
distinct(select(airquality, Month))
unique(airquality$Month)

air <- mutate(airquality, Temp.C=(Temp-32)/1.8, diff=Temp.C-mean(Temp.C))
head(air)

transform(airquality, Temp.C=(Temp-32)/1.8, Diff=Temp.C- mean(Temp.C))

air <- summarise(airquality, mean(Temp))
air
air <- summarise(airquality, Min=min(Temp, na.rm = TRUE),
                 Median = median(Temp, na.rm = TRUE),
                 Mean=mean(Temp, na.rm = TRUE),
                 SD= sd(Temp, na.rm = TRUE),
                 Max = max(Temp, na.rm = TRUE),
                 N=n(),
                 Distinct.Month=n_distinct(Month),
                 First.Month=first(Month),
                 Last.Month = last(Month)
                 )
air

sample_n(airquality, 5)
sample_frac(airquality, 0.05)

air.group <- group_by(airquality, Month)
class(air.group)
air.group
air.group.Temp <- summarise(air.group, Mean_Temp=mean(Temp, na.rm=TRUE))
air.group.Temp
air.group.Temp <- summarise(air.group, Number.of.Days=n(),
                            Mean.Temp=mean(Temp, na.rm = TRUE),
                            SD.Temp=sd(Temp, na.rm=TRUE))
air.group.Temp

iris %>% head
1:10 %>% mean

a1 <- select(airquality, Ozone, Temp, Month)
a2 <- group_by(a1, Month)
a3 <- summarise(a2, 
                Mean.Ozone=mean(Ozone, na.rm=TRUE),
                Mean.Temp=mean(Temp, na.rm=TRUE))
a4 <- filter(a3, Mean.Ozone > 40 | Mean.Temp > 80)
a4

air <- airquality %>%
  select(Ozone, Temp, Month) %>%
  group_by(Month) %>%
  summarise(Mean.Ozone = mean(Ozone, na.rm = TRUE),
            Mean.Temp=mean(Temp, na.rm = TRUE)) %>%
  filter(Mean.Ozone > 40 | Mean.Temp > 80)
air

library(Lahman)
str(Batting)
head(Batting)
Batting.tbl.df <- tbl_df(Batting)
Batting.tbl.df 
class(Batting.tbl.df)
Batting.df <- as.data.frame(Batting.tbl.df)
class(Batting.df)

library(reshape2)
smiths
smiths.long <- melt(data=smiths)
smiths.long
smiths.long <- melt(data=smiths, id.vars = "subject")
smiths.long

smiths.wide <- dcast(data = smiths.long, formula = subject ~ variable)
smiths.wide

str(airquality)
head(airquality)

aq.long <- melt(airquality)
head(aq.long)
aq.long <- melt(airquality, id.vars = c("Month","Day"))
head(aq.long)

aq.wide <- dcast(aq.long, Month+Day ~ variable)
aq.wide <- dcast(aq.long, Month+Day ~ variable, value.var = "value")
head(aq.wide)

dcast(aq.long, Month~variable, fun.aggregate = mean, na.rm=TRUE)
aq.long <- melt(airquality, 
                id.vars=c("Month","Day"),
                measure.vars = c("Ozone", "Solar.R", "Wind","Temp"),
                variable.name = "Factor",
                value.name = "Measurement")
head(aq.long)

aq.wide <- dcast(aq.long, Month + Day ~ Factor)
aq.wide <- dcast(aq.long, Month + Day ~ factor, value.var = "Measurement")
head(aq.wide)
head(airquality)
library(tidyr)
aq.long <- gather(data=airquality, key=Factor, value = Measurement, Ozone:Temp)
head(aq.long)

gather(airquality, Factor, Measurement, -Month, -Day)
gather(airquality, Factor, Measurement, 1:4)
gather(airquality, Factor, Measurement, Ozone, Solar.R, Wind, Temp)
airquality %>% gather(Factor, Measurement, Ozone:Temp)

aq.wide <- spread(data=aq.long, key = Factor, value=Measurement)
head(aq.wide)

aq.long %>% spread(Factor, Measurement)
head(iris)
iris.long <- gather(iris, Element, Measurement, -Species)
head(iris.long)

iris.sep <- separate(data=iris.long, col=Element, into=c("Part", "Measures"))
head(iris.sep)

iris.unite <- unite(data=iris.sep, col=Factor, Part, Measures, sep = "-")
head(iris.unite)

str(PlantGrowth)
PlantGrowth

plant.wide <- unstack(PlantGrowth)
plant.wide

plant.long <- stack(plant.wide)
plant.long

##1
 