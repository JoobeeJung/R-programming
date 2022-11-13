##1
x <- c(5:10)
x[c(1,2)] <- 2:3
x
x[-1] <- 1:5
x

##2
library(mtcars)
mtcars
class(mtcars)
head(mtcars)
mtcars$weight[mtcars$wt >median(mtcars$wt)] <-"heavy"
mtcars$weight[mtcars$wt <median(mtcars$wt)] <-"light"
head(mtcars)

##3
head(mtcars[,order(names(mtcars))])

##4
##5
sample(1:nrow(iris),0.7*nrow(iris))
##7
names <- c("Gates","Jobs","Bezos")
#a
summary(names)
str(stable(names))
as.vector(table(names))
as.list(table(names))
lapply(names,nchar)
sapply(names,nchar)

##8
lst1 <- list(A=matrix(1:12, nrow=3), B=matrix(1:12, nrow=2), c=1:12)
lst1
lst2 <- list(A=matrix(1:12, nrow=3), B=matrix(1:12, nrow=6), c=12:1)
lst2
identical(unlist(lst1),unlist(lst2))
?identical
mapply(identical, lst1,lst2)
##9
apply(state.x77, 2, mean)
apply(state.x77, 2, sd)

##10
r <- data.frame(ID=c(1,1,2,2),Type=c("T1","T2","T1","T2"), x1=c(4,7,2,5),x2=c(3,6,4,1))
r
#a
library(reshape2)
melt(r, id.vars=c("ID","Type"))
dcast(r, Type~variable,mean)

ChickWeight
#a
library(tidyr)
d <- melt(ChickWeight,id.vars = c("Time","Chick","Diet"))
dcast(d, Time ~ variable ,mean)
head(ChickWeight)
ChickWeight.long <- melt(ChickWeight, id.vars = 2:4)
head(ChickWeight.long)
dcast(ChickWeight.long, Time~variable, mean)
library(reshape2)
library()
dcast(d,Time~variable, fun.aggregate=mean, na.rm=TRUE)
head(ChickWeight)
ChickWeight.long <- melt(ChickWeight, id.vars=2:4)
dcast(ChickWeight.long, Diet ~ Time , fun.aggregate = mean)
dcast()
rm(list=ls())
