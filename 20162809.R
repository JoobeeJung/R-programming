#1#
mtcars
head(mtcars)
str(mtcars)
mtcars[subset(mtcars,select = am, subset = (mtcars$am==0))]
mtcars$am[which(mtcars$am==0)] <- 2
mtcars

#2#
x<- c(2,5,11,NA,33,7,NA,25)
x[!is.na(x)]
x<-na.omit(x)
x

#3#
x <- data.frame(p=c(11,33,55), q=c("A","B","C"))
x
str(x$q)
x$q <- factor(x$q, levels = c("A","B","C"), labels = c("Excellent","Better","Good"))

x

#4#
VADeaths
#(a)
class(VADeaths)
str(VADeaths)
df <- as.data.frame(VADeaths)
str(df)
#(b)
df$total <- rowSums(df)
df
#(c)
df <- df[c(5,1:4)]
df

#5#
x<-c(1,2,3)
y<-c(4,5,6)
z<-c(7,8,9)
mtx <- cbind(x,y,z)
mtx
rownames(mtx) <- c("a","b","c")
mtx
