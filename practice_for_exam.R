lst1 <- list("X","Y","Z","x","y","z")
lst2 <- list("x","y","z")

setdiff(lst1, lst2)

v <- pi
w <- 10/3
v==w
v!=w
v>w
v<w
!(v>w)
(v==w)|(v<w)
(v==w)&(v<w)
isTRUE(v==w)

as.numeric(TRUE)
as.numeric(FALSE)

a <- -3:3
abs(a)
any(a)
all(a)

sqrt(2)^2 ==2
sqrt(2)^2 -2
identical(sqrt(2)^2, 2)

all.equal(sqrt(2)^2, 2)
all.equal(sqrt(2)^2, 3)
isTRUE(all.equal(sqrt(2)^2, 3))

fruit <- c("Apple", "Banana", "Strawberry")
food <- c("Pie", "Juice", "Cake")
paste(fruit, food)
paste(fruit, "Juice")

log(1:5, 3)
log(1:5)
log(1:5, 10)
log(1:5, base = exp(1))
?exp
log(1:5, 2)
exp(1:5)

factorial(5)
factorial(1:5)
choose(5,2)
choose(10,3)
?choose
example(choose)
choose(10,2)
sqrt(1:5)
options("digits")
signif(pi, digits = 2)
signif(pi, digits = 1)
signif(457.789, 2)
signif(457.789, 3)
signif(457.789, 4)
round(457.789, 2)
round(457.789, 3)
round(457.789, 1)


round(456.789, -2)
round(556.789, -2)
round(456.789, -1)

round(11.5)
round(11.4)
round(12.5)
signif(11.5)
round(-5.5)
round(-5.4)
round(-6.5)
round(-6.7)

floor(512.5)
floor(512.1)
floor(512.9)
floor(-512.9)

ceiling(512.5)
ceiling(512.1)
ceiling(512.9)
ceiling(-512.9)
trunc(512.5)
trunc(512.9)
trunc(-512.9)

3/0
3/Inf

is.infinite(3/0)
z <- 1:10
mean(z)
median(z)
range(z)
var(z)
sd(z)
cumsum(z)
cumprod(z)
cummax(z)
cummin(z)

p <- 1:10
q <- 6:15
union(p,q)
intersect(p,q)
setdiff(p,q)
is.element(setdiff(p,q),q)
setequal(p,q)
all.equal(p,q)
isTRUE(all.equal(p,q))

eval <- c("Medium", "Low", "High", "Medium", "High")
eval.factor <- factor(eval)
eval.factor
eval.ordered <- factor(eval, levels = c("High", "Medium", "Low"), ordered = TRUE)
eval.ordered
eval.ordered <- factor(eval, levels = c("Low", "Medium", "High"), ordered = TRUE)
eval.ordered
