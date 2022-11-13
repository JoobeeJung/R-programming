x <- "We have a dream"
nchar(x)
length(x)

y <- c("We","have","a","dream")
length(y)
nchar(y[4])
nchar(y)

letters
sort(letters, decreasing = TRUE)

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(fox.said, " ")
strsplit(fox.said, "")

fox.said.words <- unlist(strsplit(fox.said, " "))
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words[3]
p1 <- "You come at four in the afternoon, then at three I shall begin to be happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
littleprince <- c(p1, p2, p3)
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]]
strsplit(littleprince, " ")[[3]][5]

fox.said <- "WHAT IS ESSENTIAL is invisible to the Eye"
fox.said.words <- strsplit(fox.said, " ")[[1]]
unique(fox.said.words)
unique(tolower(fox.said.words))

paste("Everybody", "wants", "to", "fly")
paste(c("Everybody", "wants","to", "fly"))
fox.said <- "WHAT IS ESSENTIAL is invisible to the Eye"
fox.said.words <- strsplit(fox.said, " ")[[1]]
paste(fox.said.words)

paste("Everybody", "wants", "to", "fly", sep="-")
paste("Everybody", "wants", "to", "fly", sep="")

paste(pi, sqrt(pi))
paste("25 degrees Celsius is", 25*1.8 + 32, "degrees Fahrenheit")

heros <- c("Batman", "Captain America", "Hulk")
colors <- c("Black", "Blue", "Green")
paste(colors,heros)

paste("Type", 1:5)
heros
paste(heros, "wants","to","fly")

paste(c("Everybody","wants","to","fly"),collapse = " ")

heros
paste(heros, "wants","to","fly", collapse =",and ")
paste(heros, "wants","to","fly",sep="-", collapse ="; ")
paste(month.abb, 1:12, sep="_", collapse = "-")
outer(c(1,2,3), c(3,2,1))

asian.countries <- c("Korea", "China", "Japan")
info <- c("GDP","Population","Area")
out <- outer(asian.countries, info, FUN=paste, sep="-")
as.vector(out)

x <- outer(asian.countries, asian.countries, paste, sep="-")
x[!lower.tri(x)]
customer <- "Jobs"
buysize <- 10
deliveryday <- 3
paste("Hello", customer, ",your order of ", buysize, " product(s) will be delivered within ", "day(s).", sep="")

sprintf("Hello %s, your order of %s product(s) will be dlivered within %s days",
        customer, buysize, deliveryday)

customers <- c("Jobs", "Gates", "Bezos")
buysizes <- c(10,7,12)
deliverydays <- c(3,2,7.5)
sprintf("Hello %s, your order of %s product(s) will be dlivered within %s days",
        customers, buysizes, deliverydays)


substr("Data Analytics", start=1, stop=4)
substring("Data Analytics", 6)

class <- c("Data Analytics", "Data Mining", "Data Visualization")
substr(class, 1, 4)

countries <- c("Korea, KR", "United States, US", "China, CN")
substr(countries, nchar(countries)-1, nchar(countries))

head(islands)
landmasses <- names(islands)
landmasses
index <- grep(pattern="New", landmasses)
landmasses[index]

grep("New", landmasses, value=TRUE)

landmasses[grep(" ", landmasses)]
grep(" ", landmasses, value = TRUE)

txt <- "Data Analytics is useful. Data Analytics is also interesting"
sub(pattern="Data", replacement = "Business", x=txt)
gsub(pattern="Data", replacement = "Business", x=txt)

x <- c("product.csv", "customer.csv", "supplier.csv")
gsub(".csv", "",x)

words <- c("at", "bat", "cat", "chaenomeles","chase","chasse",
           "cheap","check","cheese","chick","hat")
grep("che",words, value = TRUE)
grep("at",words, value = TRUE)

grep("[ch]",words, value=TRUE)
grep("[at]",words, value=TRUE)

grep("ch|at", words, value=TRUE)
grep("ch(e|i)ck", words, value = TRUE)

grep("chas?e", words, value=TRUE)
grep("chas*e", words, value=TRUE)
grep("chas+e", words, value=TRUE)
grep("ch(a*|e*)se", words, value=TRUE)

grep("^c", words, value = TRUE)
grep("t$", words, value = TRUE)

grep("^c.*t$", words, value=TRUE)
grep("^[hc]?at", words, value = TRUE)

