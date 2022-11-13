#######1#######
lst <- list(1:12)
length(lst)
mtx <- matrix(1:12, nrow = 4)
length(mtx)
df <- data.frame(x=1:4, y=5:8, z=9:12)
length(df)

#######2#########
mtcars[1:4]
mtcars[,1:4]
mtcars[-c(5,6,7,8,9,10,11)]
mtcars[c("mpg","cyl","disp","hp")]
mtcars[-(5:11)]

#######3##########
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
str(name)
sex <- factor(c("F","M","F","M","F"))
str(sex)
factor(sex)
levels(sex) <- c("M", "F")
math <- c(85,76,99,88,67)
str(math)

a <- data.frame(name,sex,math)
a

#########4########
##a
stat <- c(76,73,95,82,55)
data.frame(stat)
a <- cbind(a,stat)

##b
score<-round((math+stat)/2,digits=2)
score
cbind(a,score)
a <- cbind(a, score)
a
##c
a$grade[score>90] <- "A"
a$grade[score>=80 & score <90]<- "B"
a$grade[score>=70 & score <80] <- "C"
a$grade[score <70]<- "D"
a
##d
str(a$grade)
a$grade <- factor(a$grade, levels = c("A","B","C","D"), ordered = TRUE)
str(a)
a

##########5###########
data(iris)
iris
##a
head(iris)
str(iris)
iris.new <- iris[-5]
str(iris.new)
##b
iris.new
colMeans(iris.new)

###########6#########
beaver1
head(beaver1)
head(beaver2)
##a
str(beaver1)
str(beaver2)
data.frame(id=1)
beaver1 <-data.frame(beaver1, id=1)
beaver2 <-data.frame(beaver2, id=2)
##b

beaver12 <-rbind(beaver1,beaver2)
beaver12 <-beaver12[,c(5,1:4)]
str(beaver12)

########6#########
beaver1
beaver2
##a
beaver1$id <- 1
beaver2$id <-2
head(beaver1)
head(beaver2)
##b
beaver12 <- rbind(beaver1,beaver2)
beaver12 <- beaver12[c(5,1:4)]
str(beaver12)
##c
subset(beaver12, activ==1)

######7########
VADeaths
##a
str(VADeaths)
##b
VADeaths$Age <- row.names(VADeaths)
row.names(VADeaths) <- NULL
VADeaths
VADeaths$Age <- c(("50-54"),("55-59"),("60-64"),("65-69"),("70-74"))
##c
VADeaths$Average <- ((VADeaths$`Rural Male`+VADeaths$`Rural Female`+VADeaths$`Urban Male`
                      +VADeaths$`Urban Female`)/4)
head(VADeaths)
##d
VADeaths <- VADeaths[c(5:6,1:4)]
head(VADeaths)

######8#######
##a
str(USArrests)
USArrests[seq(1,50,5),]
##b
cor(USArrests)
nrow(subset(USArrests, Murder>15))
##c
row.names(subset(USArrests, subset = (Murder > mean(Murder))))
##d
row.names(USArrests)[which.max(USArrests$Murder)]
row.names(USArrests)[which.min(USArrests$Murder)]

#########9#########
search()
install.packages("mammals")
mammals
library(MASS)
mammals
##a
str(mammals)
mammals$size <- ifelse((mammals$body > median(mammals$body)), "large", "small")
mammals
##b
row.names(mammals$size=="large")
?subset
row.names(subset(mammals, subset = (size=="large")))
##c
mammals[which.max(mammals$body),]
mammals[which.min(mammals$body),]

##d
mammals$brain.percent <- ((mammals$brain*0.001)/mammals$body)
head(mammals)
#row.names(subset(mammals), subset(which.max(mammals$brain.percent)))
mammals[which.max(mammals$brain.percent),]
mammals[which.min(mammals$brain.percent),]

##e
subset(mammals, 
              subset = (mammals$brain.percent>median(mammals$brain.percent) & size=="large"))

########10#########
mtcars
iris
library(sqldf)
##a
data("mtcars")
sqldf("select*from mtcars where mpg>30", row.names=TRUE)
sqldf("select*from mtcars where cyl=6 order by mpg", row.names=TRUE)
