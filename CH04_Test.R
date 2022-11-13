#####1#####
length(list(list(alpha=pi,beta=sqrt(pi)),gamma=letters,delta=NULL))
length(list(alpha=pi, betat=sqrt(pi), gamma=letters, deltat=NULL))

#####2########
lst <- list(c(3,5,7), c("A","B","C"))
lst[[2]][[1]] <- "Alpha"
lst

#####3#######
mean(unlist(list(math=list(95,90), writing=list(90,85), reading=list(85,80))))

####4######
lst.a<- list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
lst.a
lst.a[[1]] <- lst.a[[1]] +1
lst.a

#####5######
lst.b <- list(L=letters[1:5], M=month.name[1:5])
lst.b[2]
lst.b[[2]][-3]

####6#######
lst <- list(month.name, month.abb)
lst
##a
lst <- list(mon.name=month.name, mon.abb=month.abb)
lst
##b
length(lst$mon.name) + length(lst$mon.abb)
##c
lst$mon.num <- 1:12
lst
lst[[3]] <- NULL
lst

######7#####
lst1 <- list("X", "Y", "Z", "x", "y", "z")
lst2 <- list("x", "y", "z")
setdiff(lst1,lst2)

######8#######
lst.8 <- list(a=1, b=2,pi)
lst.8
#lst.8$c <- pi
##lst.8
#lst.8[[3]]

#####9#####
lst <- list(first=1, second=2, third=list(third.one=3.1, third.two=3.2))
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
lst[["third"]][["third.one"]]
lst[[c("third", "third.one")]]
lst[["third"]]$third.one
lst[[3]][[1]]
lst[[3]]["third.one"]

#####10#######
lst <- list("Apple", NULL, "Orange")
#lst
##lst[[2]] <- NULL
#lst
#lst[2] <- NULL
lst[sapply(lst, is.null)] <- NULL
lst

########11#########
v <- c()
v
lst <- list(-2.4, 0.4, 5.7, 12.5, 17.8, 22.2, 24.9,25.7,21.2,14.8,7.2, 0.4)
lst
names(lst) <- c(month.abb)
lst
#a
lst[lst<0]
#b
mean(unlist(lst))
lst[lst<mean(unlist(lst))]
#c
lst[lst<mean(unlist(lst))] <- NULL
lst
