library(ggplot2)
data(mtcars)
ggplot(mtcars,aes(wt,mpg))+
  geom_point()+
  labs(title= "Fuel Consumption vs. Weight",
         subtitle= "Negative relationship between fuel efficiency and car weight",
         caption="Source: mpg dataset",
         x="Weight (1,000 lbs)",
         y="Fuel Consumption (miles per gallon)")

mtcars$cyl <- factor(mtcars$cyl, levels=c(4,6,8),labels=c("4 cylinders","6 cylinders","8 cylinders"))
mtcars$gear <- factor(mtcars$gear, levels = c(3,4,5),labels=c("3 gears","4 gears","5 gears"))
p1 <- ggplot(mtcars, aes(mpg))+
  geom_histogram()+
  facet_grid(cyl~.)+
  labs(title="geom_histogram()",
       x="Miles per Gallon")

p2 <- ggplot(mtcars,aes(cyl,mpg))+
  geom_boxplot()+
  labs(title="geom_boxplot()",
       x="Number of Cylinders",
       y="Miles per Gallon")

p3 <- ggplot(mtcars,aes(mpg,fill=cyl))+
  geom_density(alpha=0.5)+
  labs(title="geom_density()")

p4 <- ggplot(mtcars,aes(wt,mpg,color=cyl))+
  geom_point()+
  labs(title="geom_point()",
       x="Weight (1,000 lbs)",
       y="Miles per Gallon")

library(gridExtra)
grid.arrange(p1,p2,p3,p4,nrow=2,ncol=2)

ggplot(mtcars,aes(wt, mpg))+
  geom_smooth()+
  labs(title="geom_smooth()")

data("economics")
ggplot(economics, aes(date, unemploy))+
  geom_line()+
  labs(title="geom_line()")

ggplot(mtcars, aes(wt, mpg))+
  geom_point()+
  geom_smooth()+
  labs(title="Fuel Consumption vs. Weight",
       caption="Source: mpg dataset")

ggplot(mtcars,aes(wt, mpg))+
  geom_point(pch=17,color="blue",size=2)+
  geom_smooth(method="lm", color="red", linetype="dashed")+
  geom_text(label=rownames(mtcars), hjust=0, vjust=1, nudge_y=0.7, size=2)
?geom_smooth
?geom_text()

data(Salaries)
library(car)
install.packages("car")
ggplot(Salaries, aes(rank, salary))+
  geom_boxplot(notch=TRUE, fill="coral3")+
  geom_point(alpha=0.5,position = "jitter",color="blue")+
  geom_rug(sides = "l")
?geom_boxplot
?geom_rug
?geom_point

ggplot(Salaries, aes(salary, fill=rank, color=rank))+
  geom_density(alpha=0.5, color="black")

ggplot(Salaries, aes(yrs.since.phd, salary, shape=sex, color=rank))+
  geom_point(position = "jitter")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "dodge")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "stack")

ggplot(Salaries, aes(rank, fill=sex))+
  geom_bar(position = "fill")


?geom_bar
library(lattice)
data(singer)
ggplot(singer, aes(height))+
  geom_histogram(fill="tomato")+
  facet_wrap(~voice.part, nrow = 4)

ggplot(singer,aes(height, fill=voice.part))+
  geom_density()+
  facet_wrap(~voice.part, ncol=1)

ggplot(singer,aes(height, fill=voice.part))+
  geom_density()+
  facet_grid(voice.part~.)

ggplot(Salaries, aes(yrs.since.phd, salary))+
  geom_point(color="cornflowerblue")+
  facet_grid(sex~rank)

ggplot(Salaries, aes(rank, salary, fill=sex))+
  scale_x_discrete(breaks=c("AsstProf","AssocProf","Prof"),labels=c("Assistant\nProfessor","Associate\nProfessor","Full\nProfessor"))+
  scale_y_continuous(breaks = c(50000,100000,150000,200000),labels = c("$50K","$100K","$150K","$200K"))+
  geom_boxplot()+
  labs(x=NULL,y=NULL,fill="Gender")+
  theme(legend.position = c(0.1,0.85))

ggplot(mtcars,aes(wt,mpg,size=disp))+
  geom_point(shape=21, fill="wheat",color="black")+
  labs(size=c("Engine\nDisplacement\n(cubic inch)"))

ggplot(Salaries, aes(rank,fill=sex))+
  geom_bar(position = "stack")+
  scale_fill_manual(values = c("coral","cornflowerblue"))

?geom_point

ggplot(Salaries,aes(yrs.since.phd,salary,color=rank))+
  geom_point(size=2)+
  scale_color_manual(values=c("orange","violetred","steelblue"))
  ##scale_color_brewer(palette = "Accent")

