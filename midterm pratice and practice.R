url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris <- read.csv(url, header=FALSE)
head(iris)
colnames(iris) <- c("sepal.length", "sepal.width","petal.length","petal.width","species")
summary(iris)
aggregate(iris[1:4], list(species=iris$species),mean)

library(ggplot2)
ggplot(iris, aes(petal.length, petal.width, shape=species, color=species))+
  geom_point(position = "jitter")+
  geom_jitter()+
  scale_color_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  scale_shape_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  labs(title="Iris",
       subtitle="Distribution of petal length and width by iris species",
       x="Petal Length (cm)",
       y="Petal Width (cm)",
       caption="Source: UCI Machine Learning Repository")+
  theme(legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(face="bold"),
        axis.title = element_text(face = "bold"))
ggplot(iris, aes(sepal.length, sepal.width, shape=species, color=species))+
  geom_point()

download.file(url, destfile = "iris.csv")
iris <- read.csv("iris.csv", header=FALSE)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url,"|",header=TRUE,stringsAsFactors = FALSE)
head(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format = "%m/%d/%Y")

ggplot(npower, aes(ReportDt, Power))+
  facet_wrap(~unique(npower$Unit),nrow = 4)+
  geom_line()

some <- npower[npower$Unit==as.character(unique(npower$Unit)[1:12]),]
Sys.setlocale("LC_TIME", "English")
ggplot(some, aes(ReportDt, Power))+
  geom_line(color="red")+
  facet_wrap(~Unit, nrow = 4)+
  labs(caption="Source: Nuclear Regulatory Commission",
       x=element_blank())+
  scale_x_date(date_labels = "%y-%b",date_breaks = "3 months")+
  theme_bw()+
  theme(strip.background = element_rect(fill="wheat"))
Sys.setlocale()

url <- "http://lib.stat.cmu.edu/datasets/cloud"
?readLines
cloud<- readLines(url)
cloud <- scan("http://lib.stat.cmu.edu/datasets/cloud",skip = 14)

library()
cloud <- scan(url, skip=15, nlines = 108, what=list(period=character(0),
                                           seeded=character(0),
                                           season=character(0),
                                           te=numeric(0),
                                           tw=numeric(0),
                                           nc=numeric(0),
                                           sc=numeric(0),
                                           nwc=numeric(0)))
cloud <-as.data.frame(cloud)     
cloud
colMeans(subset(cloud,select=c(te,tw),
                susbset=(seeded=="S"&season=="AUTUMN")))
colMeans(subset(cloud, select=c(te,tw),
                subset=(seeded=="U"&season=="AUTUMN")))

url <- "http://www.gutenberg.org/files/11/11-0.txt"
alice <- readLines(url, encoding = "UTF-8",n=100)
alice[1:20]
skip=20

alice.chap1 <- character(0)
skip=40
for (i in 1:10){
  one.line <- scan(url, what="",skip=skip, nlines = 1, encoding = "UTF-8")
  alice.chap1[i] <- paste(one.line, collapse = " ")
  skip=skip+1
}

alice.chap1


url <- "https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001404440&fileDetailSn=1&publicDataDetailPk=uddi:9ee2fba3-0330-4041-81fa-d915841276fe"
library(openxlsx)
admin.agency <- read.xlsx(url)
head(admin.agency)
str(admin.agency)
head(admin.agency[c(6,7,9)],3)
tail(admin.agency[c(6,7,9)],3)

string <- "Tweet (@tweet) Food for thought 2020-10-07"
string
gsub("[[:alnum:]]","*",string)
gsub("\\w","*",string)

gsub("[[:alpha:]]","*",string)
gsub("\\D","*",string)

gsub("s\\b","ses","Through the Looking-Glass",perl=TRUE)
gsub("o\\b","_","Through the Looking-Glass",perl=TRUE)
