url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
library(RCurl)
iris <- read.csv(url, header = FALSE)
head(iris)
colnames(iris) <- c("sepal.length","sepal.width","petal.length","petal.width","species")
summary(iris)
aggregate(iris[1:4],list(species=iris$species),mean)

library(ggplot2)
ggplot(iris, aes(petal.length, petal.width, color=species, shape=species))+
  geom_point(size=2, position="jitter")+
  scale_color_discrete(labels=c("Setosa","Versicolor","Virinica"))+
  scale_shape_discrete(labels=c("Setosa","Versicolor","Virinica"))+
  labs(title="Iris",
       subtitle="Distribution of petal length and width by iris species",
       caption="Source: UCI Machine Learning Repository",
       x="Petal Length (cm)",
       y="Petal Width (cm)")+
  theme(plot.title = element_text(face="bold"),
        legend.position = "bottom",
        legend.title = element_blank())
url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep="|", header=TRUE, stringsAsFactors = FALSE)
head(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format = "%m/%d/%Y")
Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English")

str(npower)
some <- npower[npower$Unit==as.character(unique(npower$Unit)[1:12]),]
ggplot(some, aes(ReportDt, Power))+
  geom_line(color="red")+
  scale_x_date(date_breaks = "3 months",date_labels = "%y-%b")+
  facet_wrap(~Unit, nrow=4)+
  labs(x=NULL,
       caption="Source: Nuclear Regulatory Commission")+
  theme_bw()+
  theme(strip.background = element_rect(fill="wheat"))
  ?theme()

Sys.setlocale()

url <- "http://lib.stat.cmu.edu/datasets/cloud"
cloud <- scan(url, skip=15, nlines = 108, what=list("period"=character(0),
                                                    "seeded"=character(0),
                                                    "season"=character(0),
                                                    "te"=numeric(0),
                                                    "tw"=numeric(0),
                                                    "nc"=numeric(0),
                                                    "sc"=numeric(0),
                                                    "nwc"=numeric(0)))
head(cloud)
cloud <- data.frame(cloud)
colMeans(subset(cloud,select = c(te,tw),
                       subset = (seeded=="S"&season=="AUTUMN")))
colMeans(subset(cloud,select = c(te,tw),
                subset = (seeded=="U"&season=="AUTUMN")))

url <- "http://www.gutenberg.org/files/11/11-0.txt"
alice <- readLines(url, encoding = "UTF-8")
head(alice)

chap1 <- character(0)
skip=40
for(i in 1:10){
  one.line <- scan(url, skip=skip, what="", nlines = 1)
  chap1[i] <- paste(one.line, collapse = " ")
  skip=skip+1
}
chap1

url <- "https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001404440&fileDetailSn=1&publicDataDetailPk=uddi:9ee2fba3-0330-4041-81fa-d915841276fe"
library(openxlsx)
admin <- read.xlsx(url, sheet = 1)
names(admin)
head(admin[c(6,7,9)],3)
tail(admin[c(6,7,9)],3)

url <- "https://www.naver.com/"
naver <- getURL(url)
head(naver)
grep("<meta.+?>",naver)[1:10]
a <- unlist(regmatches(naver, gregexpr("<meta.+?>",naver)))[1:2]
a[1]
library(readr)
guess_encoding(naver)
Encoding(a)
library(stringr)
Encoding(naver)

url <- "http://mk.co.kr/"
mk <-getURL(url, .encoding = enc)
Encoding(mk)
guess_encoding(mk)

grep("<li class=('first2'|'add')>.*?</li>",mk, value=TRUE)
unlist(regmatches(mk,gregexpr("<li class=('first2'|'add')>.*?</li>", mk)))
c <- str_extract_all(mk,"<li class=('first2'|'add')>.*?</li>" )
d <- unlist(gsub("<.*?>","",c))
e <- gsub("\\","",d)
cat(d)
m <- unlist(str_extract_all(mk,"<meta.*?>"))[1:3]
m
Encoding(m)
guess_encoding(url)
enc <- as.character(guess_encoding(url)[1,1])
enc

url <- "http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
speech <- getURL(url, .encoding = "UTF-8")
head(speech,3)
speech <- gsub("<.*?>","",speech)
speech <- gsub("[\n\t]","",speech)

url <- "https://www.naver.com/"
naver <- getURL(url)
head(naver)
c <- unlist(str_extract_all(naver,"<span class=\"ah_k\">.*?</span>"))[1:10]
c
d <- unlist(regmatches(naver, gregexpr("<span class=\"ah_k\">.*?</span>",naver)))[1:10]
d
e <- grep("<span class=\"ah_k\">.*?</span>",naver,value=TRUE)
e
gsub("<.*?>","",c)
str_replace_all(d,"<.*?>","")

string <- "we \tare \nstudents"
string
cat(string)
gsub("[\t\n]","",string)
