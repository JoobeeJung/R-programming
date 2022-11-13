a <- c("Happy", "Birthday","to", "You")
nchar(a)
sum(nchar(a))

##2
b <- paste(a, collapse = " ")
nchar(b)
length(b)

##3
paste(LETTERS[1:10],1:10)
paste(LETTERS[1:10],1:10,sep = "")

##4
paste(c("red","blue"),"pen")
paste(c("red","blue"),"pen", sep = "-")
paste(c("red","blue"),"pen", collapse = "; ")
paste(c("red","blue"),"pen", sep = "-", collapse = "; ")

##5
t <- c("Good Morning")
t
l <- strsplit(t, " ")
list(l[[1]][1], l[[1]][2])

##6
txt <- c("Yesterday is history, tomorrow is a mystery, today is a gift!",
         "That's why we call it the present - from Kung Fu Panda")
t1 <- strsplit(txt, ",? -? ?")
t1

##7
out <- outer(1:6, 1:6,FUN=paste)
?outer
as.vector(out)

##8
ssn <- c("941215-1234567","850605-2345678","760830-1357913")
paste(substr(ssn,1,7),"*******",sep = "")

##9
USArrests
head(USArrests)
class(USArrests)
name <- rownames(USArrests)
g <- grep(pattern = "New", name)
colMeans(USArrests[g,])

##10
txt <- c("a","ab","acb","accb","acccb","accccb")
grep("ac?b",txt,value = TRUE)
grep("ac*b",txt,value = TRUE)
grep("ac+b",txt,value = TRUE)

##11
Datetime <- c("12/25/2020 23:59:59","1/25/2021 23:59:59", "2/25/2021 23:59:59")
df <- as.data.frame(Datetime)
str(df)
df$Datetime <- strptime(df$Datetime, format="%b/%d/%Y %H:%M%S")
str(df)

?as.POSIXlt()

##12
start <- as.Date("2020-06-01")
str(start)
a <- seq(from=start, by="day",length.out = 7)
str(a)
format(a, format="%a-%m%d")
?seq()

##13
d <- c("2020-12-25", "2021-01-25", "2022-02-25")
d <- as.Date(d)
Sys.setlocale("LC_TIME","C")
format(d, format="%B %d, %Y")
Sys.setlocale("LC_TIME","Korean_Korea.949")
  
 