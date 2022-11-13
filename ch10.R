str(faithful)
plot(faithful)

eruptions.long <- with(faithful, faithful[eruptions > 3,])
plot(faithful)
points(eruptions.long, col="red", pch=19)

dev.off()
points(eruptions.long, col="red", pch=19)

faithful.lm <- lm(waiting ~ eruptions, data=faithful)
plot(faithful)
points(eruptions.long, col="red", pch=19)
lines(x=faithful$eruptions, y=fitted(faithful.lm), col="blue")
abline(v=3, col="purple")
abline(h=mean(faithful$waiting), col="green")

abline(a=coef(faithful.lm)[1],b=coef(faithful.lm)[2], col="blue")
abline(faithful.lm, col="blue")

library(ggplot2)
ggplot(data=mtcars, aes(x=wt, y=mpg))+
  geom_point()+
  labs(title="Fuel Consumption vs. Weight",
       x="Weight(1,000 lbs)", y="Fuel Consumption (miles per gallon)")

data("mtcars")
mtcars$gear <- factor(mtcars$gear, levels=c(3,4,5),
                      labels=c("3 gears", "4 gears", "5 gears"))
mtcars$cyl <- factor(mtcars$cyl, levels=c(4,6,8),
                     labels=c("4 cylinders", "6 cylinders", "8 cylinders"))
ggplot(data=mtcars, aes(x=mpg))+geom_histogram()+facet_grid(cyl~.)+
  labs(title="geom_histogram()", x="Miles per Gallon")
