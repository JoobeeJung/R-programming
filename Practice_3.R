v <- 1:12
dim(v) <- c(3,4)
v

matrix(data = v, nrow = 3, ncol = 4)
matrix(v,3,4,byrow = TRUE)

rnames <- c("Ri", "R2","R3")
cnames <- c("c1", "c2", "c3", "c4")
matrix(v,3,4,dimnames = list(rnames,cnames))
matrix(0,3,4)
matrix(NA, nrow = 3, ncol = 4)
matrix(v, ncol = 4)
mat <- matrix(v,3,4)
str(mat)
dim(mat)
nrow(mat)
ncol(mat)
length(mat)

v1 <- c(1,2,3,4,5)
v2 <- c(6,7,8,9,10)
rbind(v1,v2)
cbind(v1,v2)

cbind(1:3, 4:6, matrix(7:12,3,2))
rbind(matrix(1:6, 2,3), matrix(7:12, 2, 3))

v <- 1:12
mat <- matrix(v,3,4)
mat
mat[1,]
mat[,1]
mat[1,,drop=FALSE]
mat[,1,drop=FALSE]
mat[1,3]
mat[2:3,]
mat[,3:4]
mat[1:2,2:3]
mat[c(1,3),]
mat[,-c(2,3)]
mat[1,3]<-77
mat
mat[2,] <- c(22,55)
mat
mat[2:3, 3:4] <- c(1,2,3,4)
mat

city.distance <- c(0, 331, 238, 269, 195,
                   331, 0,95, 194,189,
                   238, 95,0,171,130,
                   269,194,171,0,77,
                   195,189,130,77,0)
city.distance.mat <- matrix(city.distance,5,5,byrow = TRUE)

colnames(city.distance.mat) <- c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju")
rownames(city.distance.mat) <- c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju")
city.distance.mat
dimnames(city.distance.mat) <- list(c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju"),
                                    c("Seoul", "Busan", "Daegu", "Gwangju", "Jeonju"))
dimnames(city.distance.mat)

city.distance.mat["Seoul","Busan"]
city.distance.mat[,"Seoul"]
city.distance.mat[c("Seoul", "Gwangju"),]

w <- c(1,2,3,4,5,6)
mtx <- matrix(w,2,3)
mtx
mtx +1
mtx -1
mtx *2
mtx/2

a<-matrix(1:6,2,3)
b<-matrix(6:1,2,3)
matrix(1:6,2,3) + matrix(6:1,2,3)
a-b
a*b
a
b
a/b
matrix(1:6,2,3) + matrix(6:1,3,2)
a%*%matrix(6:1,3,2)

w <- 1:6
matrix(w,2,3)
matrix(w,3,2)
matrix(w,2,3) %*% matrix(w,3,2)

mtx <- matrix(1:6,2,3)
mtx
mtx %*% 1:3
1:2 %*% mtx

mtx <- matrix(1:6, 2,3)
mtx
mtx + 1:3
rowSums(mtx)
colSums(mtx)
rowMeans(mtx)
colMeans(mtx)
mtx <- matrix(1:6,2,3)
mtx
t(mtx)
1:5
t(1:5)
matrix(1:5)

mtx <- matrix(1:6,2,3)
mtx
mtx[2,]
t(mtx[2,])

a<- 1:24
dim(a)<- c(3,4,2)
a
dim(a)
a
ary <- array(1:12,c(2,3,2))
ary
ary[1,3,2]
ary[,1,2]
ary[,1,2,drop=FALSE]
ary
ary[2,,,drop=FALSE]
