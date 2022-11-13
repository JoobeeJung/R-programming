x <- c(30, 50, 90)
tlength <- round(x*0.9144, digits=1)
result <- paste(tlength, "m", sep = "")
print(result)

source("transLength.R")

transLength <- function(x){
  tlength <- round(x*0.9144, digits=1)
  result <- paste(tlength, "m", sep="")
  return(result)
}
ls()

y <- c(100, 150, 200)
transLength(y)

trans2 <- transLength
trans2(y)

trans2

transLength <- function(x){
  tlength <- round(x*0.9144, digits = 1)
  result <- paste(tlength, "m", sep="")
}

y <- c(100, 150, 200)
transLength(y)
print(transLength(y))


transLength <- function(x){
  tlength <- round(x*0.9144, digits = 1)
  paste(tlength, "m", sep="")
}

y <- c(100, 150, 200)
transLength(y)

transLength <- function(x){
  if(!is.numeric(x)) return("Not a number")
  tlength <- round(x*0.9144, digits=1)
  paste(tlength, "m", sep="")
}
transLength("ABC")

f1 <- function(x,y) {x+y}
f2 <- function(x,y) x+y
f1(1,3)
f2(1,3)

transLength <- function(x) paste(round(x*0.9144, digits = 1), "m", sep = "")

transLength <- function(x, mult, unit){
  tlength <- round(x*mult, digits = 1)
  paste(tlength, unit, sep="")
}

y <- c(100, 150, 200)
transLength(y, mult=2, unit="ft")
transLength(y, mult=36, unit = "in")

transLength(y)

transLength <- function(x, mult=0.9144, unit="m"){
  tlength <- round(x*mult, digits = 1)
  paste(tlength, unit, sep="")
}
y <- c(100, 150, 200)
transLength(y)

y <- c(100, 150, 200)
transLength(x=y, mult=3, unit="ft")
transLength(y, 3, "ft")

transLength <- function(x, mult=0.9144, unit="m", ...){
  tlength <- round(x*mult, ...)
  paste(tlength, unit, sep="")
}
y <-c(100,150,200)
transLength(y, digits=2)
transLength(y)

transLength <- function(x, mult=0.9144, unit="m", digits=1){
  tlength <- round(x*mult, digits = digits)
  paste(tlength, unit, sep="")
}

transLength <- function(x, mult=0.9144, unit="m", FUN=round,...){
  tlength <- FUN(x*mult, ...)
  paste(tlength, unit, sep="")
}
ls()

x <- 11:15
scopeTest <- function(x){
  cat("This is x:", x, "\n")
  rm(x)
  cat("This is x after removing it: ", x, "\n")
}

x <- pi
y <- 3
if (x>y) x
if (x<y) x else y

x <- pi
y <- 1:5
if (x<y) x else y
if (x>y) x else y

test <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
yes <- 1:5
no <- 0
ifelse(test, yes, no)

x <- pi
y <- 1:5
ifelse(x>y, x, y)

center <- function(x, type){
  swithch(type,
          mean=mean(x),
          median=median(x),
          trimmed=mean(x, trim=0.1))
}

i <- 5
repeat{if(i>25) break
else{
  print(i)
  i <- i+5
}
}

i <- 5
while(i <= 25) {
  print(i)
  i <- i+5
}

for (var in list) statment
for (i in seq(from=5, to=25, by=5)) print(i)

##1
for( i in seq(from=1, to=12, by=1))cat("The month of",month.name[i],"\n")

##2
a <- c(-5:5, Inf, -Inf, NA, NaN)
ifelse(a%%2==0,"TRUE","FALSE")

##3
countEven <- function(x){
  count <- 0
  for (val in x){
    if(!is.na(val %%2==0) & (val %%2==0))count <- count+1
  }
  print(count)
}
b <- c(-5:5, Inf, -Inf, NA, NaN)
countEven(b)

##4
c <- c(3, 1:5)
IsPi <- function(x){
  ifelse(x > pi, "TRUE","FALSE")
}
IsPi(c)

##5
scaling <- function(x){
  x <- x[!is.na(x)]
  z <- (x-mean(x))/sd(x)
  return(z)
}
nums <- c(1,2,3,4,5,NA)
scaling(nums)

##6
toSpace <- function(x, pattern){
  return(gsub(pattern, "", x))
}
x <- "I saw her standing there; Misery; Anna (Go to him); Chains; Boys; Ask me why"
toSpace(x, ";")

##7
classes <- function(x){
  if(is.data.frame(x) | is.matrix(x)){
    for (i in 1:ncol(x))cat(colnames(x)[i], "is", class(x[,i]), "\n")
  }
  else cat("It is neither a data frame nor a matrix.", "\n")
}
classes(iris)
classes(LakeHuron)

##8
mm <- function(x, med=FALSE){
  mean <- round(mean(x), 1)
  sd <- round(sd(x),1)
  cat("Mean is", mean, "\b, and Standard Deviation is", sd, "\b.\n")
  if(med){
    median <- median(x)
    cat("Also Median is", median, "\b.\n")
  }
}
mm(1:50)
mm(1:50, med=TRUE)

##9
alice <- c("Alice","was","beginning", "to", "get",
           "very","conversations")
countLetters <- function(x){
  nchar.x <- nchar(x)
  for (i in min(nchar.x):max(nchar.x)){
  cat("These words have", i,"letter(s):\n")
  print(toString(unique(alice[nchar.x == i])))
  }}
countLetters(alice)  

##10
#a\\
install.packages("car")
cars 
myMean <-function(x, remove.outlier=FALSE, mult.outlier=2){
  x <- x[!is.na(x)]
  if(remove.outlier==FALSE){result <- mean(x)}
  if(remove.outlier==TRUE){
    outlier.index <-
      (x >mean(x) + mult.outlier*sd(x)) | (x < mean(x) - mult.outlier*sd(x))
    x.new <- x[!outlier.index]
    result <- mean(x.new)
  }
  return(result)
}

library(car)
x <- Salaries$salary
mean(x)
myMean(x)
myMean(x, remove.outlier = TRUE)
myMean(x, remove.outlier = TRUE, mult.outlier = 3)

