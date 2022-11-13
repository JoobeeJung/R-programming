x <- "We have a dream"
nchar(x)
length(x)

y <- c("We","have","a","dream")
nchar(y)
length(y)

letters
LETTERS
sort(letters, decreasing=TRUE)

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x=fox.said, split = " ")

fox.said.word <- unlist(strsplit(fox.said, " "))
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words[3]

p1 <- "You come at four in the afternoon, then at three I shall begin to be happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
littleprince <- c(p1,p2,p3)
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]]
strsplit(littleprince, " ")[[3]][5]

fox.said <- "WHAT IS ESSENTIAL is invisible to the Eye"
fox.said.words <- strsplit(fox.said, " ")[[1]]

unique(fox.said.words)
unique(tolower(fox.said.words))

paste("Everybody","wants","to","fly")
paste(c("Everybody","wants","to","fly"))

fox.said <- "WHAT IS ESSENTIAL is invisible to the Eye"
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words
paste(fox.said.words)
paste("Everybody","wants","to","fly",sep="-")
paste(c("Everybody","wants","to","fly"),sep="-")
paste("Everybody","wants","to","fly",sep="")
paste(pi,sqrt(pi))
paste("25 degrees Celsius is", 25*1.8 + 32, "degrees Fahrenheit")

heroes <- c("Bathman","Captain America", "Hulk")
colors <- c("Black", "Blue", "Green")
paste(colors, heroes)

paste("Type", 1:5)
heroes
paste(heroes, "wants", "to", "fly")

paste(c("Everybody","wants","to","fly"))
paste(c("Everybody","wants","to","fly"), collapse = " ")
paste(heroes, "wants","to","fly",collapse = ", and ")

paste(heroes, "wants", "to", "fly", sep="_", collapse = "; ")
paste(month.abb, 1:12, sep="_", collapse = "-")
outer(c(1,2,3),c(3,2,1))

asian.countries <- c("Korea", "China", "Japan")
info <- c("GDP", "Popluation", "Area")
out <- outer(asian.countries, info, FUN=paste, sep="-")
as.vector(out)

outer(asian.countries, asian.countries, paste, sep="-")
x <- outer(asian.countries, asian.countries, paste, sep="-")
x[!lower.tri(x)]
customer <- "Jobs"
buysize <- 10
deliveryday <- 3
paste("Hello ",customer, ",your order of ", buysize,
      " product(s) will be delivered within ", deliveryday, " day(s).", sep="")

sprintf("Hello %s, your order of %s product(s) will be delivered within %s days",
        customer, buysize, deliveryday)
customers <- c("Jobs", "Gates", "Bezos")
buysizes <- c(10, 7, 12)
deliverydays <- c(3, 2, 7.5)
sprintf("Hello %s, your order of %s product(s) will be delivered within %s days",
        customers, buysizes, deliverydays)
sprintf("Hello %s, your order of %s product(s) will be delivered within %.1f days",
        customers, buysizes, deliverydays)

substr("Data Analytics", start=1, stop=4)
substr("Data Analytics", 6, 14)
substring("Data Analytics", 6)

class <- c("Data Analytics", "Data Mining", "Data Visualization")
substr(class, 1, 4)
countries <- c("Korea, KR", "United States, US", "China, CN")
substr(countries, nchar(countries)-1,  nchar(countries))

head(islands)
landmasses<- names(islands)
landmasses
index <- grep(pattern = "New", landmasses)
landmasses[index]

grep("New", landmasses, value = TRUE)

landmasses[grep(" ", landmasses)]
grep(" ", landmasses, value = TRUE)

txt <- "Data Analytics is useful. Data Analytics is also interesting"
sub(pattern="Data", replacement="Business", x=txt)
gsub("Data", "Business", txt)

x <- c("product.csv", "customer.csv", "supplier.csv")
gsub(".csv", "", x)

words <- c("at", "bat", "cat", "chaenomeles", "chase", "chasse",
           "cheap", "check", "cheese", "chick", "hat")
grep("che",words, value = TRUE)
grep("at", words, value = TRUE)

grep("[che]",words, value = TRUE)
grep("[at]", words, value = TRUE)
grep("ch|at", words, value = TRUE)
grep("ch(e|i)ck", words, value = TRUE)
grep("chas?e", words, value = TRUE)
grep("chas*e", words, value = TRUE)
grep("chas+e", words, value = TRUE)
grep("ch(a*|e*)se", words, value = TRUE)
grep("^c", words, value = TRUE)
grep("t$", words, value= TRUE)
grep("^c.*t$", words, value = TRUE)

words2 <- c("12 Dec", "OK", "http://", "<TITLE>Time?</TITLE>","12345","Hi there")
grep("[[:alnum:]]", words2, value = TRUE)
grep("[[:alpha:]]", words2, value = TRUE)
grep("\\w", words2, value = TRUE)
grep("\\d", words2, value = TRUE)
grep("\\s", words2, value = TRUE)

Sys.Date()
date()
Sys.time()
class(Sys.Date())
as.Date("2020-12-31")
as.Date("12/31/2020")
as.Date("12/31/2020", format="%m/%d/%Y")

d <- as.Date("2020-12-31")
format(d, format="%m/%d/%Y")

today <- Sys.Date()
today
format(today, format="%Y/%m/%d %A")

d <- as.Date("2020-12-31")
weekdays(d)
weekdays(d + 1:7)

start <- as.Date("2021-01-01")
end <- as.Date("2021-01-31")
seq(from=start, to=end, by = 1)

seq(from=start, by=1, length.out = 7)
seq(from=start, by="7 days", length.out = 9)
seq(from=start, by="week", length.out = 12)
seq(from=start, by="month", length.out = 4)
seq(from=start, by="year", length.out = 10)

