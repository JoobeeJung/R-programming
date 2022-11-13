lst <- list(0.6826, 0.9544, 0.9974, 1:100)
lst

lst<- list(1.23, "Apple", c(2,3,5,7), matrix(1:6, ncol=3), mean)
lst

lst <- list()
lst
lst[[1]] <- 1.23
lst[[2]] <- "Apple"
lst[[3]] <- c(2,3,5,7)
lst[[4]] <- matrix(1:6, ncol=3)
lst[[5]] <- mean
lst

lst <- list(0.6826, 0.9544, 0.9974)
lst
names(lst) <- c("sgima1", "sigma2","sigma3")
lst

names(lst)

lst <- list(sigma1=0.6826, sigma2=0.9544, z=letters)
lst
names(lst)
length(lst)

##############2################

product <- list("A001", "Mouse", 30000)
product

product[[3]]
product[3]

class(product[[3]])
class(product[3])

product[[3]]*0.9
product[3] *0.9

product[3]
product[c(3)] #위의 꺼랑 동일한 명령

product[c(1,2)] #첫번째 주머니와 두번째 주머니를 출

product[c(FALSE, TRUE, TRUE)]
product[-1]

product <- list(id="A001", name="Mouse", price=30000)
product

product[["name"]] #괄호가 두개인 경우 주머니 내의 값만 나옴 
product$name

product[c("name", "price")]
product["name"] #괄호가 하나일 경우는 주머니 자체가 나옴 

product[["fourth"]]
product$fourth
product[[4]]

product[c(4,2,5)]
product[c("fourth", "name", "fifth")]

lst <- list(one=1, two=2, three=list(alpha=3.1, beta=3.2))
lst

lst[["three"]]
lst$three

lst[["three"]][["alpha"]]
lst$three$alpha

lst[["three"]]["beta"]

product
product[[3]] <- 50000
product

product[[3]] <- c(40000, 50000)
product[3] <- list(c(40000, 50000))
product

product[1:3] <- list("A002", "Keyboard", 90000)
product

product[[4]] <- c("Domestic", "Export")
product

product$madein <- c("Korea", "China")
product[["madein"]] <- c("Korea", "China")
product["madein"] <- list(c("Korea", "China"))
product

product[6:9] <- list(0.12, 0.15, 0.22, 0.27)
product[6:9] <- c(0.12, 0.15, 0.22, 0.27)

names <- c("Mon", "Tue", "Wed")
values<- c(842, 729, 800)
traffic.death <- list()
traffic.death
traffic.death[names] <- values
traffic.death

traffic.death[["Mon"]] <- NULL
traffic.death

traffic.death < 750
traffic.death[traffic.death < 750] <- NULL
traffic.death

worldcup1 <- list("Brazil", "Germany")
worldcup2 <- list("Korea", "USA")
c(worldcup1, worldcup2)

rainfall <- list(21.6, 23.6, 45.8, 77.0, 102.2, 133.3,
                 327.9, 348.0, 137.6, 49.3, 53.0, 24.9)
rainfall
mean(rainfall)
mean(unlist(rainfall))
unlist(rainfall)
min(rainfall)
max(rainfall)

#d연습문제1

length(list(list(alpha=pi, beta=sqrt(pi)),gamma=letters, delta=NULL))
length(alpha=pi, beta=sqrt(pi), gamma=letters, delta=NULL))

#2 
lst <- list(c(3,5,7), c("A", "B", "C"))
lst
lst[[2]][1] <- "Alpha"
lst

#3
lst <- list(math=list(95, 90), writing=list(90, 85), reading=list(85,80))
lst
unlist(lst)
mean(unlist(lst))

#4
lst <- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
lst
lst$alpha +1

#5
lst <- list(L=letters[1:5], M=month.name[1:5])
lst
lst[[2]]
lst$M[-3]

lst[[2]][3] <- NULL

a <- c(1,2,3)
a[1] <- NULL

#6
  
lst <- list(month.name, month.abb)
lst
names(lst) <- c("mon.name", "mon.abb")
lst

length(lst$mon.name) + length(lst$mon.abb)

lst$mon.num <- 1:12
lst

#7

lst1 <- list("X","Y","Z","x","y","z")
lst2 <- list("x", "y", "z")
setdiff(lst1,lst2)

#8
lst <- c(list(a=1, b=2), pi)
lst

#lst<- list(a=1, b=2)
#lst[3] <- "pi"
lst[[3]]


#9
lst <- list(first=1, second=2, third=list(third.one=3.1, third.two=3.2))
lst

#10

lst<-list("Apple", NULL, "Orange",NULL, NULL, NULL, NULL)
lst
lst[sapply(lst, is.null)] <- NULL
lst
lst[[2]] <-NULL
lst

#lst[sapply(lst, is.null)] <- NULL #데이터분석 시 방대한 양속에서 NULL의 위치를 일일히 찾기 어렵기때문에 
#lst

#11

