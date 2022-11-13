v <- (1:12)
v
dim(v) <- c(3,4)
v

v<- c(1:12)
matrix(data = v, nrow = 3, ncol = 4)

matrix(v, 3,4,byrow = TRUE) #행의 방향으로 데이터를 채우고 싶을때 , 인수 이름을 지정하지 않아도 괜찮음
#함수에서 지정한 인수대로 값을 지정할 경우 생략 가능 

?matrix

rnames <- c("Ri", "R2", "R3")
cnames <- c("C1", "C2", "C3", "C4")
matrix(v,3,4, dimnames = list(rnames, cnames))

matrix(0,3,4)
matrix(NA, 3, 4)

matrix(v, ncol=4)

mat <- matrix(v, 3,4)
str(mat) #이거 이해 안됨 .... 밑에 꺼랑 차이 뭐임 ,,
str(v)
dim(mat)

dim(mat)[1]
dim(mat)[2]
nrow(mat)
ncol(mat)

length(mat)

v1 <- c(1,2,3,4,5)
v2 <- c(6,7,8,9,10)
v1;v2
rbind(v1, v2)
cbind(v1, v2)

cbind(1:3, 4:6, matrix(7:12, 3, 2))
rbind(matrix(1:6, 2, 3), matrix(7:12, 2, 3))
cbind(matrix(1:6, 2, 3), matrix(7:12, 2, 3))

###############

v <- c(1:12)
mat <- matrix(v, 3, 4)
mat
mat[1,]
mat[,3]

mat[1, ,drop=FALSE]
mat[,3,drop=FALSE]

mat[2:3,]
mat[, 3:4]
mat[1:2, 2:3]
mat[c(1,3),]

mat[,-c(2:3)]
mat[1,3] <- 77
mat

mat[2,] <- c(22,55)
mat

mat[2:3, 3:4] <- c(1,2,3,4)
mat

city.distance <- c(0,331,238,259,195,
                   331,0,95,194,189,
                   238,95,0,171,130)
mat <- matrix(city.distance, 2, 5, byrow=TRUE)
mat

w <- c(1,2,3,4,5,6)
mtx <- matrix(w, 2,3)
mtx
mtx +1
mtx -1


t(1:5)
mtx <- matrix(c(1,2,3,4,5,6),2,3)
mtx

a <- 1:24
a
dim(a) <-c(3,4,2)
dim(a)
a

ary <- array(1:12, c(2,3,2))
ary
ary[1,3,2]
ary[,3,2]
ary[,3,2,drop=FALSE]
ary[2,,,drop=FALSE]

############연습문제

#1.
mtx <- matrix(1:12,3,4)
mtx
dimnames(mtx) <- list(letters[1:3], letters[1:4])
mtx

mtx <- matrix(1:12, nrow = 3, ncol=4, dimnames=list)
mtx

#2

mtx <- matrix(1:12, 3, 4)
mtx
a <- mtx[,c(1,3)]
a
b <- mtx[,c(2,4)]
b
mtx.c <- cbind(a, b)
mtx.c


mtx.c <- cbind(mtx[,c(1,3), mtx[,c(2,4)]])

#3

3*mtx
mtx+3
mtx+mtx.c
mtx-mtx.c
mtx * mtx.c
mtx/mtx.c
mtx %*% mtx.c


#4
matrix(1:4, nrow=2)^(1:4)

#5
x <- 1:10
mtx <- cbind(x1=x,x2=x*2, x3=x*3, x4=x*4, x5=x*5)
rownames(mtx)

#7
x <- c(1:3) #숫ㅈ
y <- x^2 #숫자 
z <- letters[1:3] #문자 
mtx <- cbind(x,y,z) #숫자와 문자 벡터가 합쳐지면 문자로 됨.
mtx