ggplot(mtcars,aes(wt, mpg, color=disp))+
  geom_point(size=3)+
  scale_color_gradient2()+
  labs(color="Engine\nDisplacement\n(cubic inch)")
?scale_color_gradient2

ggplot(Salaries,aes(yrs.since.phd, salary, shape=rank, color=rank))+
  geom_point(size=2)+
  scale_shape_manual(values=c(15,17,19))

ggplot(Salaries, aes(yrs.since.phd, salary, shape=rank, color=rank))+
  theme_bw()+
  geom_point()+
  facet_wrap(~sex)

mytheme <- theme(plot.title = element_text(face="bold.italic",color="brown"),
                 axis.text = element_text(face="bold", color="blue"),
                 axis.title = element_text(face="bold.italic",color="red"),
                 panel.background = element_rect(fill="snow",color="blue"),
                 panel.grid.major = element_line(linetype = "solid"),
                 panel.grid.minor = element_line(linetype="dashed"),
                 legend.position = "top")

ggplot(Salaries, aes(rank, salary, fill=sex))+
  geom_boxplot()+
  scale_fill_manual(values=c("tomato","green"))+
  labs(title="Salary by Rank and Sex",
       x="Rank",
       y="Salary")+
  mytheme

p1 <- ggplot(Salaries,aes(rank))+
  geom_bar()
p2 <- ggplot(Salaries,aes(salary))+
  geom_histogram()
p3 <- ggplot(Salaries,aes(yrs.since.phd, salary))+
  geom_point()
p4 <- ggplot(Salaries, aes(rank, salary))+
  geom_boxplot()
library(gridExtra)
grid.arrange(p1,p2,p3,p4,nrow=2,ncol=2)
png("abc.png",width=648,height=300)

ggplot(mtcars,aes(wt,mpg))+geom_point()
dev.off()
ggsave("my.png")
?ggsave()

data("faithful")
faithful$length <-ifelse(faithful$eruptions>=3,"long","short")
#a
library(ggplot2)
ggplot(faithful, aes(length, waiting))+
  geom_boxplot(fill="cornflowerblue",notch = TRUE)+
  labs(x="Eruption Length", y="Waiting Time (minutes)",
       title="Waiting Time Distriution By Eruption Length")
#b
ggplot(faithful,aes(waiting,fill=length, linetype=length))+
  geom_density(alpha=0.5)

library(lattice)
data("singer")
#a
ggplot(singer, aes(height))+
  geom_histogram()
#b
ggplot(singer,aes(voice.part,height))+
  geom_boxplot()

data("mtcars")
#7
mtcars$am <- factor(mtcars$am, levels = c(0,1),labels = c("Automatic","Manual"))
mtcars$vs <- factor(mtcars$vs, levels = c(0,1),labels = c("V-Engine","Straight Engine"))
mtcars$cyl <- factor(mtcars$cyl, levels = c(4,6,8),labels = c("4","6","8"))
ggplot(mtcars, aes(hp,mpg,shape=cyl,color=cyl))+
  geom_point(size=2)+
  facet_grid(am~vs)

##8
library(car)
ggplot(Salaries,aes(yrs.since.phd, salary, linetype=sex, shape=sex,color=sex))+
  geom_point()+
  geom_smooth(methods="lm", formula= y ~ ploy(x,2),se=FALSE)

##9
data("diamonds")
ggplot(diamonds,aes(carat, price))+
  geom_point()+
  geom_smooth(aes(color=cut, line=cut))+
  facet_wrap(~cut, nrow=2)

##10
diamonds$carat <- factor(diamonds$carat, levels = c(0.25,0.5,0.75,1,1.25,1.5,1.75))

##12
url <- "http://data.worldbank.org/"



telephones <- "Barabasi, Albert-Laszlo917 1843James Bond(02)563-1987(1)John F.Kennedy051-
776-5879(123)Dr. Who(062) 324-9576McCartney, J. Paul0648323912"
telephones


name <-unlist(regmatches(telephones,gregexpr("[[:alpha:]., -]{2,}",telephones)))
name

library(stringr)
name <- unlist(str_extract_all(telephones,"[[:alpha:]., -]{2,}"))
name
phone <- unlist(regmatches(telephones, gregexpr("\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,2})?\\)?", telephones)))
phone
phone <- unlist(str_extract_all(telephones,"\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}(-| )?\\(?(\\d{1,3})?\\)?"))
phone

mon <- c(1:12)
str_pad(mon,pad="0",width = 2, side = "left")

library(RCurl)
url <- "https://news.stanford.edu/2005/06/14/jobs-061505/"
speech <- getURL(url, .encoding = "UTF-8")
speech
