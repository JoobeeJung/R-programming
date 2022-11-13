library(ggplot2)
data("faithful")
length <- ifelse(faithful$eruptions>="3","long","short")
length
#a

ggplot(faithful, aes(x=length,y=waiting))+
  geom_boxplot(fill="cornflowerblue", notch = TRUE)
?geom_boxplot

#b
ggplot(faithful, aes(waiting, fill=length))+
  geom_density(alpha=0.5)

#6
lattice::singer
data(singer)
ggplot(lattice::singer, aes(height))+
  geom_histogram()+
  labs(title="Heigh Distribuion")

ggplot(lattice::singer, aes(voice.part, height))+
  geom_boxplot()


data("mtcars") mtcars$
ggplot(mtcars, aes(gear, vs, shape=cyl, color=cyl))+
  geom_point()
