library(ggplot2)
data(mtcars)
ggplot(mtcars, aes(wt, mpg))+
  geom_point()+
  labs(        x="Weight (1,000 lbs)",
                y="Fuel Consumption (miles per gallon)",
                title="Fuel Consumption vs. Weight",
        subtitle="Negative relationship between fuel efficiency and car weight",
        caption="Source: mpg dataset")
mtcars$cyl <- factor(mtcars$cyl, levels=c(4,6,8),
              labels = c("4 cylinders","6 cylinders","8 cyinders"))
mtcars$gear <- factor(mtcars$gear, levels = c(3,4,5),
                      labels=c("3 gears","4 gears","5 gears"))

ggplot(mtcars, aes(mpg))+
  facet_grid(cyl~.)+
  geom_histogram()+
  labs(title="geom_histogram()",
       x="Miles per Gallon")

ggplot(mtcars, aes(cyl,mpg))+
  geom_boxplot()+
  labs(title="geom_boxplot()",
       x="Number of Cylinders",
       y="Miles per Gallon")

ggplot(mtcars, aes(mpg, fill=cyl))+
  geom_density()+
  labs(title="geom_density()",
       x="Miles per Gallon")

ggplot(mtcars, aes(wt, mpg, color=cyl))+
  geom_point()+
  labs(title="geom_point",
       x="Weight (1,000 lbs)",
       y="Miles per Gallon")

ggplot(mtcars, aes(wt, mpg))+
  geom_smooth()+
  labs(title="geom_smooth()",
       x="Weight (1,000 lbs)",
       y= "Miles per Gallon")

data("economics")
ggplot(economics, aes(economics$date, unemploy))+
  geom_line()+
  labs(title="geom_line()",
       x="Year",
       y="Number of Unemployed(thousands)")

ggplot(mtcars, aes(wt, mpg))+
  geom_smooth()+
  geom_point()+
  labs(title="Fuel Consumption vs. Weight",
       subtitle="Negative relationship between fuel efficiency and car weight",
       x="Weight (1,000 lbs)",
       y="Fuel Consumption(miles per gallon)",
       caption="Source : mpg dataset")

ggplot(mtcars, aes(wt, mpg))+
  geom_smooth(color="red", linetype=2, method = "lm")+
  geom_point(pch=17,color="blue", position = "jitter")+
  geom_text(label=rownames(mtcars), hjust=0, vjust=1, nudge_y = 0.7)
head(mtcars)

library(car)
data("Salaries")
ggplot(Salaries, aes(rank, salary))+
  geom_rug(sides = "l")+
  geom_boxplot(fill="coral3", notch = TRUE)+
  geom_point(position = "jitter",color="blue",alpha=0.5)

ggplot(Salaries,aes(salary,fill=rank))+
  geom_density(alpha=0.5)

ggplot(Salaries, aes(yrs.since.phd, salary, color=rank, shape=sex))+
  geom_point()

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "dodge")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "stack")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position="fill")+
  labs(y="proposition")

library(lattice)
data(singer)
head(singer)

ggplot(singer, aes(height))+
  geom_histogram()+
  facet_wrap(~voice.part, nrow=4)

ggplot(singer, aes(height, fill=voice.part))+
  geom_density()+
  facet_grid(voice.part~.)

ggplot(Salaries, aes(yrs.since.phd, salary))+
  geom_point()+
  facet_grid(sex~rank)

ggplot(Salaries, aes(rank, salary, fill=sex))+
  geom_boxplot()+
  labs(title="Faculty Salary by Rank and Sex",  y=NULL)+
  scale_y_continuous(breaks = c(50000,100000,150000,200000),
                     labels = c("$50K","$100K","$150K","$200K"))+
  scale_x_discrete(breaks=c("AsstProf","AssocProf","Prof"),
                   labels=c("Assistant\nProfessor","Associate\nProfessor","Full\nProfessor"))+
  theme(legend.position = c(0.1, 0.85))

ggplot(mtcars, aes(wt, mpg,size=disp))+
  geom_point(shape=21,fill="wheat",color="black")+
  labs(size="Engine\nDisplacement\n(cubic inch)")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar()+
  scale_fill_manual(values = c("orange","cornflowerblue"))

ggplot(Salaries, aes(yrs.since.phd, salary, color=rank))+
  geom_point()+
  scale_color_brewer(palette="Accent")

ggplot(mtcars, aes(wt, mpg, color=disp))+
  geom_point()+
  scale_color_gradient2()

ggplot(Salaries, aes(yrs.since.phd, salary, shape=rank, color=rank))+
  scale_shape_manual(values = c(15,17,19))+
  geom_point(size=2)

ggsave("one.png")

ggplot(Salaries,aes(yrs.since.phd, salary, color=rank, shape=rank))+
  geom_point()+
  facet_grid(~sex)+
  theme_dark()

ggplot(Salaries, aes(rank, salary, fill=sex))+
  geom_boxplot()+
  theme(axis.title = element_text(face="bold.italic",color="red"))

p1 <- ggplot(Salaries, aes(rank))+
  geom_bar()
p1
p2 <- ggplot(Salaries, aes(salary))+
  geom_histogram()
p2
p3 <- ggplot(Salaries, aes(yrs.since.phd, salary))+
  geom_point(size=2)
p3
p4 <- ggplot(Salaries, aes(rank, salary))+
  geom_boxplot()

library(gridExtra)
grid.arrange(p1,p2,p3,p4)
ggsave("1.png")
p

png("myplot.png", width=648, height=432)
ggplot(mtcars, aes(wt,mpg))+geom_point()
dev.off()

myggplot <-ggplot(mtcars, aes(wt, mpg))+geom_point()
ggsave("myplot.png",plot=myggplot, width = 7.0, height = 5.5)

ggplot(Salaries, aes(rank, salary))+geom_boxplot()
ggsave("myplot.png")

read.csv("product.csv")
p <- read.csv("product-with-no-header.csv", header = FALSE)
str(p)
p <- read.csv("product.csv",stringsAsFactors = FALSE)
str(p)

read.table("product.txt")
read.table("product.txt", header=TRUE)
read.table("product.txt", header = TRUE, stringsAsFactors = FALSE)
read.table("product-colon.txt", sep=":", header=TRUE)
read.table("product-missing.txt", na.strings = ".")
read.fwf("product-fwf.txt", widths = c(4,-1,10,-1,8), col.names = c("id","name","price"))

readLines("won-dollar.txt")

library(openxlsx)
read.xlsx("product.xlsx", sheet=1)


scan("won-dollar.txt", what=list(date=character(0), buyer=numeric(0), sell=numeric(0)), nlines=2)
