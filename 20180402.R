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

levels(review.factor) #������ ������ �ִ� �� Ȯ���ϴ� �Լ�
levels(review.factor)[3] #�� ��ü�� �����̱� ������ �ε��� ����

levels(review.factor) <- c("B", "G", "I")
review.factor #�̷��� ���ؽ� �ٲ� �� ����

nlevels(review.factor) #���� �� Ȯ�� ����
length(levels(review.factor))

eval <- c("Medium", "Low", "High", "Medium", "High")
eval.factor <- factor(eval)
eval.factor
eval.ordered <- factor(eval, levels = c("Low", "Medium", "High"), ordered=TRUE)

table(eval.factor)
table(eval.ordered)

sex <- c(2,1,2,2,1,0) #0�� �Ǽ��� �Է��� ������-> ������ 
sex.factor <- factor(sex, levels = c(1,2), labels = c("Male", "Female"))
sex.factor
table(sex.factor)

#######��������

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
x + y # ���������� ���̰� ������. �׷��� �����ϴ� ������� ���ϰ� ��

#3
pi

signif(pi, digits = 3)
round(pi)
round(pi, digits = 3)