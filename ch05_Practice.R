##1
lst <- list(1:12)
length(lst)

mtx <- matrix(1:12, nrow = 4)
length(mtx)

df <- data.frame(x=1:4, y=5:8, z= 9:12)
length(df)

##2
mtcars
head(mtcars)
str(mtcars)
mtcars[1:4]
mtcars[,1:4]
mtcars[-c(5,6,7,8,9,10,11)]
mtcars[c("mpg","cyl", "disp", "hp")]
mtcars[-(5:11)]

##3
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
sex <- factor(c("F", "M", "F", "M", "F"))
math <- c(85, 76, 99, 88, 67)

df <- data.frame(name, sex, math, stringsAsFactors = FALSE)
df
df$sex
levels(df$sex) <- c("M", "F")
df
str(df$name)
str(df)

##4
#a
stat <- c(76, 73, 95, 82, 55)
stat
df$stat <- stat
df
#b
df$score <- round((df$math+df$stat)/2,1)
df
#c
#subset(df,subset = 
df$grade <-         ifelse(df$score>=90, "A",
                ifelse(df$score<90 & df$score >= 80, "B",
                       ifelse(df$score<80 & df$score>=70, "C", "D")))
df
#d
str(df$grade)
df$grade <- factor(df$grade, levels = c("A","B","C","D"), ordered = TRUE)
str(df$grade)

##5
iris
head(iris)
#a
str(iris)
iris.new <- iris[-5]
iris.new
#b
colMeans(iris.new)


##6
beaver1
head(beaver1)
head(beaver2)
#a
str(beaver1)
str(beaver2)
beaver1$id <- 1
beaver2$id <- 2
head(beaver1)
#b
beaver12 <- rbind(beaver1, beaver2)
beaver12[c(5, 1:4)]
#c
subset(beaver12, subset = (activ==1))

##7
head(VADeaths)
#a
str(VADeaths)
VADeaths.df <- as.data.frame(VADeaths)
#b
VADeaths.df$Age <- rownames(VADeaths.df)
VADeaths.df
rownames(VADeaths.df) <- NULL
#c
VADeaths.df$Average <- (VADeaths.df$`Rural Male`+VADeaths.df$`Rural Female`+VADeaths.df$`Urban Male`+
  VADeaths.df$`Urban Female`)/4
VADeaths.df
#d
VADeaths.df <- VADeaths.df[c(5:6,1:4)]
VADeaths.df

##8
USArrests
head(USArrests)
#a
class(USArrests)
USArrests[]
a <- seq(1,nrow(USArrests),5)
a
USArrests[a,]
#USArrests[USArrests %% 5==0]
#b
head(USArrests)
#subset(USArrests, subset = )
nrow(USArrests[USArrests$Murder>15,])
#c
nrow(USArrests[USArrests$Murder > mean(USArrests$Murder),])
#d
USArrests[which.max(USArrests$Murder),]
USArrests[which.min(USArrests$Murder),]

##9
library(MASS)
search()
head(mammals)
#a
class(mammals)
mammals$size <- ifelse(mammals$body>=median(mammals$body),"large","small")
mammals
#b
subset(mammals, subset = (mammals$size=="large"))
#c
row.names(mammals[which.min(mammals$body),])
row.names(mammals[which.max(mammals$body),])
#d
mammals$brain.percent <- (mammals$brain/(mammals$body*1000)) * 100
mammals
mammals[which.max(mammals$brain.percent),]
mammals[which.min(mammals$brain.percent),]
#e
subset(mammals, subset = (mammals$brain.percent > median(mammals$brain.percent) & mammals$size=="large"))

#10
library(sqldf)
data(mtcars)
sqldf("select * from mtcars where mpg>30", row.names=TRUE)
subset(mtcars, subset = (mtcars$mpg>30))
sqldf("select * from mtcars where cyl==6 order by mpg", row.names=TRUE)
subset(mtcars, subset = (mtcars$cyl==6))[order(subset(mtcars, subset = (mtcars$cyl==6))$mpg),]
#b
data(iris)
sqldf("select * from iris where [Sepal.Length] between 4.5 and 4.9
      and Species in ('versicolor', 'virginica')")
subset(iris, subset = (iris$Sepal.Length >= 4.5 & iris$Sepal.Length <= 4.9 
                       & (iris$Species=="versicolor"| iris$Species=="virginica" )))
sqldf("select avg([Sepal.Length]) as avg_Sepal_Length, Species from iris group by Species")
sapply(split(iris$Petal.Length, iris$Species), mean)
