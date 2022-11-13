x <- c(1:10)
x
y <- c(3:1)
y
##a
names(x) <- letters[1:10]
x
##b
x + y

vec <- c(2,5,3)
vec 
rep(vec, vec)


#################
heights <- c(179, 161, 165, 185, 158)
weights <- c(75, 72, 60, 100, 65)

##a
BMI <- (weights/((heights*0.01)^2))
BMI

##b
BMI[BMI>25]


###################
library(MASS)
mammals
search()
##a
mammals$size <- ifelse(mammals$body>=median(mammals$body),"large","small")
?ifelse
head(mammals)
##b
str(mammals)
##???
mammals[mammals$size=="large", c("Nmae", "size")]
##c
head(mammals)
brain.percent <- (mammals$brain/mammals$body)
brain.percent
mammals <- cbind(mammals, brain.percent)
max(mammals$brain.percent)
min(mammals$brain.percent)
##d
mammals[mammals$brain.percent>median(brain.percent) & mammals$size=="large", c("Name")]

