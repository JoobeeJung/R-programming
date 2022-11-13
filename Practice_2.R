demo(graphics)

example("Titanic")

fortune()
help.fortune

c(1,2,3,4,5,6,7,8,9,10)
c("We", "love", "Data Analytics")
c(TRUE, FALSE, TRUE, FALSE)

odd <- c(1,3,5)
even <- c(2,4,6)
c(odd, even)

3:9
5:-3

seq(from=3, to=9)
seq(from=3, to=9, by=2)
seq(from=3.5, to=1.5, by=-0.5)

seq(from=0, to=100, length.out = 5)
seq(from=-1, to=1, length.out = 5)

rep(1, times=3)
rep(c(1,2,3), times=3)
rep(c(1,2,3), each=3)
rep(c(1,2,3), times=c(1,2,3))
rep(1:3, length.out=8)

num <- c(1,2,3)
cha <- c("X", "Y", "Z")
c(num, cha)
num <- c(1,2,3)
cha <- c("X", "Y", "Z")
str(num)
str(cha)

length(num)

LETTERS
letters
month.abb
month.name
pi
month <- c(12,9,3,5,1)
month.name[month]

1+2
2^10
10%%3
1+2
"+"(1,2)
c(1,2,3)+ c(4,5,6)
x <- c(1,2,3)
x * c(4,5,6)
y <- c(10,20,30)
y/c(2,4,6)
y %% c(3,5,7)
y%/% c(3,5,7)

x <- c(1:3)
x
y<- c(4:9)
y
x+y
c(1,3,5) + 10
c(1,2,3) + c(4,5,6,7,8)

v <- pi
w <- 10/3
v == w
v != w
v > w
v < w
! (v>w)

(v==w) | (v<w)
(v==w) & (v<w)
isTRUE(v == w)

y <- c(0, 25, 50, 75, 100)
z <- c(50, 50, 50, 50, 50)

y == z
y != z
y>z
y<z

y<- c(0,25,50,75,100)
y == 50
y > 50

as.numeric(TRUE)
as.numeric(FALSE)
TRUE * TRUE
TRUE * FALSE
TRUE + TRUE

y <- c(0, 25, 50, 75, 100)
sum(y >50)

a <- -3:3
a
any(a>0)
all(a<0)

sqrt(2)^2 ==2
sqrt(2)^2 -2
identical(sqrt(2)^2, 2)

all.equal(sqrt(2)^2, 2)
all.equal(sqrt(2)^2, 3)
isTRUE(all.equal(sqrt(2)^2, 3))
isTRUE(all.equal(sqrt(2)^2, 2))

fruit <- c("Apple", "Banana", "Strawberry")
food <- c("Pie", "Juice", "Cake")
paste(fruit, food)
paste(fruit, "Juice")

x <- -3:3
abs(x)

log(1:5, base=3)
log(1:5)
log(1:5, base=exp(1))

exp(1:5)
y <- exp(1:5)
log(y)

factorial(1:5)
choose(5,1)


month <- c(12, 9, 3, 1)
month.name[month]

1+2
2^10
10%%3
"+"(1,2)
y <- c(10,20,30)
y/ c(2,4,6)

as.numeric(TRUE)
as.numeric(FALSE)
y<- c(0,25,50,75,100)
sum(y>50)

a<- -3:3
a
any(a>0)
all(a>0)

sqrt(2)^2 ==2
sqrt(2)^2 -2
identical(sqrt(2)^2, 2)

all.equal(sqrt(2)^2,2)
all.equal(sqrt(2)^2,3)
isTRUE(all.equal(sqrt(2)^2,3))

fruit<- c("Apple", "Banana", "Strawberry")
food <- c("Pie", "Juice", "Cake")
paste(fruit,food)
fruit + food
paste(fruit, "Juice")
paste(fruit, "smoothy")

x<- -3:3
abs(x)

log(1:5, base=3)
log(1:5)
log(1:5, base=exp(1))

log2(1:5)
log2(1:5)
log(1:5, 2)
log10(1:5)
log(1:5, 10)

y<- exp(1:5)
y
log(y)

factorial(1:5)
choose(5,2)
sqrt(1:5)
options("digits")
pi*100
signif(456.29,2)
signif(456.789, 3)
signif(456.890, 4)

