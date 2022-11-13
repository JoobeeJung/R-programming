#1
lst1 <- list(list(alpha=pi, beta=sqrt(pi)), gamma=letters, deltat=NULL)
lst2 <- list(alpha=pi, beta=sqrt(pi), gamma=letters, delta=NULL)
length(lst1)
length(lst2)

##2
a <- list(c(3,5,7), c("A","B","C"))
a[[2]][[1]] <- "Alpha"
a

##3
mean(unlist(list(math=list(95,90), writing=list(90,85), reading=list(85,90))))

##4
x <- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
x[[1]] +1

##5
y <- list(L=letters[1:5], M=month.name[1:5])
y[[2]][-3]

##6
lst <- list(month.name, month.abb)
lst
#a
names(lst) <- list("mon.name", "mon.abb")
lst
#b
length(lst$mon.name) + length(lst$mon.abb)
#c
lst$mon.num <- 1:12
lst

##7
lst1 <- list("X","Y","Z","x","y","z")
lst2 <- list("x","y","z")
setdiff(lst1, lst2)

##8
x <- list(a=1, b=2, pi)

x
pi
list(pi)
x[[3]]

x <- list(a=2, b=2)
y <- pi
z <- c(x, y)
z

##9
lst <- list(first=1, second=2, third=list(third.one=3.1, third.two=3.2))
lst
#a
lst[1:2]
lst[-3]
lst[c("first", "second")]
lst[c(TRUE, TRUE, FALSE)]
lst[1,2]

#b
lst$second
lst$s
lst[[2]]
lst[["second"]]
lst[["s"]]

#c
lst[['third']][['third.one']]
lst[[c("third", "third.one")]]
lst[["third"]]$third.one
lst[[3]][[1]]
lst[[3]]["third.one"]

##10
a <- list("Apple", NULL, "Orange")
a
a[[2]] <- NULL
a
lst[sapply(lst, is.null)] <- NULL

##11
lst <- list(-2.4, 0.4, 5.7, 12.5, 17.8, 22.2, 24.9, 25.7, 21.2, 14.8, 7.2, 0.4)
lst
names(lst) <- month.abb
lst
#a
lst[lst<0]
#b
lst[lst < mean(unlist(lst))]
#c
lst[lst < mean(unlist(lst))] <- NULL
lst
 