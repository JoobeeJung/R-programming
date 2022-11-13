library(ggplot2)
ggplot(data=mtcars, aes(x=wt, y=mpg))+
  geom_point()+
  labs(x="Weight (1,000 lbs)", y="Fuel Consumption (miles per gallon)",
       title="Fuel Consumption vs. Weight",
       subtitle="Negative relationship between fuel efficiency and car weight",
       caption="Source: mpg dataset")

data(mtcars)
mtcars$gear <- factor(mtcars$gear, levels=c(3,4,5),
                      labels=c("3 gears", "4 gears", "5 gears"))
mtcars$cyl <- factor(mtcars$cyl, levels = c(4,6,8),
                     labels = c("4 cylinders", "6 cylinders", "8 cylinders"))
ggplot(data=mtcars, aes(x=mpg))+geom_histogram()+facet_grid(cyl ~ .)+labs(title="geom_histogram()", x="Miles per Gallon")
ggplot(data=mtcars, aes(x=cyl, y=mpg))+geom_boxplot()+
  labs(title="geom_boxplot()", x="Number of Cylinders",y="Miles per Gallon")
ggplot(data=mtcars, aes(x=mpg, fill=cyl))+geom_density()+
  labs(title="geom_density()", x="Miles per Gallon")
ggplot(data=mtcars, aes(x=wt, y=mpg, col=cyl))+geom_point()+
  labs(title="geom_point()", x="Weight(1,000 lbs)", y="Miles per Gallon")
ggplot(data=mtcars, aes(x=wt, y=mpg))+geom_smooth()+
  labs(title="geom_smoth()", x="Weight(1,000 lbs", y="Miles per Gallon")
ggplot(data=economics, aes(x=date, y=unemploy))+geom_line()+
  labs(title="geom_line()", x="Year", y="Number of Unemployed(thousands)")

ggplot(data=mtcars, aes(x=wt, y=mpg))+
  geom_point()+
  geom_smooth()+
  labs(x="Weight(1,000 lbs)", y="Fuel Consumption (miles per gallon)",
       title="Fuel Consumption vs. Weight",
       subtitle="Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")

ggplot(data=mtcars, aes(x=wt, y=mpg))+
  geom_point(pch=17, color="blue", size=2)+
  geom_smooth(method="lm", color="red", linetype=2, size=1)+
  labs(x="Weight(1,000 lbs)", y="Fuel Consumption (miles per gallon)",
       subtitle="Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")

ggplot(data=mtcars, aes(x=wt, y=mpg))+
  geom_point(pch=17, color="blue", size=2)+
  geom_smooth(method="lm", color="red", linetype=2, size=1)+
  geom_text(label=rownames(mtcars), hjust=0, vjust=1, nudge_y = 0.7, size=2)+
  labs(x="Weight(1,000 lbs)", y="Fuel Consumption (miles per gallon)",
       title="Fuel Consumption vs. Weight",
       subtitle="Negative relationship between fuel efficiency and car weight",
       caption="Source : mpg dataset")

library(car)
str(Salaries)
ggplot(Salaries, aes(x=rank, y=salary))+
  geom_boxplot(fill="coral3", color="black", notch=TRUE)+
  geom_point(position ="jitter", color="blue", alpha=0.5)+
  geom_rug(sides="l", color="black")
library(car)
ggplot(Salaries, aes(x=salary, fill=rank))+
  geom_density(alpha=0.5)

ggplot(Salaries, aes(x=yrs.since.phd, y=salary, color=rank, shape=sex))+
  geom_point()

ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="dodge")+labs(title='position="dodge"')
ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="stack")+labs(title='position="stack"')
ggplot(Salaries, aes(x=rank, fill=sex))+
  geom_bar(position="fill")+labs(title='position="fill"',y="proportion")

library(lattice)
ggplot(data=singer, aes(x=height))+
  geom_histogram(fill="tomato")+
  facet_wrap(~ voice.part, nrow=4)

ggplot(data=singer, aes(x=height, fill=voice.part))+
  geom_density()+
  facet_grid(voice.part ~.)

library(car)
ggplot(Salaries, aes(x=yrs.since.phd, y=salary))+
  geom_point(color="cornflowerblue")+
  facet_grid(sex ~ rank)

library(car)
ggplot(Salaries, aes(x=rank, y=salary, fill=sex))+
  geom_boxplot()+
  scale_x_discrete(breaks=c("AsstProf", "AssocProf","Prof"),
                   labels=c("Assistant\nProfessor",
                            "Associate\nProfessor","Full\nProfessor"))+
  scale_y_continuous(breaks = c(50000,100000,150000,200000),
                     labels = c("$50k","$100k","$150k","$200k"))+
  labs(title="Faculty Salary by Rank and Sex", x=NULL, y=NULL)

