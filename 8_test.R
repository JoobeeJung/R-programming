x <- 11:15
scopeTest <- function(x){
  cat("This is x:", x, "\n")
  rm(x)
  cat("This is x after removing it:",x,"\n")
}

LETTERS
l <- as.list(LETTERS)
for (i in l) print(i)

##1
for (i in month.name) cat("The month of",i,"\n")

##2
evenodd <- function(x) {(x %% 2==0)}
x <- c(-5:5, Inf, -Inf, NA, NaN)
evenodd(x)
##3
counteven <- function(x) {  
  count <- 0
  for(val in x){
    if(!is.na(val %%2==0) & (val%%2==0))
      count <- count+1
  }
  print(count)
}
counteven(x)

##4
Dpi <- function(x)(x>pi) 

x <- c(3, 1:5)
Dpi(x)
Dpi <- function(x){
  ifelse(x>pi, TRUE, FALSE)
}

##5
sd1 <- function(x){
  x <- x[!is.na(x)]
  z <- (x-mean(x))/sd(x)
  return(z)
}
x <- c(1,2,3,4,5,NA)
sd1(x)

##6
c <- "I saw her standing there; Misery; Anna (Go to him); Chains; Boys Ask me Why"
c
gg <- function(x, index){
  gsub(pattern = index, "", x)
}
gg(c, index=";")

##7
colprint <- function(x){
  if(is.data.frame(x)|is.matrix(x)){
  for(i in 1:ncol(x)) cat(colnames(x)[i],"is",class(x[,i]),"\n")}
else cat("It is neither a data frame nor a matrix.","\n")
  }
colprint(iris)
colprint(LakeHuron)

##8
choose <- function(x,med=FALSE){
  mean <- round(mean(x),digits = 1)
  sd <- round(sd(x), digits = 1)
  cat("Mean is",mean,"\b,and Standard Devation is",sd,"\b.\n")
  if(med){
  med <- round(median(x), digits = 1)
  cat("Also Median is", med, "\b.\n")
}
}
choose(1:50)
choose(1:50, med=TRUE)

##9
c <- c("Alice", "was","beginning","to","get","very","tired","of",
       "sitting","by","her","sister","on","the","bank","and","of",
       "having","nothing","to","do","once","or","twice")

numletters <- function(x){
  nchar.x <- nchar(x)
  for(i in min(nchar.x):max(nchar.x)){
  cat("These words have",i,"letter(s):","\n")
    print(toString(unique(x[nchar.x==i])))
  }}
numletters(c)

##10
myMean <- function(x, remove.outlier=FALSE, mult.outlier=2){
  x <- x[!is.na(x)]
  if(remove.outlier==FALSE){result <- mean(x)}
  if(remove.outlier==TRUE){
    outlier.index <-
      (x > mean(x) + mult.outlier*sd(x))|(x<mean(x) - mult.outlier*sd(x))
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
########################################################


##1
for(i in month.name){
  cat("The Month of",i,"\n")
}
##2
oddoreven <- function(x){x%%2==0}
c <- c(-5:5, Inf, -Inf, NA, NaN)
c
oddoreven(c)

##3
counteven <- function(x){
  count <-0
  for(val in x){
  if(!is.na(val%%2!=0) & (val%%2!=0)) 
    count <-count+1}
  return(count)
}
counteven(c)

##4
depi <- function(x)(x>pi)

c <- c(3,1:5)
depi(c)
#
depi <- function(x){
  ifelse(x>pi,1,2)
}

##5
a <- function(x){
  x <- x[!is.na(x)]
    m <- x-mean(x)
    sd <- sd(x)
    return(m/sd)
  }

c <-c(1,2,3,4,5,NA)
a(c)

##6
deltef <- function(x, i){
  gsub(i,"",x)
}
text <- c("I saw her standing there; Misery; Ana (Go to him); Chains; Boys Ask me why")
deltef(text,";")
class(text)
str(text)
##7
show <- function(x){
  if(is.data.frame(x)|is.matrix(x)){
    for(i in 1:ncol(x))
      cat(colnames(x)[i],"is",class(x[,i]),"\n")
  }
  else
    cat("It is neither a data fram nor a matrix.","\n")
}
x <- iris
show(iris)
show(LakeHuron)

##8
fi <- function(x, med=FALSE){
  mean <- round(mean(x),1)
  sd <- round(sd(x),1)
  cat("Mean is",mean,"\b, and Standard Deviation is", sd,"\b.\n")
  if(med){
  med <- median(x)
  cat("Also Median is",med,"\b.\n")}
}
fi(1:50)
fi(1:50, med=TRUE)

##9
alice <- c("Alice", "was","beginning","to","get","very","tired","of",
       "sitting","by","her","sister","on","the","bank","and","of",
       "having","nothing","to","do","once","or","twice","she","had",
       "peeped","into","the","book","her","sister","was","reading",
       "but","it","had","no","pictures","or","conversations","in",
       "it","and","what","is","the","use","of","a","book","thought",
       "Alice","without","pictures","or","conversations")
showord <- function(x){
  nchar.x <- nchar(x)
  for(i in min(nchar.x):max(nchar.x)){
    cat("These words have",i,"letter(s):\n")
    print(toString(unique(alice[nchar.x==i])))
  }
}
showord(alice)

##10
dout <- function(x,b){
  outlier <- sd(x)*b
  ds <- x-outlier
  mean(x)
  mean(ds)
}
library(car)
dout(Salaries$salary)
dout(Salaries$salary,2)
dout(Salaries$salary,3)

myMean <- function(x, remove.outlier=FALSE, mult.outlier=2){
  x <- x[!is.na(x)]
  if(remove.outlier==FALSE){
    result <-mean(x)
  }
  if(remove.outlier==TRUE){
    outlier.index <-
      (x>mean(x)+mult.outlier*sd(x)|x<mean(x)-mult.outlier*sd(x))
    x.new <- x[!outlier.index]
    result <- mean(x.new)
  }
  return(result)
}
myMean(Salaries$salary)
myMean(Salaries$salary,remove.outlier = TRUE)
myMean(Salaries$salary,remove.outlier = TRUE,3)
