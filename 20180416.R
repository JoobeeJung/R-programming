us.state<- data.frame(state.abb, state.name, state.region, state.area,
                        stringsAsFactors = FALSE)
us.state
str(us.state)

us.state[[2]]
str(us.state[[2]])
us.state[[3]]
str(us.state[[3]])         

us.state[2]
str(us.state[2])
us.state[c(2)]

us.state[c(2,4)]
us.state[2,4]

us.state[,2]
us.state[,2,drop=FALSE]
us.state[["state.name"]]
us.state$state.name
us.state[,"state.name"]

us.state[c("state.name", "state.area")]
us.state[,c("state.name", "state.area")]


id <- c("A001","A002","A003")
name <- c("Mouse", "Keyboard", "USB")
price <- c(30000,90000,50000)
product <- data.frame(id, name, price, stringsAsFactors = FALSE)
product

product <- rbind(product, c("A004", "Monitor", 250000))
product

#new.rows <- data.frame(name=("Memory","CPU"),id=c("A005", "A006"),price=(350000, 320000))

product <- cbind(product, madein=c("Korea", "China", "China", "Korea"))
product

product$madein <- c("Korea", "China", "China", "Korea")

cols1<- data.frame(x=c("a", "b", "c"))

df1 <- data.frame(sex="female", months=1, weight=3.5)
df2 <- data.frame(sex="male", months=3, weight=4.5)
df3 <- data.frame(sex="male", months=4, weight=5.2)
df4 <- data.frame(sex="female", months=9, weight=9.4)
df5 <- data.frame(sex="female", months=7, weight=8.5)
lst <- list(df1, df2, df3,df4, df5)
lst
str(lst)

lst[[1]]

rbind(lst[[1]], lst[[2]], lst[[3]], lst[[4]], lst[[5]])
lst

do.call(rbind, lst)

lst1 <- list(sex="female", months=1, weight=3.5)

str(state.x77)
head(state.x77)

states <- data.frame(state.x77)
str(states)
row.names(states)
states.name <- row.names(states)
row.names(states) <- NULL
head(states)

?merge

rich.states <- states[states[income>30000], c("Name", "Income")]

head(iris)
r <- iris$Sepal.Length / iris$Sepal.Width
head(r)

r <- with(iris, Sepal.Length / Sepla.Width)

search()
attach(iris)
search()
Sepal.Length
detach(iris)
search()
Sepal.Length

attach(iris)
detach(iris)


install.packages("sqldf")


##########1###########
##5-1
lst <- list(1:12)
mtx <- matrix(1:12, nrow=4)
length(mtx)
df <- data.frame(x=1:4, y=5:8, z=9:12)

##2
mtcars
str(mtcars)
mtcars[1:4]
mtcars[,1:4]
mtcars[-c(5,6,7,8,8,10,11)]
mtcars[c("mpg","cyl","disp","hp")]
mtcars[-(5:11)]

##3
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
sex <- factor(c("F","M","F","M","F"))
math <- c(85,76,99,88,67)
df <- data.frame(name, sex, math, stringsAsFactors =FALSE)
df

levels(df$sex)
levels(df$sex) <- c("M","F")
df
str(df)

##4
stat <- c(76,73,95,82,55)
#a
df
df <- cbind(df, stat)
#b
str(df)
df$score <- with(df, round((math+stat)/2,1))
df#score <- round((df$math + df$stat)/2,1)
#c
dfgrade[df$score >= 90] <- "A"
dfgrade[df$score >= 80 & df$score <90] <- "B"

df$grade <- factor(df$grade, levels = c("A", "B", "C. "D"))
str(df)
