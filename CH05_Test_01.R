####1

lst <- list(1:12)
lst
length(lst)

mtx <- matrix(1:12, nrow=4)
length(mtx)

df <- data.frame(x=1:4, y=5:8, z=9:12)
length(df)

##2
mtcars[1:4]
mtcars[,1:4]

##3

name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
sex <- factor(c("F","M","F","M","F"))
math <- c(85, 76, 99,88,67)

df <- data.frame(name, sex, math, stringsAsFactors = FALSE)
df
str(df)
df$sex
levels(df$sex) <- c("M","F")
str(df)
df

##4
#a
stat <- c(76, 73, 95, 82, 55)
df<-cbind(df, stat)
#b
score <- (math+stat)/2
round(score, digit=1)
#c
grade <- ifelse(score>90,"A",
       ifelse(score>80 & score <90, "B",
              ifelse(score>70 & score <80, "C",
                     "D")))
#d
str(grade)
factor(grade, levels = c("A","B","C","D"), ordered = TRUE)


##5
iris
#a
str(iris)
iris.new <- subset(iris, select = -Species)
iris.new
#b
#lst <- list(iris.new)
#str(iris.new)
#lst
#iris.new[1]
##str(lst)
#do.call(mean, lst)
colMeans(iris.new)

##6
beaver1
beaver2
head(beaver1)
head(beaver2)
#a
str(beaver1)
str(beaver2)
beaver1 <- cbind(beaver1, id=1)
beaver2 <-cbind(beaver2, id=2)
#B
beaver12 <- rbind(beaver1, beaver2)
beaver12
