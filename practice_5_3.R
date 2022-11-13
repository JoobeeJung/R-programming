id <- c("A001", "A002", "A003")
name <- c("Mouse", "Keyboard", "USB")
price <- c(30000, 90000, 50000)
product <- data.frame(id, name, price, stringsAsFactors = FALSE)
product

product <- rbind(product, c("A004", "Monitor", 250000))
product

new.rows <- data.frame(id=c("A005", "A006"),
                       name=c("Memory", "CPU"),
                       price=c(35000, 320000))
new.rows
product <- rbind(product, new.rows)

proudct <- cbind(product, madein=c("Korea", "China", "China","Korea", "Korea", "USA"))
product

product$madein <- c("Korea", "China", "China","Korea", "Korea", "USA")
product

new.cols <- data.frame(manufacturer=c("Logitech","Logitech","Samsung", "Samsung","Samsung","Intel" ))
product <- cbind(product, new.cols)
product
cols1 <- data.frame(x=c("a","b","c"), y=c(1,2,3))
cols2 <- data.frame(x=c("alpha","beta","gamma"), y=c(100,200,300))
cbind(cols1,cols2)

df1 <- data.frame(sex="female", months=1, weights=3.5)
df2 <- data.frame(sex="male", months=3, weights=4.8)
df3 <- data.frame(sex="male", months=4, weights=5.3)
df4 <- data.frame(sex="female", months=9, weights=9.4)
df5 <- data.frame(sex="female", months=7, weights=8.3)
lst <- list(df1, df2, df3, df4, df5)
lst
str(lst)
lst[[1]]
lst[1]
str(lst[[1]])

rbind(lst[[1]], lst[[2]])

lst2 <- do.call(rbind, lst)
str(lst2)

ls1 <- list(sex="female", months=1, weights=3.5)
ls2 <- list(sex="male", months=3, weights=4.8)
ls3 <- list(sex="male", months=4, weights=5.3)
ls4 <- list(sex="female", months=9, weights=9.4)
ls5 <- list(sex="female", months=7, weights=8.3)
lst <- list(ls1, ls2, ls3, ls4, ls5)
lst

as.data.frame(lst[1])
as.data.frame(lst[2])
do.call(rbind,lapply(lst, as.data.frame))

str(state.x77)
head(state.x77)
states <- as.data.frame(state.x77)
str(states)
row.names(states)
states$Name <- row.names(states)
head(states)
row.names(states) <- NULL
head(states)

rich.states <- states[states$Income>5000, c("Name", "Income")]
str(rich.states)
large.states <- states[states$Area>100000, c("Name", "Area")]
merge(rich.states, large.states)
merge(rich.states, large.states, all=TRUE)

mtcars
head(mtcars)
subset(mtcars, select = mpg, subset=(mpg>30))
subset(mtcars,c(mpg,hp,wt), subset = (cyl==4 & am==0))

subset(mtcars, select = c(mpg, cyl, wt), subset = (mpg > mean(mpg)))

USArrests
head(USArrests)
cor(USArrests)
subset(cor(USArrests), select =-UrbanPop)
cor(subset(USArrests, select = -c(UrbanPop, Rape)))

iris       
head(iris)
str(iris)
r <- iris$Sepal.Length/iris$Sepal.Width
head(r)
r <- with(iris, Sepal.Length/Sepal.Width)
head(r)

with(iris, {
  print(summary(Sepal.Length))
  plot(Sepal.Length, Sepal.Width)
  plot(Petal.Length, Petal.Width)
})

with(iris, {
  stats <- summary(Sepal.Length)
stats})
stats

with(iris,{
  stats.nokeep <- summary(Sepal.Length)
  stats.keep <<- summary(Sepal.Length)
})
stats.nokeep
stats.keep

iris$Sepal.Ratio <- iris$Sepal.Length / iris$Sepal.Width
head(iris$Sepal.Ratio)

iris <-within(iris, Sepal.Ratio <- Sepal.Length/Sepal.Width)
head(iris$Sepal.Ratio)
iris$Sepal.Ratio

names(iris)

attach(iris)
search()
r <- Sepal.Length / Sepal.Width
head(r)
detach(iris)
search()

attach(iris)
iris$Sepal.Length <- 0
head(iris$Sepal.Length)
head(Sepal.Length)
detach(iris)

attach(iris)
Sepal.Width <- Sepal.Width * 10
ls()
?ls

head(Sepal.Width)
head(iris$Sepal.Width)
detach(iris)
rm(Sepal.Width)
Sepal.Length <- c(4.5,5.3,6.7)
attach(iris)
plot(Sepal.Length, Sepal.Width)
Sepal.Length
detach(iris)
library(sqldf)
data(mtcars)
sqldf("select*from mtcars where mpg>30", row.names=TRUE)
sqldf("select*from mtcars where cyl=6 order by mpg", row.names=TRUE)
sqldf("select avg(mpg) as avg_mpg, avg(wt) as avg_wt, gear from mtcars where cyl in (4,6) group by gear")

data(iris)
sqldf("select distinct Species from iris")
sqldf("select * from iris limit 3")
sqldf("select avg([Sepal.Length]) from iris where species = 'setosa'")

