url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
t <- read.table(url, header=FALSE, stringsAsFactors = FALSE)
?read.table
head(t)
t <- read.csv(url, header=FALSE, stringsAsFactors = FALSE)
head(t)

colnames(t) <- c("Sepal.length","sepal.width","petal.length","petal.width","species")
summary(t)

a <- aggregate(t[1:4],list(species=t$species),mean)
?aggregate

t
head(t)

library(ggplot2)
ggplot(t, aes(petal.length, petal.width,shape=species,color=species))+
  geom_point()+
  scale_shape_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  scale_color_discrete(labels=c("Setosa","Versicolor","Virginica"))+
  labs(title="Iris",
       subtitle="Distribution of petal length and width by iris species",
       x="Petal Length (cm)",
       y="Petal Width (cm)",
       caption="Source: UCI Machine Learning Repository",
       legend=c("Setosa","Versicolor","Virginica"))+
  theme(legend.title = element_blank(),
        legend.position = "bottom")
library(png)
ggsave("my1.png")

download.file(url, destfile = "iris.csv")
iris <- read.csv("iris.csv",header=FALSE)

url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
nrc <- read.table(url, sep="|",header = TRUE, stringsAsFactors = FALSE)
head(nrc)
nrc[1:40,]
nrc$ReportDt <- as.Date(nrc$ReportDt, format = "%m/%d/%Y")
Sys.getlocale()
Sys.setlocale("LC_TIME","English")
?Sys.setlocale
some <- nrc[nrc$Unit==as.character(unique(nrc$Unit)[1:12]),]
ggplot(some, aes(ReportDt,Power))+
  geom_line()+
  scale_x_date(date_breaks = "3 months", date_labels = "%y-%b")+
  facet_wrap(~Unit, nrow=4)+
  theme_bw()+
  theme(strip.background = element_rect(fill="wheat") )
Sys.setlocale()

url <- "http://lib.stat.cmu.edu/datasets/cloud"
download.file(url,destfile = "cloud.txt")
cloud <- readLines(url, encoding = "utf-8")
cloud[1:20]
?scan
clouds <- scan("cloud.txt", skip=14)

cloud <- scan("http://lib.stat.cmu.edu/datasets/cloud", skip=15, nlines=108,what = list(PERIOD=character(0),
                                                      SEEDED=character(0),
                                                      SEASON=character(0),
                                                      te=numeric(0),
                                                      TW=numeric(0),
                                                      NC=numeric(0),
                                                      SC=numeric(0),
                                                      NWC=numeric(0)))
cloud.seeding <- data.frame(cloud)
summary(cloud.seeding)
colMeans(subset(cloud.seeding, select = c(te,TW),
                subset = (SEEDED=="S"& SEASON=="AUTUMN")))
colMeans(subset(cloud.seeding, select = c(te,TW),
                subset = (SEEDED=="U"& SEASON=="AUTUMN")))


url <- "http://www.gutenberg.org/files/11/11-0.txt"
alice <- readLines(url,encoding = "UTF-8")
head(alice)
alice[1:41]
alice.chap1 <- character(0)
skip=40
for (i in 1:10) {
  one.line <- scan(url, what="", skip=skip, nlines=1, encoding="UTF-8")
  alice.chap1[i] <- paste(one.line, collapse = " ")
  skip=skip+1
  
  }

alice.chap1

url <- "https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001404440&fileDetailSn=1&publicDataDetailPk=uddi:9ee2fba3-0330-4041-81fa-d915841276fe"
library(openxlsx)
admin <- read.xlsx(url)
head(admin[c(6,7,9)],3)
str(admin)
?head

url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
library(RCurl)
speech <- getURL(url)
head(speech)
speech <- gsub("<.*?>","",speech)
speech <- gsub("\n|\t","",speech)
cat(speech)

url <- "https://www.naver.com/"
naver <- getURL(url)
head(naver)
ranking <- gsub("(<span class='ah_k'.*?>)(<.*?>)(</span>)","\\2", naver)
ranking <- unlist(regmatches(naver,gregexpr("<span class=\"ah_k\">.*?</span>",naver)))[1:10]
ranking <- gsub("<.*?>","",ranking)                

library(stringr)

text <- readLines(url, encoding="UTF-8")
text
regmatches(text, gregexpr("<span class=\"ah_k\"><.*?></span>",text))
a <- grep("ah_k",text,value=TRUE)[1:10]
a <- gsub("<.*?>","",a)
a
