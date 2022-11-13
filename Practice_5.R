v1 <- c("A001", "A002", "A003")
v2 <- c("mouse", "keyboard", "usb")
v3 <- c(30000, 90000, 50000)
product <- data.frame(v1, v2, v3)
product

product <- data.frame(row.names = v1, v2, v3)
product

product <- data.frame(id=v1, name=v2, price=v3)
product

str(product)
product <- data.frame(id=v1, name=v2, price=v3, stringsAsFactors = FALSE)
str(product)

mat <- matrix(c(1,3,5,7,9,
                2,4,6,8,10,
                2,3,5,7,11), ncol=3)
mat
as.data.frame(mat)
number <- as.data.frame(mat)
colnames(number) <- c("odd", "even", "prime")
number

v1 <- c("A001", "A002", "A003")
v2 <- c("mouse", "keyboard", "usb")
v3 <- c(30000, 90000, 50000)
lst <- list(v1, v2, v3)
lst
as.data.frame(lst)
lst
product <- as.data.frame(lst)
colnames(product) <- c("id","name","price")
product

nrow(product)
length(product)
ncol(product)

us.state <- data.frame(state.abb, state.name, state.region, state.area,
                       stringsAsFactors = FALSE)
us.state
str(us.state)

us.state[[2]]
#us.state[[2,drop=FALSE]]
str(us.state[[2]])
str(us.state[[3]])
us.state[2]
str(us.state[2])

us.state[c(2,4)]
us.state[,2,drop=FALSE]

us.state[,c(2,4)]

us.state[["state.name"]]
us.state$state.name
us.state[,"state.name"]
us.state["state.name"]

us.state[c("state.name","state.area")]
us.state[,c("state.name","state.area")]

id <- c("A001", "A002", "A003")
name <- c("mouse", "keyboard", "usb")
price <- c(30000, 90000, 50000)
product <- data.frame(id,name,price, stringsAsFactors = FALSE)
product

product <- rbind(product, c("A004","Monitor", 250000))
product

new.rows <- data.frame(id=c("A005","A006"),
                       name=c("memory", "CPU"),
                       price=c(35000,320000))
product <- rbind(product,new.rows)
product

product <- cbind(product, madein=c("Korea", "China", "China",
                                   "Korea","Korea", "USA" ))
product
product$madein <- c("Korea", "China", "China",
                    "Korea","Korea", "USA")

new.cols <- data.frame(manufacturer=c("Logitech","Logitech", "Samsung",
                                      "Samsung","Samsung","Intel"))
product<- cbind(product, new.cols)
product

cols1<- data.frame(x=c("a","b","c"), y=c(1,2,3))
cols1 
cols2 <- data.frame(x=c("alpha","beta","gamma"), y=c(100,200,300))
cols2
cbind(cols1,cols2)

df1 <- data.frame(sex="female", months=1, weight=3.5)
df2 <- data.frame(sex="male", months=3, weight=4.5)
df3 <- data.frame(sex="male", months=4, weight=5.2)
df4 <- data.frame(sex="female", months=9, weight=9.4)
df5 <- data.frame(sex="female", months=7, weight=8.5)
lst <- list(df1, df2, df3,df4, df5)
lst
str(lst)
lst[[1]]
lst[1]
str(lst[[1]])
rbind(lst[[1]],lst[[2]])
do.call(rbind,lst)

lst1 <- list(sex="female", months=1, weight=3.5)
lst2 <- list(sex="male", months=3, weight=4.5)
lst3 <- list(sex="male", months=4, weight=5.2)
lst4 <- list(sex="female", months=9, weight=9.4)
lst5 <- list(sex="female", months=7, weight=8.5)
lst<- list(lst1,lst2,lst3,lst4,lst5)
lst
str(lst)
str(lst[[1]])
as.data.frame(lst[[1]])
do.call(rbind,lapply(lst, as.data.frame))

state.x77
str(state.x77)
?head
head(letters)
tail(letters)

head(state.x77)
states <-data.frame(state.x77)
str(states)
row.names(states) 
states$name <- row.names(states)
row.names(states) <- NULL
states

rich.states <- states[states$Income > 5000, c("name", "Income")]
rich.states

large.states <- states[states$Area >100000, c("name", "Area")]
large.states

merge(rich.states,large.states)
merge(rich.states,large.states, all=TRUE)

head(mtcars)
subset(mtcars, select=mpg, subset=(mpg>30))
subset(mtcars, select=c(mpg, hp, wt), subset = (cyl==4 & am ==0))
subset(mtcars, select =c(mpg, cyl,wt), subset = (mpg>mean(mpg)))
head(USArrests)
cor(USArrests)
subset(USArrests, select =-UrbanPop )
cor(subset(USArrests, select =-UrbanPop ))
cor(subset(USArrests, select =-c(UrbanPop,Rape)))

iris
head(iris)    
r<- iris$Sepal.Length / iris$Sepal.Width
r
head(r)
r<- with(iris, Sepal.Length/Sepal.Width)
head(r)
with(iris, {
  print(summary(Sepal.Length))
  plot(Sepal.Length, Sepal.Width)
  plot(Petal.Length, Petal.Width)
  })

with(iris,{
  stats <- summary(Sepal.Length)
  stats})
stats

with(iris,{
  stats.nokeep <- summary(Sepal.Length)
  stats.keep <<- summary(Sepal.Length)
})
stats.nokeep
stats.keep

iris$Sepal.Ratio <- iris$Sepal.Length/iris$Sepal.Width
head(iris$Sepal.Ratio)

iris <- within(iris, Sepla.Ratio <-Sepal.Length / Sepal.Width)
head(iris$Sepal.Ratio)

attach(iris)
search()

r <- Sepal.Length/Sepal.Width
head(r)
detach(iris)
search()

attach(iris)
iris$Sepal.Length <- 0
head(iris$Sepal.Length)
head(Sepal.Length)
deatch(iris)

attach(iris)
Sepal.Width <- Sepal.Width*10
ls()
head(Sepal.Width)
head(iris$Sepal.Width)
rm(Sepal.Width)
rm(Sepal.Length)
ls()

Sepal.Length <- c(4,5,5,3,6,7)
attach(iris)
plot(Sepal.Length, Sepal.Width)
Sepal.Length
Sepal.Width
detach(iris)

install.packages("sqldf")
library(sqldf)
data(mtcars)
sqldf("select * from mtcars where mpg >30", row.names=TRUE)
data(iris)
sqldf("select distinct Species from iris")
sqldf("select avg([Sepal.Length]) from iris where Species ='setosa'")
