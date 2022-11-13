round(-7.555, 4)
demo(graphics)
help(package="fortunes")
library()
data()
fortune
install.packages("fortunes")
library("fortunes")
search()
?fortunes
args(fortune)
fortune(343)

#1
1:10
10:1
c(1:10,9:1)

x <- 1:10
x
y <- 3:1
#a
names(x) <- letters[x]
x
#b 
x+y

#3
pi
signif(pi, digits=3)
round(pi)
round(pi, digits=3)
ceiling(pi)
trunc(pi)

#4
heights <- c(179, 161, 165, 185, 158)
weights <- c(75, 72, 60, 100, 65)
#a
bmi <- weights/((heights*0.01)^2)
bmi
#b
weights[bmi > 25]

#5
vec <- c(2, 5, 3)
vec
rep(vec, 5)
rep(vec, length.out=10)
rep(vec, vec)
rep(vec, c(2,5,3))

#6
c(TRUE, TRUE, FALSE, FALSE) & c(TRUE, FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE, FALSE) | c(TRUE, FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE, FALSE) + 1:4

#7
a<- 1:100
a[seq_along(a)%%7==0]
seq(1,100)
sum(a[seq_along(a)%%7==0])
sum((1:100)%% 7==0)

#8
rep(c("a","b","c"),3)
rep(c(1,3,5), c(1,3,5))
rep(0:2, rep(2,3))
rep(seq(1,3), times=3) +rep(0:2, each=3)

#9
none.true <- c(FALSE, FALSE, FALSE)
any(none.true)
all(none.true)

some.true <- c(FALSE, TRUE, FALSE)
any(some.true)
all(some.true)

all.true <- c(TRUE, TRUE, TRUE)
any(all.true)
all(all.true)

true.missing <- c(TRUE, TRUE, NA)
any(true.missing)
all(true.missing)

false.missing <- c(NA, FALSE, NA)
any(false.missing)
all(false.missing)


mixed <- c(TRUE, FALSE, NA)
any(mixed)
all(mixed)

#10
x <- 1:10
y <- (x-mean(x))/sd(x)
mean(y)
sd(y)

#11
a <- c(3,2,5,1,5,6,5)
a
a.factor <- factor(a, levels = c(1,2,3,4,5,6), labels = c("one","two","three","four",
                                                         "five", "six"))
a.factor
table(a.factor)

#12
seq(0,1,0.1)
seq(0,1,length.out = 10)

#1
mtx <- matrix(1:12, 3,4)
mtx
dimnames(mtx) <- list(letters[1:3], c(letters[1:4]))
mtx                   

#2
mtx.a <- mtx[,c(1,3)]
mtx.b <- mtx[,c(2,4)]
mtx.c <- cbind(mtx.a, mtx.b)
mtx.c

#3
3*mtx
mtx + 3
mtx + mtx.c
mtx - mtx.c
mtx * mtx.c
mtx / mtx.c
mtx %*% mtx.c

#4
matrix(1:4, nrow = 2)^(1:4)

#5
a <- matrix(1:10,ncol = 1)
a
b <- a*2
c <- a*3
d <- a*4
e <- a*5
mtx <- cbind(a,b,c,d,e)
mtx
row.names(mtx) <- letters[1:10]
rownames(mtx)
#rowSums(mtx["h",])
#args(rowSums)
Sum(mtx["h",])
sum(mtx["h",])

#6
x <- matrix(1:9999, ncol = 9)
x
y <- x[(dim(x)[1]-2):(dim(x)[1]), (dim(x)[2]-1):(dim(x)[2])]
y

#7
x <- c(1:3)
y <- x^2
z <- letters[1:3]
mtx <- cbind(x,y,z)
mtx
str(mtx[,1])
str(x)
is.numeric(mtx[,1])
is.numeric(mtx[,2])
is.character(mtx[,3])

#8
mtx <- matrix(1:12,3,4)
matrix(1, ncol(mtx))
matrix(1,4)

#9
mtx <- matrix(1:10000, 1000)
mtx[777,3]

#10
v <- c(0.43, 0.04, 0.01
       , 0.49, 0.72, 0.52,
       0.08, 0.24, 0.47)
mtx <- matrix(v, nrow = 3, ncol = 3)
mtx
dimnames(mtx) <- list(c("lower", "middle", "upper"),c("lower", "middle", "upper"))
mtx
#a
#b
rowSums(mtx)
#c
mtx.2 <- mtx%*%mtx
mtx.2
#d
mtx.2[c(1,2,3),"upper"]

#1
length(list(list(alpha=pi, beta=sqrt(pi)), gamma=letters, delta=NULL))
length(list(alpha=pi, beta=sqrt(pi), gamma=letters, delta=NULL))

#2
lst <- list(c(3,5,7), c("A","B","C"))
lst
lst[[2]][[1]] <- "Alpha"
lst
lst[2]
lst[[2]]

#3
lst1 <- list(math=list(95, 90), writing=list(90,85),reading=list(85,80))
lst1
mean(unlist(lst1))