words2 <- c("12Dec", "OK", "http://","<TITLE>Time?</TITLE>", "12345", "Hi there")
grep("[[:alnum:]]", words2, value = TRUE)
grep("[[:alpha:]]", words2, value = TRUE)
grep("[[:digit:]]", words2, value = TRUE)
grep("[[:punct:]]", words2, value = TRUE)
grep("[[:space:]]", words2, value = TRUE)

grep("\\w", words2, value=TRUE) 
grep("\\d", words2, value=TRUE) 
grep("\\s", words2, value=TRUE) 
?regex

Sys.Date()
date()
Sys.time()
class(Sys.Date())

as.Date("2020-12-31")
as.Date("12/31/2020")
as.Date("12/31/2020", format="%m/%d/%Y")

d <- as.Date("2020-12-31")
format(d, format="%m/%d/%Y")
format(d, format="%m/%d/%Y %A" )

d <- as.Date("2020-12-31")
weekdays(d)
d + 8
d + 1:7
weekdays(d + 1:7)

start <- as.Date("2021-01-01")
end <- as.Date("2021-01-31")
seq(from=start, to = end, by=1)
seq(from=start, by=1, length.out = 7)
seq(from=start, by="7 days", length.out = 9)
seq(from=start, by="week", length.out = 9)
seq(from=start, by="month", length.out = 9)
seq(from=start, by="3 month", length.out = 9)
seq(from=start, by="year", length.out = 10)
seq(from=as.Date("2020-01-30"), by="month", length.out = 6)

start <- as.Date("2020-01-01")
qrt <- seq(from=start, by="3 months", length.out = 4)
months(qrt)
quarters(qrt)
Sys.getlocale()

pct <- as.POSIXct("2020/03/15, 15:03:04", format="%Y/%m/%d, %H:%M:%S")
pct
class(pct)
as.integer(pct)
unclass(pct)
plt <- as.POSIXct("2020/03/15, 15:03:04", format="%Y/%m/%d, %H:%M:%S")
class(plt)
unclass(plt)

pct <- as.POSIXct("2020/03/15, 15:03:04", format = "%Y/%m/%d, %H:%M:%S")
pct
class(pct)
as.integer(pct)
plt <- as.POSIXct("2020/03/15, 15:03:04", format = "%Y/%m/%d, %H:%M:%S")
plt
class(plt)

unclass(plt)

moon <- as.POSIXct("1969/07/20, 20:17:39", format="%Y/%m/%d, %H:%M:%S", tz="UTC")
moon
format(moon, "The time of the Apollo moon landing was %Y-%b-%d, at %H:%M:%S.")
format(moon, "인류 최초의 달 착륙은 %Y년 %m월 %d일, %H시 %M분 %S초에 이루어졌다.")

y <- 2020
m <- 12
d <- 31
ISOdate(y,m,d)
class(ISOdate(y,m,d))

as.Date(ISOdate(y,m,d))

years <- c(2020, 2021, 2022, 2023)
months <- c(1,4,7,10)
days <- c(12,19,25,17)
ISOdate(years, months, days)
as.Date(ISOdate(years,months, days))

jdate <- as.Date("2020-12-31")
as.integer(jdate)
julian(jdate)
moon
moon + 2*60*60

start <- as.Date("1988-09-17")
end <- as.Date("2018-02-09")
days <- end - start
days

#####1

x <- c("Happy", "Birthday", "to", "YOu")
length(x)
nchar(x)
sum(nchar(x))

#########2

paste(x)
y <- paste("Happy", "Birthday", "to", "YOu")
nchar(y)
length(y)

#######3
letters
LETTERS
paste(LETTERS[1:10], 1:10, sep = "")
paste(LETTERS[1:10], 1:10)

########4
paste(c("red", "blue"), "pen")
paste(c("red", "blue"), "pen", sep="-")
paste(c("red", "blue"), "pen", collapse = "; ")
paste(c("red", "blue"), "pen", sep="-", collapse = "; ")

#######5
a <- "Good morning"
b <- strsplit(a," ")
list(b[[1]][1], b[[1]][2])

#####6
c <- c("Yesterday is history, tomorrow is a mystery, today is a gift !", 
  "That's why we call it the present - from Kung Fu Panda")
strsplit(c, split = (",? -? ?"))     

#####7