round(456.789, digits=2)
round(456.789, digits=0)
round(456.789, digits=1)
round(456.789, digits=3)
round(456.789, digits=-1)
round(456.789, digits=-2)
round(456.789, digits=-3)
round(11.5)
round(11.4)
round(11.5)
round(12.5)
round(12.5)
round(12.4)
floor(12.3)
floor(12.5)
ceiling(12.5)
trunc(11.2)
trunc(11.9)
3/0
5-Inf
is.infinite(0)
is.infinite(-Inf)
is.infinite(10^(305:310))
Inf/Inf
Inf *0
log(-2)
is.nan(NaN+3)

is.na(NaN)
z<-1:5
sum(z)
min(z)
max(z)
z<- 1:5
mean(z)
median(z)
range(z)
var(z)
sd(z)

w <- c(1,2,3,4,5,NA)
sum(w)
sum(w, na.rm = TRUE)

w<- c(1,2,3,4,5,NA)
sum(w)
sum(w, na.rm=TRUE)
sum(na.omit(w))
v<-c(NA,NA,NA,NA,NA)
sum(v, na.rm = TRUE)
prod(v, na.rm=TRUE)
max(v, na.rm = TRUE)
min(v, na.rm=TRUE)

traffic.death <- c(842, 729, 786, 751, 844, 851, 702)
diff(traffic.death)
cumsum(traffic.death)

u <- c(3,5,1, NA,2)
diff(u)
cumsum(u)

diff(1:5, lag=2)
diff(1:5, lag=1)
diff(1:5, lag=3)

p<- 1:10
q <- 5:15
union(p,q)
intersect(p,q)
setdiff(p,q)

num <- 0:50
num
prime <- c(2,3,5,7,11,13,17,19)
prime
num[prime]
prime[2]
prime[3:9]

prime <- c(1,3,5,7,11,13,17,19)
prime[c(1,2,6,6)]
indices <- c(1,3,5,7)
prime[indices]
prime[-1]
prime[-(1:4)]
length(prime)
prime[1:length(prime)-1]

prime[2]<-5
prime
prime[c(2:5)] <- c(77:80)
prime
prime < 10
prime[prime<10]
prime[prime %%2 == 0]

seq_along(prime)
prime
length(prime)
?seq_along
prime[seq_along(prime) %% 2==0]
prime[seq_along(prime) %% 3==0]
prime
prime[c(FALSE, TRUE)]
prime[c(FALSE, FALSE, TRUE)]

rainfall <- c(21.6, 23.6, 45.8, 77.0, 102.2, 133.3, 327.9, 348.0, 137.6, 49.3,53.0, 24.9)
month.abb[rainfall]
rainfall >100
month.abb[which(rainfall>100)]
month.name[which.max(rainfall)]
month.name[which.min(rainfall)]

rainfall[rainfall>100]
rainfall[which.min(rainfall)]
rainfall[which.max(rainfall)]

names(rainfall) <- c("1","2","3","4","5","6","7","8","9","10","11","12")
rainfall
rainfall[rainfall>100]

traffic.death <- c(842, 720, 780, 750, 844, 851, 702)
names(traffic.death) <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
names(traffic.death)
traffic.death["Thu"]
weekend <- c("Fri","Sat","Sun")
traffic.death[weekend]
names(traffic.death[traffic.death>800])

review <- c("Good", "Good", "indifferent", "Bad", "Good", "Bad")
review
review.factor <- factor(review)
str(review.factor)
as.numeric(review.factor)
levels(review.factor)
levels(review.factor) <- c("B", "G", "I")
review.factor
nlevels(review.factor)
length(levels(review.factor))

eventday <- c("Mon", "Mon", "Tue", "Wed", "Mon", "Wed", "Thu", "Fri", "Tue")
eventday.factor <- factor(eventday)
str(eventday.factor)
eventday.factor <- factor(eventday, levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

eval <- c("Medium", "Low", "High", "Medium", "High")
eval.factor <- factor(eval)
str(eval.factor)
levels(eval.factor)
eval.ordered <- factor(eval, levels = c("Low", "Medium", "High"), ordered=TRUE)
table(eval.ordered)
table(eval.factor)

sex <- c(2,1,2,2,1,0)
sex.factor <- factor(sex, levels = c(1,2), labels = c("Male", "Female"))
levels(sex.factor) <- c("M", "F")
table(sex.factor)
