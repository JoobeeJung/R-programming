#####1######
mtx <- matrix(1:12, 3,4)
mtx
##dimnames(mtx) <- (list(letters[nrow(mtx)],letters[ncol(mtx)])
a <- letters[1:nrow(mtx)]
b <- letters[1:ncol(mtx)]
dimnames(mtx) <- list(a,b)
mtx

#####2########
x <- mtx[,c(1,3)]
y <- mtx[,c(2,4)]
mtx.c <- cbind(x,y)
mtx.c

#######3###########
3*mtx
mtx+3
mtx+mtx.c
mtx-mtx.c
mtx *mtx.c
mtx/mtx.c
mtx%*%mtx.c

#########4#########
matrix(1:4,nrow = 2)^(1:4)

########5########
a <- matrix(1:10, ncol = 1)
a
b <- a*2
b
c <- a*3
d <- a*4
e <- a*5
m <- cbind(a,b,c,d,e)
rownames(m)<- c(letters[1:10])
m
sum(m["h",])

#####6######
v <- 1:9999
mtx <- matrix(v,ncol = 9)
mtx.sub <- mtx[(dim(mtx)[1]-2):dim(mtx)[1], (dim(mtx)[2]-1):dim(mtx)[2]]
mtx.sub
#z <- matrix(1:9999,,ncol=9)
#z
#z.sub <- z[dim(z)[1]-2:dim(z)[1], dim(z)[2]-1:dim(z)[2]]
z.sub

####7#####
x <- c(1:3)
y <- x^2
z <- letters[1:3]
mtx <- cbind(x,y,z)
mtx
is.numeric(mtx[,1])
is.numeric(mtx[,2])
is.character(mtx[,3])

#####8#######
mtx <- matrix(1:12,3,4)
mtx
t(t(mtx))
mtx %*% matrix(1,ncol(mtx))
mtx*1
mtx %*% diag(ncol(mtx))
?diag
dim(diag(3))
diag(10,3,4)

######9######
mtx <- matrix(1:10000, 1000)
mtx[777,3]

#####10#########
##a
v <- c(0.43, 0.04, 0.01, 0.49, 0.72, 0.52, 0.08, 0.24, 0.47)
mtx <- matrix(v, 3,3)
mtx
dimnames(mtx) <- list(c("lower", "middle","upper"),c("lower", "middle","upper"))
mtx
##b
#sum(mtx[1,])
#sum(mtx[2,])
#sum(mtx[3,])
rowSums(mtx)
##c
second.m <- mtx %*% mtx
second.m
##d
#second.m[1,3]
#second.m[2,3]
#second.m[3,3]
second.m[,"upper"]