#4
lst2 <- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
lst2[[1]] <- lst2[[1]] +1
lst2

#5
lst3 <- list(L=letters[1:5], M=month.name[1:5])
lst3
lst3[[2]][-3]

#6
lst <- list(month.name, month.abb)
#a
names(lst) <- list("mon.name","mon.abb")
lst
#b
length(lst[[1]]) + length(lst[[2]])
#c
lst$mon.num <- c(1:12)
lst

#7
lst1 <- list("X","Y","Z","x","y","z")
lst2 <- list("x","y","z")
setdiff(lst1,lst2)
intersect(lst1,lst2)
union(lst1,lst2)

#8
lst <- list(list(a=1, b=2), pi)
lst[2]

#9
lst <- c(list(a=1, b=2),pi)
lst[3]

#10
lst <- list(first=1, second=2, third=list(third.one=3.1, third.two=3.2))
lst
#a
lst[1:2]
lst[-3]
lst[c("first", "second")]
lst[c(TRUE, TRUE, FALSE)]
lst[1,2]

#b
lst$second
lst$s
lst[[2]]
lst[["second"]]
lst[["s"]]

#c
lst[["third"]][["third.one"]]
lst[[c("third", "third.one")]]
lst[["third"]]$third.one
lst[[3]][[1]]
lst[[3]]["third.one"]


lst <- list("Apple", NULL, "Orange")
lst[sapply(lst,is.null)]<- NULL
lapply(lst, is.null)
sapply(lst, is.null)
length(sapply(lst, is.null)=="TRUE")

lst <- list(-2.4,0.4,5.7,12.5,17.8,22.2,24.9,25.7,21.2,14.8,7.2,0.4)
lst
names(lst) <- month.abb[1:12]
lst
#a
lst[lst<0]
#b
names(lst[mean(unlist(lst))>lst])
#c
lst[mean(unlist(lst))>lst] <- NULL
lst

#1
lst <- list(1:12)
lst
mtx <- matrix(1:12, nrow =4)
mtx
df <- data.frame(x=1:4, y=5:8, z=9:12)
df

length(lst)
length(mtx)
length(df)

mtcars[1:4]
str(mtcars)
mtcars[,1:4]
mtcars[-c(5,6,7,8,9,10,11)]
mtcars[c("mpg","cyl","disp","hp")]
mtcars[-5:11]

#3
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
sex <- factor(c("F","M","F","M","F"))
math <- c(85,76,99,88,67)
df <- data.frame(name,sex,math,stringsAsFactors = FALSE)
df$sex
levels(df$sex) <- c("M","F")
df
str(df)

#4
#a
stat <- c(76, 73, 95, 82, 55)
df$stat <- stat
df
#b
df$score <- round((math +stat)/2,1)
df
#c
df$grade <- ifelse(df$score>90,"A",
       ifelse(df$score>80, "B",
              ifelse(df$score>70, "C", "D")))
df
#d
str(df$grade)
df$grade <- factor(df$grade, ordered = TRUE)
df
str(df)
 

v<- list(NA,NA,NA,1,2,NA)
sum(v, na.rm = TRUE)
a <- sapply(v, is.na)
length(a=="FALSE")
sum(sapply(v, is.na))

#5
iris
head(iris)
#a
str(iris)
iris.new <- iris[-5]
iris.new
#b
colMeans(iris.new)
#6
#a
str(beaver1)
str(beaver2)
beaver1$id <- 1
beaver2$id <-2
beaver1
#b 
beaver12 <- rbind(beaver1, beaver2)
head(beaver12)
beaver12 <- beaver12[c(5,1:4)]
str(beaver12)
#C
subset(beaver12, subset = (activ==1))

#7
str(VADeaths)
VADeaths.df <- as.data.frame(VADeaths)
#b
VADeaths.df$Age <- rownames(VADeaths.df) 
rownames(VADeaths.df) <- NULL
VADeaths.df
#C
VADeaths.df$Average <- rowMeans(VADeaths.df[-5])
VADeaths.df
#d
VADeaths.df <- VADeaths.df[c(5:6,1:4)]

#8
class(USArrests)

seq(1,nrow(USArrests),5)
USArrests[seq(1,nrow(USArrests),5),]
#b
nrow(USArrests[USArrests$Murder > 15,])
#c
rownames(USArrests[USArrests$Murder > mean(USArrests$Murder),])
#d
rownames(USArrests[which.max(USArrests$Murder),])
rownames(USArrests[which.min(USArrests$Murder),])

#9
str(mammals)
library(MASS)
mammals$size <- ifelse(mammals$body > median(mammals$body), "large", "small")
mammals
subset(mammals, subset = (mammals$size=="large"))

data(sqldf)
library(sqldf)
search()
data(mtcars)
sqldf("select * from mtcars where mpg>30", row.names=TRUE)
subset(mtcars, subset = (mtcars$mpg>30))

sqldf("select * from mtcars where cyl=6 order by mpg", row.names=TRUE)
subset(mtcars, subset = (mtcars$cyl==6))[order(subset(mtcars, subset=(cyl==6))$mpg),]

       