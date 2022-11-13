v1 <- c("A001", "A002", "A003")
v2 <- c("Mouse", "keyboard", "USB")
v3 <- c(30000, 90000, 50000)
product <- data.frame(v1, v2, v3)
product
product <- data.frame(row.names = v1, v2, v3)
product
rownames(product)
product <- data.frame(id=v1, name=v2, price=v3)
product
str(product)
product <- data.frame(id=v1, name=v2, price=v3, stringsAsFactors = FALSE)
str(product)

mat <- matrix(c(1,3,5,7,9,
                2,4,6,8,10,
                2,3,5,7,11), ncol=3)
mat
number <- as.data.frame(mat)
colnames(number) <- c("odd","even", "prime")
number
number

lst <- list(v1, v2, v3)
lst
as.data.frame(lst)
product <- as.data.frame(lst)
colnames(product) <- c("id", "name", "price")
product
nrow(product)

ncol(product)
length(product)

us.state <- data.frame(state.abb, state.name, state.region, state.area,
                       stringsAsFactors = FALSE)
us.state
str(us.state)
us.state[[2]]
str(us.state[[3]])
us.state[2]
head(us.state[c(2,4)])
head(us.state[,c(2,4)])
us.state[,2, drop=FALSE]
us.state[,c(2,4)]

id <- c("A001", "A002", "A003")
name <- c("Mouse", "keyboard", "USB")
price <- c(30000, 90000, 50000)
product <- data.frame(id, name, price, stringsAsFactors = FALSE)
str(product)
product <- rbind(product, c("A004","monitor",250000))
product <- rbind(product,c("A004","Monitor",250000))
product
new.rows <- data.frame(id=c("A005", "A006"),
                       name=c("Memory","CPU"),
                       price = c(35000,320000), stringsAsFactors = FALSE)
new.rows
str(new.rows)
product <- rbind(product,new.rows)

product <- cbind(product, madein=c("Korea", "China", "China","Korea", "Korea", "USA"))

product
str(product)
product$madein <-c('Korea',"China", "China", "Korea", "Korea","USA")
