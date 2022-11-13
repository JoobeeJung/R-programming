c(1,2,3,4,5,6,7,8,9,10)
c("we", "love", "Data Analytics")
c(TRUE, FALSE, TRUE, FALSE) #논리 값으로 연결된 논리 벡터

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

seq(from=0, to=100, length.out = 5) #벡터의 원소의 갯수
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
c(num, cha) #문자로 취급 모두
str(num) #행렬인 1:3 인거 ! 표를 머릿속으로 그려보자 순서를 의미함
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
10 %% 3 #나머지 출력
10 %/% 3 # 몫 출력

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

x<-c(1:3)#자기 복제 123 123 recycle rule#
x
y<-c(4:9)
y
x+y

c(1,3,5) + 10

c(1,2,3) + c(4,5,6,7,8)

v<-pi
v
w <-10/3 #w = 10/3 동일하
w
v == w #tor f 측정
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

sqrt(2)^2 == 2 #소수점으로 인식하기 때문에 #
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

log2(1:5) #밑에꺼랑똑같은데 많이 써서 함수가 이미 있음
log(1:5, base=2)

exp(1:5)
y<-exp(1:5)
log(y)

factorial(1:5)
choose(5,2)

sqrt(1:5)

options("digits") #유효숫자 7자리 - 오차까지 감안해도 유효한 숫자 456.75-456.84 -> 456.8
pi
pi*100

signif(456.789, digits = 2)

round(456.789, digits = 2)
round(456.789)

round(456.789, digits = -2) #정수자리수 십의 2승 백단위

round(11.5)
round(12.5) #가장 가까운 짝수로 반올림 5의 경우
round(-3.5)

floor(456.78) # 바닥쪽으로 가는것
floor(-456.78)
ceiling(456.78) #주어진 수보다 큰쪽으로 가기
ceiling(-456.78)
trunc(456.78)
trunc(-456.78)

3/0
5-Inf
Inf * Inf
Inf *(-Inf)

is.infinite(10^(305:310))
Inf/Inf #Not A Number 숫자로 정의가 안된다
log(-2)
NaN+3
is.nan(NaN+3)

K <- NA #not available 결측값 (빈 값인지 아닌ㄴ지)

K == NA
is.na(K)
is.na(K +5)
is.na(NaN)

z <- 1:5
sum(z)
prod(z) #곱셈
min(z)
max(z)
mean(z)
median(z)
range(z)
var(z)
sd(z)

w <- c(1,2,3,4,5, NA)
sum(w)
sum(w, na.rm = TRUE) #na 를 remove 하고 계산
sum(na.omit(w))

v <- c(NA,NA,NA,NA,NA)
sum(v, na.rm=TRUE)
prod(v, na.rm=TRUE)
max(v, na.rm=TRUE)
min(v, na.rm=TRUE)

cumsum #누적 된 계산

diff(1:5, lag=2)

# union 합집합
# intersect 교집합
# setdiff 뺴는

num <- 0:30

prime <-c(2,3,5,7,11,13,17,19)
prime
prime[1] #인덱스는 1부터 시작함 자바랑 다르게 0부터 아님

medal <- c("Sliver", "Bronze", "Gold")
medal
medal[c(3,1,2)]

prime[-1] #선택 안한다. 선택 안한거의 나머지가 출력
prime[-1:-3]

length(prime)
prime[1:(length(prime)-1)]
prime[-length(prime)]


?seq_along
?seq_along(prime)%%2 == 0 # 2의 배수만 출