seq(from=as.Date("2020-01-30"), by="month", length.out = 6)

start <- as.Date("2020-01-01")
qrt <- seq(from=start, by="3 months", length.out = 4)
months(qrt)
quarters(qrt)
?quarters
Sys.getlocale()
Sys.setlocale("LC_TIME", "C")
months(qrt)
Sys.setlocale("LC_TIME", "Korean_Korea.949")
months(qrt)

pct <- as.POSIXct("2020/03/15, 15:03:04", format="%Y/%m/%d, %H:%M:%S")
pct
class(pct)
as.integer(pct)

plt <- as.POSIXlt("2020/03/15, 15:03:04", format="%Y/%m/%d, %H:%M:%S")
plt
class(plt)
as.integer(plt)
unclass(plt)

plt$mday
plt$mon
plt$year
plt$wday
plt$hour

dposix <- as.Date("2020-12-31")
dposix
as.POSIXlt(dposix)$wday
as.POSIXlt(dposix)$yday
as.POSIXlt(dposix)$year + 1900
as.POSIXlt(dposix)$mon + 1

strptime("2020-12-31", format="%Y-%m-%d")
class(strptime("2020-12-31", format = "%Y-%m-%d"))
strptime("2020-12-31", format = "%Y -%m- %d")$year + 1900
dates <- c("05/05/81", "06/06/92", "08/15/03", "10/03/14", "12/25/25")
times <- c("22:05:19", "20:29:46", "05:03:30", "17:11:05", "15:36:25")
dt <- paste(dates,times)
strptime(dt, "%m/%d/%y %H:%M:%S")

moon <- as.POSIXct("1960/07/20, 20:17:39", format="%Y/%m/%d, %H:%M:%S", tz="UTC")
moon
format(moon, "The time of the Apollo moon landing was %Y-%m-%d, at %H:%M:%S.")
format(moon, "인류 최초의 달 착륙은 %Y년 %m월 %d일, %H시 %M분 %S초에 이루어졌다")

y <- 2020
m <- 12
d <- 31
ISOdate(y, m, d)
class(ISOdate(y, m, d))

as.Date(ISOdate(y, m, d))

years <- c(2020, 2021, 2022, 2023)
months <- c(1, 4, 7, 10)
days <- c(12, 19, 25, 17)
ISOdate(years, months, days)
as.Date(ISOdate(years, months, days))

jdate <- as.Date("2020-12-31")
as.integer(jdate)
julian(jdate)

as.integer(as.Date("1970-01-01"))
as.integer(as.Date("1969-12-31"))
as.integer(as.Date("1970-01-02"))
as.integer(as.Date("1970-01-03"))

moon <- as.POSIXct("1969/07/20, 20:17:39", format="%Y/%m/%d, %H:%M:%S", tz="UTC")
moon
moon + 2*60*60

moon + 7*24*60*60

as.Date(moon) +7

start <- as.Date("1988-09-17")
end <- as.Date("2018-02-09")
days <- end - start
days

today <- Sys.Date()
Dooly <- as.Date("1983-04-22")
difftime(today, Dooly, units = "weeks")

Sys.time()
moon <- as.POSIXct("1969/07/20, 20:17:39", format="%Y/%m/%d, %H:%M:%S", tz="UTC")
moon
Sys.time() > moon
Sys.Date()
as.Date(moon)
Sys.Date() >as.Date(moon)
period <- seq(as.POSIXct("1950-01-01", tz="UTC"), by="10 years", length.out = 5)
period
period > moon

##################연습문제#########################
##1
x <- c("Happy", "Birthday", "to", "You")
nchar(x)
length(x)
sum(nchar(x))

##2
y <- paste(x, collapse = " ")
nchar(y)
length(y)

##3
LETTERS
paste(LETTERS[1:10], 1:10, sep = " ")
paste(LETTERS[1:10], 1:10, sep = "")

##4
paste(c("red", "blue"), "pen")
paste(c("red", "blue"), "pen", sep = "-")
paste(c("red", "blue"), "pen", collapse = "; ")
paste(c("red", "blue"), "pen", sep = "-", collapse = "; ")

##5
z <- c("Good", "Morning")
strsplit(z," ")

##6
a <- c("Yesterday is history, tomorrow is a mystery, today is a gift!",
       "That's why we call it the present - from Kung Fu Panda")
b <- unlist(strsplit(a, " "), split=",? -? ?")
b <- gsub("?,","",b)
b <- gsub("?-","",b)
b

##7
O <- outer(1:6, 1:6, FUN = paste)
as.vector(O)

##8
ssn <- c("941215-1234567", "850605-2345678", "760830-1357913")
paste(substr(ssn,1,7),"*******", sep="")

##9
library("USArrests")
install.packages("USArrests")
a <- grep("New", row.names(USArrests))
USArrests[a,]
colMeans(USArrests[a,])

##10
txt <- c("a", "ab", "acb","accb","acccb","accccb")
grep("ac?b", txt, value = TRUE)
grep("ac*b", txt, value = TRUE)
grep("ac+b", txt, value = TRUE)

##11
x <- c("12/25/2020 23:59:59", "1/25/2021 23:59:59", "2/25/2021 23:59:59")
Datetime <- as.data.frame(x)
as.integer(Datetime)
as.POSIXlt(Datetime)

##12
start <- as.Date("2020/06/01" , format="%Y/%m/%d")
a <- seq(from=start, by=7, length.out = 7)
as.Date(a, format="%%m%d")
format(a, "%a-%m%d")

##13
b <- as.Date(c("2020/12/25","2021/01/25","2022/02/25"))
format(b, "%B %d, %Y")
Sys.setlocale("LC_TIME","C")
Sys.setlocale("LC_TIME","Korean_Korea.949")
