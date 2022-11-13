review <- c("Good", "Good", "Indifferent", "Bad")
review
review.factor <- factor(review)
review.factor

str(review)
str(review.factor)

as.numeric(review.factor)

eventday <- c("Mon", "Mon", "Tue", "Wed", "Mon", "Fri", "Thu")
eventday.factor <-factor(eventday)
eventday.factor

eventday.factor <- factor(eventday, levels = c("Mon", "Tue", "Wed", "Thu", "Fri","Sat","Sun"))
eventday.factor

levels(review.factor) #레벨에 무엇이 있는 지 확인하는 함수
levels(review.factor)[3] #이 자체가 벡터이기 때문에 인덱스 가능

levels(review.factor) <- c("B", "G", "I")
review.factor #이렇게 인텍스 바꿀 수 있음

nlevels(review.factor) #레벨 수 확인 가능
length(levels(review.factor))

eval <- c("Medium", "Low", "High", "Medium", "High")
eval.factor <- factor(eval)
eval.factor
eval.ordered <- factor(eval, levels = c("Low", "Medium", "High"), ordered=TRUE)

table(eval.factor)
table(eval.ordered)

sex <- c(2,1,2,2,1,0) #0은 실수로 입력한 데이터-> 결측값 
sex.factor <- factor(sex, levels = c(1,2), labels = c("Male", "Female"))
sex.factor
table(sex.factor)

#######연습문제

#1

(1:10)
(10:1)
c(1:10, 9:1)

#2 
x <- (1:10)
x
y <- 3:1
y

#a
names(x) <- letters[x]
x <- c(x)
x
x["j"]
x + y # 더해지지만 길이가 부족함. 그래서 재사용하는 방식으로 더하게 됨

#3
pi

signif(pi, digits = 3)
round(pi)
round(pi, digits = 3)
