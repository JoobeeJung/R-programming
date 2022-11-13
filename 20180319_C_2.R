c(1,2,3,4,5,6,7,8,9,10)
c("we", "love", "Data Analytics")
c(TRUE, FALSE, TRUE, FALSE) #���� ������ ����� ���� ����

odd <-c(1,3,5)
even <-c(2,4,6)
odd
even
c(odd, even)

3:9
5:-3
?seq

seq(from=3, to=9)
seq(from=3, to=9, by=2)
seq(from=3.5, to=1.5, by=-0.5)

seq(from=0, to=100, length.out = 5) #������ ������ ����
seq(from=-1, to=1, length.out = 5)

?rep
rep(1, times=3)
rep(c(1,2,3), times=3)
rep(c(1,2,3), each=3)
rep(c(1,2,3), times=c(1,2,3))
rep(1:3, length.out=8)

num <-c(1,2,3)
num
cha <-c("X","Y","Z")

cha
cha
cha
c(num, cha) #���ڷ� ��� ���
str(num) #����� 1:3 �ΰ� ! ǥ�� �Ӹ������� �׷����� ������ �ǹ���
str(cha)
length(num)

LETTERS
letters
month.abb
month.name
pi

month <-c(12,9,3,5,1)
month
month.name[month]

1 + 2
2^10
10 %% 3 #������ ���
10 %/% 3 # �� ���

"+"(1,2)

c(1,2,3) + c(4,5,6)

x <- c(1,2,3)
x
x * c(4,5,6)
y <- c(10,20,30)
y
y/c(2,4,6)
y %% c(3,5,7)
y %/% c(3,5,7)

x<-c(1:3)#�ڱ� ���� 123 123 recycle rule#
x
y<-c(4:9)
y
x+y

c(1,3,5) + 10

c(1,2,3) + c(4,5,6,7,8)

v<-pi
v
w <-10/3 #w = 10/3 ������
w
v == w #tor f ����
v != w
v > w
v < w
!(v>w)
(v == w)|(v < w)
(v == w)&(v < w)
isTRUE(v == w)

as.numeric(TRUE)
as.numeric(FALSE)
TRUE + FALSE

y<- c(0, 25, 50, 75, 100)
sum(y>50)

a <- -3:3
any(a>0)
all(a>0)

sqrt(2)^2 == 2 #�Ҽ������� �ν��ϱ� ������ #
sqrt(2)^2 -2
identical(sqrt(2)^2, 2)
all.equal(sqrt(2)^2, 2)
all.equal(sqrt(2)^2, 3)
isTRUE(all.equal(sqrt(2)^2, 3))

fruit <-c("Apple", "Banna", "Strawberry")
food <-c("Pie", "Juice", "Cake")
paste(fruit, food)
paste(fruit, "Juice")

x <- -3:3
x
abs(x)

log(1:5, base = 3)
log(1:5)
log(1:5, base=exp(1))

log2(1:5) #�ؿ������Ȱ����� ���� �Ἥ �Լ��� �̹� ����
log(1:5, base=2)

exp(1:5)
y<-exp(1:5)
log(y)

factorial(1:5)
choose(5,2)

sqrt(1:5)

options("digits") #��ȿ���� 7�ڸ� - �������� �����ص� ��ȿ�� ���� 456.75-456.84 -> 456.8
pi
pi*100

signif(456.789, digits = 2)

round(456.789, digits = 2)
round(456.789)

round(456.789, digits = -2) #�����ڸ��� ���� 2�� �����

round(11.5)
round(12.5) #���� ����� ¦���� �ݿø� 5�� ���
round(-3.5)

floor(456.78) # �ٴ������� ���°�
floor(-456.78)
ceiling(456.78) #�־��� ������ ū������ ����
ceiling(-456.78)
trunc(456.78)
trunc(-456.78)

3/0
5-Inf
Inf * Inf
Inf *(-Inf)

is.infinite(10^(305:310))
Inf/Inf #Not A Number ���ڷ� ���ǰ� �ȵȴ�
log(-2)
NaN+3
is.nan(NaN+3)

K <- NA #not available ������ (�� ������ �ƴѤ���)

K == NA
is.na(K)
is.na(K +5)
is.na(NaN)

z <- 1:5
sum(z)
prod(z) #����
min(z)
max(z)
mean(z)
median(z)
range(z)
var(z)
sd(z)

w <- c(1,2,3,4,5, NA)
sum(w)
sum(w, na.rm = TRUE) #na �� remove �ϰ� ���
sum(na.omit(w))

v <- c(NA,NA,NA,NA,NA)
sum(v, na.rm=TRUE)
prod(v, na.rm=TRUE)
max(v, na.rm=TRUE)
min(v, na.rm=TRUE)

cumsum #���� �� ���

diff(1:5, lag=2)

# union ������
# intersect ������
# setdiff ����

num <- 0:30

prime <-c(2,3,5,7,11,13,17,19)
prime
prime[1] #�ε����� 1���� ������ �ڹٶ� �ٸ��� 0���� �ƴ�

medal <- c("Sliver", "Bronze", "Gold")
medal
medal[c(3,1,2)]

prime[-1] #���� ���Ѵ�. ���� ���Ѱ��� �������� ���
prime[-1:-3]

length(prime)
prime[1:(length(prime)-1)]
prime[-length(prime)]


?seq_along
?seq_along(prime)%%2 == 0 # 2�� ����� ��
