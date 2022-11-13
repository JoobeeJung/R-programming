#######1#########

c(1:10)
c(10:1)
c(c(1:10), c(9:1))

#######2#########
x <- 1:10
x
y <- 3:1
y

##a
letters 
names(x) <- letters[x]
##b
x+y

########3#########
pi
signif(pi, digits = 3)
round(pi)
round(pi, digits = 3)
ceiling(pi)
trunc(pi)

########4###########
heights <- c(179,161,165,185,158)
weights <- c(75,72,60,100,65)
##a
bmi <- (weights/(heights*0.01)^2)
bmi
##b
bmi>25
weights[bmi>25]

######5##########
vec <- c(2,5,3)
vec
rep(vec,5)
?rep()
rep.int(vec,3)
rep_len(vec, 10)
rep(vec,times=c(2,5,3))

######6######
c(TRUE,TRUE,FALSE,FALSE) & c(TRUE,FALSE,TRUE,FALSE)
c(TRUE, TRUE, FALSE, FALSE) | c(TRUE, FALSE, TRUE, FALSE)
c(TRUE, TRUE, FALSE, FALSE) + 1:4
as.numeric(FALSE)

#####7#########
c <- 1:100
sum(c %% 7==0)
c[c %% 7==0]

####8#######
rep(c("a","b","c"),3)
rep(c(1,3,5), c(1,3,5))
rep(0:2, rep(2,3))
rep(seq(1,3), times=3) + 
  rep(0:2,each=3)

####9######
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
any(true.missing)
all(true.missing)

false.missing <- c(NA, FALSE, NA)
any(false.missing)
all(false.missing)

mixed <- c(TRUE, FALSE, NA)
any(mixed)
all(mixed)

##########10#######
x <- 1:10
z <- ((x -mean(x))/sd(x))
z
mean(z)
sd(z)

########11##########
t <- c(3,2,5,1,5,6,5)
t.factor <- factor(t, levels = c("one", "two", "three","four","five","six"))
t.factor
table(t.factor)

######12######
seq(0,1,0.1)
seq(0,1,length.out = 10)
