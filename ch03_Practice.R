v<- 1:12
rnames <- c("R1","R2","R3")
cnames <- c("C1","C2","C3","C4")
matrix(v, 3,4,dimnames=list(rnames,cnames))

city.distance <- c(0, 331, 238, 269, 195,
                   331, 0, 95, 194, 189,
                   238, 95, 0, 171, 130,
                   269, 194, 171, 0, 77,
                   195, 189, 130, 77, 0)
city.distance.matrix <- matrix(city.distance, 5, 5, byrow = TRUE)
city.distance.matrix

colnames(city.distance.matrix) <- c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju")
rownames(city.distance.matrix) <- c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju")
city.distance.matrix

dimnames(city.distance.matrix) <- list(c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju"),
                                       c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju"))
city.distance.matrix["Seoul",]
city.distance.matrix[c("Seoul", "Busan"),]

##1
mtx <- matrix(1:12, 3, 4)
mtx
dimnames(mtx) <- list(letters[1:3],letters[1:ncol(mtx)])
colnames(mtx) <- c(letters[1:ncol(mtx)])
rownames(mtx) <- c(letters[1:nrow(mtx)])
mtx

##2
mtx1 <- mtx[,c(1,3)]
mtx2 <- mtx[,c(2,4)]
mtx.c <- cbind(mtx1, mtx2)
mtx.c

##3
mtx
3*mtx
mtx+3
mtx + mtx.c
mtx - mtx.c
mtx * mtx.c
mtx/ mtx.c
mtx %*% mtx.c

##4
matrix(1:4, nrow = 2) ^ (1:4)
##5
a <- matrix(1:10, ncol=1)
b <- a*2
c <- a*3
d <- a*4
e <- a*5
x <- cbind(a,b,c,d,e)
x
rownames(x) <- letters[1:nrow(x)]
x
sum(x["h",])

##6
y <- matrix(1:9999, ncol=9)
z <- matrix(NA, 3,2)
#base <- matrix()
y[(nrow(y)-2):nrow(y), (ncol(y)-1):ncol(y)]
#y[1109:1111, 8:9]
#y[n row(y)-2:nrow(y),]
#row(z) = y[1109:1111]
# ncol(y)-1:ncol(y))
dim(y)
z <- y[(dim(y)[1]-2):dim(y)[1], (dim(y)[2]-1):dim(y)[2]]
z

##7
x <- c(1:3)
y <- x^2
z <- letters[1:3]
mtx <- cbind(x,y,z)
x
y
z
mtx
is.numeric(mtx[,1])
is.numeric(mtx[,2])
is.character(mtx[,3])

##8
mtx <- matrix(1:12, 3,4)
t(t(mtx))
mtx

?diag
example(diag)
diag(ncol(mtx))
  
diag(3)
diag(4)
diag(5,3)

##9
mtx <- matrix(1:10000, 1000)
mtx
mtx[777,3]

##10
v <- c(0.43, 0.49, 0.08,
       0.04, 0.72, 0.24,
       0.01, 0.52, 0.47)
a <- matrix(v,3,3, byrow = TRUE)
a
#dimnames(a) = c("lower","middle","upper"),c("lower","middle","upper")
dimnames(a) <- list(c("lower","middle","upper"),c("lower","middle","upper"))
rownames(a) <- c("lower","middle","upper")
colnames(a) <- c("lower","middle","upper")
a
#b
#rowsum(a)
#example("rowsum")
rowSums(a)

#c
b <- a%*%a
b
#d
rownames(b) <- c("lower","middle","upper")
colnames(b) <- c("lower","middle","upper")
b
b[,"upper"]
