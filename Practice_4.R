lst <- list(0.6826, 0.9544, 0.9974)
lst

lst <- list(1.23, "Apple", c(2,3,5,7), matrix(1:6,ncol = 3), mean)
lst

lst <- list()
lst
lst[[1]] <- 1.23
lst[[2]] <- "Apple"
lst[[3]] <- c(2,3,5,7)
lst[[4]] <- matrix(1:6, ncol=3)
lst[[5]] <- mean

lst <- list(0.6826, 0.9544, 0.9974)
names(lst) <- c("sigma1", "sigma2", "sigma3")
lst
lst <- list(sigmal=0.6826, sigma2=0.9544, sigma3=0.9975)
lst
names(lst)
length(lst)

product <- list("A001", "Mouse", 3000)
product
product[3]
product[[3]]

class(product[[3]])
class(product[3])

product[[3]] * 0.9
product[3] * 0.9

product[c(1,2)]
product[c(FALSE, TRUE, TRUE)]
product[-1]

product <- list(id="A001", name="Mouse", price="30000")
product
product[["name"]]
product$name
product[c("name", "price")]
product["name"]
product[["forth"]]
product$forth
product[[4]]

product[c(4,2,5)]
product[c("forth", "name", "fifth")]

lst <- list(one=1, two=2, three=list(alpha=3.1, beta=3.2))
lst
lst[["three"]]
lst["three"]
lst[["three"]][["beta"]]
lst[["three"]]["beta"]
lst$three$beta

product<- list(id="A001", name="Mouse", price=30000)
product[[3]] <- 40000
product
product[3] <- 50000
product[["price"]] <- 40000
product$price <- 40000

product[[3]] <- c(40000,60000)
product
product[3] <- list(c(40000, 50000))
product

product[1:3] <- list("A002", "mouse", 30000)
product

product[[4]] <- c("Domestic", "Export")
product
product$madein <- c("Korea", "China")
product[["madein"]] <- c("Korea", "China")
product["madein"] <- list(c("Korea", "China"))
product$mdaein <- NULL
product

product[6:9] <- list(0.12,0.15,0.22,0.27)
product[6:9] <- c(0.12, 0.15,0.22,0.27)
product

names<-c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
values <- c(842, 729, 786, 751, 844, 851, 702)
traffic.death <- list()
traffic.death
traffic.death[names] <- values
traffic.death
traffic.death[["Fri"]] <- NULL
traffic.death[c("Sat", "Sun")] <- NULL
traffic.death
traffic.death < 750
traffic.death[traffic.death<750] <- NULL
traffic.death

worldcup1 <- list("Brazil", "South Africa", "Germany")
worldcup2 <- list("Korea-Japan", "France", "USA")
c(worldcup1, worldcup2)

rainfall <- list(21.6, 23.6, 45.8, 77.0, 102.2, 133.3, 327.9,348.0, 137.6, 49.3, 53.0,24.9)
mean(unlist(rainfall))
min(unlist(rainfall))
max(unlist(rainfall))