read.csv("product.csv")
read.csv("product-with-no-header.csv", header=FALSE)
p <- read.csv("product.csv", stringsAsFactors = FALSE)
str(p)

read.table(file="product.txt")
p <- read.table("product.txt", header=TRUE, stringsAsFactors = FALSE)
p
str(p)

read.table("product-colon.txt", sep=":", header=TRUE, stringsAsFactors = FALSE)
read.table("product-colon.txt", header=TRUE, stringsAsFactors = FALSE)

read.table("product-missing.txt", header = TRUE)
read.table("product-missing.txt", na.strings = "." ,header = TRUE)
read.fwf("product-fwf.txt", widths = c(4,-1,10,-1,8))
read.fwf("product-fwf.txt", widths = c(4,-1,10,8), col.names = c("id","name","price"))

readLines("won-dollar.txt")
readLines("won-dollar.txt", n=2)
scan("won-dollar.txt", what=character(0))
scan("won-dollar.txt", what=list(character(0),numeric(0),numeric(0)))
scan("won-dollar.txt", what=list(date=character(0),buy=numeric(0),sell=numeric(0)), nlines = 2)
scan("won-dollar.txt", what=list(date=character(0),buy=numeric(0),sell=numeric(0)), skip=3)
library(openxlsx)
read.xlsx("product.xlsx", sheet=1)     

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris <- read.csv(url, header = FALSE)
head(iris)

colnames(iris) <- c("spal.length","sepal.width","petal.length","petal.width","species")
summary(iris)

aggregate(iris[1:4], list(species=iris$species),mean)

library(ggplot2)
windows(7.0, 5.5)
ggplot(iris, aes(petal.length, petal.width, color=species, shape=species))+
  geom_point(position = "jitter")+
  scale_color_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  scale_shape_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  labs(x="Petal Length (cm)", y="Petal Width (cm)",
       title="Iris",
       subtitle="Distribution of petal length and width by iris species",
       caption="Source: UCI Machine Learning Repository")+
  theme(plot.title = element_text(face="bold"),
        axis.text = element_text(face="bold"),
        legend.position = "bottom",
        legend.title = element_blank())

download.file(url, destfile = "iris.csv")
iris <- read.csv("iris.csv", header = FALSE)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep="|", header = TRUE, stringsAsFactors = FALSE)
str(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format = "%m/%d/%Y")
head(npower); tail(npower, 3)

some <- npower[npower$Unit==as.character(unique(npower$Unit)[1:12]),]
some
library(ggplot2)
Sys.setlocale("LC_TIME","English")
windows(7.0,7.0)
ggplot(some,aes(ReportDt, Power))+
  geom_line(col="red")+
  facet_wrap(~Unit, scale="free_y", nrow=4)+
  scale_x_date(date_labels = "%y-%b",date_breaks = "3 months")+
  labs(x="",y="Power",
       title="Nuclear Power Reactor Status over Time",
       subtitle="12 samples of power reactor in US",
       caption="Source: Nuclear Regulatory Commission")+
  theme_bw()
Sys.setlocale()

cloud.seeding<- scan("http://lib.stat.cmu.edu/datasets/cloud",
                       skip=15,
                       nlines=108,
                       what = list(period=character(0),
                                   seeded=character(0),
                                   season=character(0),
                                   te=numeric(0),
                                   tw=numeric(0),
                                   nc=numeric(0),
                                   sc=numeric(0),
                                   nwc=numeric(0)))
str(cloud.seeding)
cloud.seeding
cloud.seeding$season

cloud.seeding <- as.data.frame(cloud.seeding)
cloud.seeding
summary(cloud.seeding[4:8])
colMeans(subset(cloud.seeding, select = c(te,tw),
                subset = (seeded=="S"&season=="AUTUMN")))
colMeans(subset(cloud.seeding, select = c(te,tw),
                subset = (seeded=="U"&season=="AUTUMN")))

url <-"http://www.gutenberg.org/files/11/11-0.txt"
alice<- readLines(url, n=100, encoding = "UTF-8")
alice[1:10]

alice.chap1 <- character(10)
skip=40

alice
for(i in 1:10){
  one.line <- scan(url, what="",skip=skip, nlines=1, encoding = "UTF-8")
alice.chap1[i] <- paste(one.line, collapse = " ")
skip=skip+1
}
alice.chap1

library(openxlsx)
url <- "https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001404440&fileDetailSn=1&publicDataDetailPk=uddi:9ee2fba3-0330-4041-81fa-d915841276fe"
admin.agency <- read.xlsx(url)
names(admin.agency)
head(admin.agency[c(6,7,9)],3)
tail(admin.agency[c(6,7,9)],3)
