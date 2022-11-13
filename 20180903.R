read.table(file="product.txt")
p <- read.table("product.csv", as.is=TRUE)
p
?read.table
str(p)
p <- read.table("product.txt", header = TRUE, stringsAsFactors= FALSE)
read.table("product-missing.txt", header = TRUE)
read.table("product-missing.txt", header = TRUE, na.strings = ".")

url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
iris <- read.csv(url, header = FALSE)
head(iris)

colnames(iris) <- c("sepal.length", "sepal.width","petal.length",
                    "petal.width", "species")
summary(iris)
aggregate(iris[1:4])
install.packages("ggplot2")
library(ggplot2)
windows(width=7.0, height=5.5)
ggplot(iris, aes(x=petal.length, y=petal.width, color=species, shape=speices)) +
  geom_point(position="jitter")+
  scale_color_discrete(lables=c("Setosa","versicolor", "virginica"))


url <- "https://www.nrc.gov/reading-rm/doc-collections/event-status/reactor-status/PowerReactorStatusForLast365Days.txt"
npower <- read.table(url, sep="|", header = TRUE, stringsAsFactors = FALSE)
str(npower)
View(npower)
npower$ReportDt <- as.Date(npower$ReportDt, format="%m/%d/%Y")
head(npower, 3);tail(npower, 3)

some <- npower[npower$Unit == as.character(unique(npower$Unit)[1:12]),]
some
library(ggplot2)
Sys.setlocale("LC_TIME", "English")
windows(width = 7.0, height = 7.0)
ggplot(some, aes(x=ReportDt, y=Power))

cloud.seeding <- scan("http://lib.stat.cmu.edu/datasets/cloud",
                      skip=15,
                      nlines=108,
                      what=list(period = character(0),
                                seeded = character(0),
                                season = character(0),
                                te = numeric(0),
                                tw = numeric(0),
                                nc = numeric(0),
                                sc = numeric(0),
                                nwc = numeric(0)))
str(cloud.seeding)

#alice
url <- "http://www.gutenberg.org/files/11/11-0.txt"
alice <- readLines(url, n=100, encoding = "UTF-8")
alice[1:10]
alice.chap1 <- character(10)
skip=40
for (i in 1:10){
  one.line <- scan(url, what="", skip=skip, nlines=1, encoding = "UTF-8")
  alice.chap1[i] <- paste(one.line, collapse = " ")
  skip = skip + 1
}
alice.chap1
########
url <- "https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001404440&fileDetailSn=1&publicDataDetailPk=uddi:9ee2fba3-0330-4041-81fa-d915841276fe"
library(openxlsx)
admin.agency <- read.xlsx(url)
names(admin.agency)
length(admin.agency)
nrow(admin.agency)
head(admin.agency[c(6,7,9)],3)
tail(admin.agency[c(6,7,9)],3)
