##1
1:10
10:1
c(1:10) + c(9:1)
c(1:10,9:1)

##2
x <- c(1:10)
y <- c(3:1)
#a
names(x) <- letters[x]
x
#b
x+y
sum(x,y)

#3
pi
signif(pi, 3)
round(pi)
round(pi, 3)
ceiling(pi)
trunc(pi)

##4
heights <- c(179,161,165,185,158)
weights <- c(75,72,60,100,65)
#a
bmi <- weights/((heights*0.01)^2)
bmi
#b
weights[bmi>25]
which(bmi>25)

##5
vec <- c(2,5,3)
vec
rep(vec,5)
rep(vec, length=10)
rep(vec, vec)

##6
c(TRUE, TRUE, FALSE, FALSE) & c(TRUE, FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE, FALSE) | c(TRUE, FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE, FALSE) + 1:4

##7
a <- 1:100
sum()
a[seq_along(a)%%7==0]
sum(1:100 %%7 ==0)

##8
rep(c("a", "b", "c"),3)
rep(c(1,3,5),c(1,3,5))
rep(0:2, rep(2,3))
rep(seq(1,3), 3) + rep(0:2, each=3)

##9
none.true <- c(FALSE, FALSE, FALSE)
any(none.true)
all(none.true)

some.true <- c(FALSE, TRUE, FALSE)
any(some.true)
all(some.true)

all.true <- c(TRUE, TRUE, TRUE)
any(all.true)
all(all.true)

true.missing <- c(TRUE, TRUE, NA)
any(all.true)
all(all.true)

false.missing <- c(NA, FALSE, NA)
any(false.missing)
all(false.missing)

mixed <- c(TRUE, FALSE, NA)
any(mixed)
all(mixed)

##10
x<- 1:10
sd(x) <- 1
z <- (x-mean(x))/sd(x)
mean(z)
sd(z)

#11
dice <- c(3,2,5,1,5,6,5)
dice.factor <- factor(dice)
dice.factor <- factor(dice, levels = c(1,2,3,4,5,6), labels = c("one", "two", "three", "four", "five", "six"))
dice.factor
#names(levels(dice.factor)) <- c("one", "two", "three", "four", "five", "six")
#dice.factor
table(dice.factor)
#labels(dice.factor) <- c("one", "two", "three", "four", "five", "six")
#labels(dice.factor) <- c("one", "two", "three", "four", "five", "six")

#12
seq(0,1,0.1)
seq(0,1,length.out = 10)
