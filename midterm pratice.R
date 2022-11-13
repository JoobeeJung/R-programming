library(ggplot2)
ggplot(mtcars, aes(wt,mpg))+
  geom_point(pch=17, color="blue", size=2)+
  geom_smooth(method = "lm", color="red", linetype=2, size=1)+
  geom_text(label=rownames(mtcars), hjust=0, vjust=1, nudge_y=0.7, size=2)+
  labs("Weight (1,000 lbs)","Fuel Consumption (miles per gallon)",
       title="Fuel Consumption vs. Weight",
       subtitle="Negative relationship between fuel efficiency and car weight",
       caption="Source: mpg dataset")
data(mtcars)
mtcars$gear <- factor(mtcars$gear, levels = c(3,4,5),
                      labels = c("3 gears","4 gears","5 gears"))
mtcars$cyl <- factor(mtcars$cyl, levels = c(4,6,8),
                     labels = c("4 cylinders","6 cylinders","8 cylinders"))
ggplot(mtcars, aes(mpg))+
  geom_histogram()+
  facet_grid(cyl ~.)+
  labs(title="geom_histogram()", x="Miles per Gallon")

ggplot(mtcars, aes(cyl, mpg))+
  geom_boxplot()+
  labs(title="geom_boxplot()", x="Number of Cylinders", y="Miles per Gallon")

ggplot(mtcars, aes(mpg, fill=cyl))+
  geom_density()+
  labs(title="geom_density()", x="Miles per Gallon")

ggplot(mtcars, aes(wt, mpg, col=cyl))+
  geom_point()+
  labs(title="geom_point()", x="Weight (1,000 lbs)", y="Miles per Gallon")

ggplot(mtcars, aes(wt, mpg))+
  geom_smooth()+
  labs(title="geom_smooth()", x="Weight (1,000 lbs)", y="Miles per Gallon")

ggplot(economics, aes(date, unemploy))+
  geom_line()+
  labs(title="geom_line()", x="Year", y="Number of Unemployed (thousands)")

library(car)
str(Salaries)
ggplot(Salaries, aes(rank, salary))+
  geom_boxplot(fill="coral3",color="black",notch = TRUE)+
  geom_point(position = "jitter", color="blue", alpha=0.5)+
  geom_rug(sides = "l", color="black")

library(car)
ggplot(Salaries, aes(salary, fill=rank))+
  geom_density(alpha=0.5)

ggplot(Salaries, aes(yrs.since.phd,salary,shape=sex, color=rank))+
  geom_point()

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "dodge")

ggplot(Salaries,aes(rank, fill=sex))+
  geom_bar(position="stack")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position="fill")+
  labs(title="position=\"fill\"", y="proportion")

library(lattice)
ggplot(data=singer, aes(x=height))+
  geom_histogram(fill="tomato")+
  facet_wrap( ~ voice.part, nrow = 4)
ggplot(singer, aes(height, fill=voice.part))+
  geom_density()+
  facet_grid(voice.part ~.)

ggplot(Salaries, aes(x=yrs.since.phd, salary))+
  geom_point(color="cornflowerblue")+
  facet_grid(sex ~ rank)

library(car)
ggplot(Salaries, aes(rank, salary, fill=sex))+
  geom_boxplot()+
  scale_x_discrete(breaks=c("AsstProf","AssocProf","Prof"))+
  scale_y_continuous(breaks = c(50000,100000,150000,200000),
                     labels = c("$50k","$100k","$150k","$200k"))+
  labs(title="Faculty Salary by Rank and Sex", x=NULL, y=NULL, fill="Gender")+
  theme(legend.position = c(0.1,0.85))

ggplot(mtcars, aes(wt, mpg, size=disp))+
  geom_point(shape=21, color="black",fill="wheat")+
  labs(size="Engine\nDisplacement\n(cubic inch)")

ggplot(Salaries, aes(rank,fill=sex))+
  geom_bar()+
  scale_fill_manual(values=c("coral","cornflowerblue"))

ggplot(Salaries, aes(yrs.since.phd, salary, color=rank))+
  geom_point(size=2)+
  scale_color_brewer(palette = "Accent")

ggplot(mtcars,aes(wt,mpg,color=disp))+
  geom_point(size=2)+
  labs(color="Engine\nDisplacement\n(cubic inch)")+
  scale_color_gradient2()

ggplot(Salaries, aes(yrs.since.phd, salary, color=rank, shape=rank))+
  geom_point()+facet_grid(.~sex)+theme_dark()

mytheme <- theme(plot.title = element_text(face="bold.italic", size="14", color="brown"),
                 axis.title = element_text(face="bold.italic", size = "10", color = "tomato"),
                 axis.text = element_text(face="bold",size="9",color = "royalblue"),
                 panel.background = element_rect(fill="snow",color="darkblue"),
                 panel.grid.major = element_line(color="gray", linetype = "solid"),
                 panel.grid.minor = element_line(color = "gray", linetype = "dashed"),
                 legend.position = "top")
ggplot(Salaries, aes(rank, salary, fill=sex))+
  geom_boxplot()+
  labs(title="Salary by Rank and Sex", "Rank", "Salary")+
  mytheme
