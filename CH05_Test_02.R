##6
#a
str(beaver1)
str(beaver2)

beaver1 <- cbind(beaver1, id=1)
beaver1
beaver2 <- cbind(beaver2, id=2)
beaver2
#b
beaver12 <- rbind(beaver1, beaver2)
beaver12

names(beaver12) 
names(beaver12$id) <- "id"
str(beaver12)
beaver12$id
names(beaver12$id) <- "id"

beaver12[,c(5,1:4)]
#c
subset(beaver12, select = "activ", subset =("activ"="1"))

##7
#a
VADeaths <- data.frame(VADeaths)
class(VADeaths)

#b
VADeaths$Age <- rownames(VADeaths)
VADeaths
rownames(VADeaths) <- NULL
VADeaths[c(5,1:4)]

#c
VADeaths$Average <- with(VADeaths,(Rural.Male + Rural.Female + Urban.Male + Urban.Female)/4)
VADeaths

##d
VADeaths <- VADeaths[c(5:6,1:4)]
VADeaths

##8
USArrests
#a
str(USArrests)
USArrests[seq(1,50,5),]
#b
nrow(USArrests[c(USArrests$Murder >15),])
nrow(subset(USArrests, subset = (Murder > 15)))
#c
row.names(subset(USArrests, subset = (mean(USArrests$Murder) < USArrests$Murder)))
#d
row.names(USArrests)[which.max(USArrests$Murder)]
row.names(USArrests)[which.min(USArrests$Murder)]

##9
#a
search()
library(MASS)
mammals
head(mammals)
str(mammals)
mammals$size <- ifelse(mammals$body > median(mammals$body),"large","small")
mammals
#b
subset(mammals, subset = (mammals$size=="large"))
#c
mammals[which.max(mammals$body),]
mammals[which.min(mammals$body),]
row.names(mammals)[which.max(mammals$body)]
#d
head(mammals)
mammals$brain.percent <- (mammals$brain/(mammals$body*1000))*100
mammals
mammals[which.max(mammals$brain.percent),]
mammals[which.min(mammals$brain.percent),]
#e
subset(mammals,subset = (mammals$brain.percent > median(mammals$brain.percent) & mammals$size =="large"))

#10
#a
library(sqldf)
data(mtcars)
sqldf("select * from mtcars where mpg > 30", row.names=TRUE)
sqldf("select * from mtcars where cyl=6 order by mpg", row.names=TRUE)

str(mtcars)
subset(mtcars, subset = (mtcars$mpg > 30))
subset(mtcars, subset = (cyl ==6))[ordered(subset(mtcars, subset =(cyl ==6))$mpg),]

#b
data(iris)
sqldf("select * from iris where[Sepal.Length] between 4.5 and 4.9 and Species in ('versicolor', 'virginica')")
#---------------------------------
subset(iris, subset = (iris$Sepal.Length >= 4.5 & iris$Sepal.Length <= 4.9 & iris$Species %in% c("versicolor", "virginica")))
sqldf("select avg([Sepal.Length]) as avg_Sepal_Length, Species from iris group by Species")
#iris$avg_Sepal_Length <- mean(iris$Sepal.Length)
#subset(iris, select = c(iris$avg_Sepal_Length, Species), subset = )
sapply(split(iris$Sepal.Length, iris$Species), mean)
