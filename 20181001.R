search()

string <- c("data analytics is useful",
            "business analytics is helpful",
            "visualization of data is interesting for data scientists")
grep("data", string) ##인덱스 반환
?grep
grep("data", string, value=TRUE)

string[grep("data", string)]

grep("useful|helpful", string, value=TRUE, invert=TRUE)

grepl("data", string)

head(state.name)
grepl("new", state.name, ignore.case=TRUE)
state.name[grepl("new", state.name, ignore.case=TRUE)]
sum(grepl("new", state.name, ignore.case=TRUE))

regexpr("data", string)
gregexpr("data",string)
?regmatches

regmatches(string, regexpr("data", string))
regmatches(string, gregexpr("data", string))
regmatches(string, gregexpr("data", string), invert = TRUE)

sub("data", "text", string)
gsub("data", "text", string)

strsplit(x=string, split = " ")
unlist(strsplit(x=string, split = " "))
unique(unlist(strsplit(x=string, split = " ")))

library(stringr)
search() ##r에서 어떤 패키지를 사용할 지 알려줌 탐색경로 

string<- c("")
?str_detect
str_detect(string, "data")
str_detect(string, "DATA")
str_detect(string, fixed("DATA", ignore_case=TRUE))
str_detect(c("abz","ayz","a.z"),"a.z")
str_detect(c("abz","ayz","a.z"),fixed("a.z"))
str_detect(c("abz","ayz","a.z"),"a\\.z")

str_locate(string, "data")
str_locate_all(string, "data")

str_extract(string, "data")
str_extract_all(string, "data")
str_extract_all(string, "data", simplify = TRUE)

unlist(str_extract_all(string, "data"))

sentences5 <- sentences[1:5]
sentences5

str_extract(sentences5, "(a|A|the|The) (\\w+)")
str_match(sentences5, "(a|A|the|The) (\\w+)")
str_match_all(sentences5, "(a|A|the|The) (\\w+)")

##telephones <-

str_replace(string, "data", "text")
str_replace_all(string, "data", "text")

str_split(string, " ")
unlist(str_split(string, " "))

str_split(string, " ", n=3)
str_split(string, " ", n=3, simplify = TRUE)

str_length(string)
str_count(string, "data")
str_count(string, "\\w+")

str_pad(string=c("a","abc","abcde"),width = 6, side="left", pad=" ")

mon <- c(1:12)

str_c("data","mining", sep=" ")


#####encoding

Sys.getlocale()
Sys.localeconv() ##한글의 sorting 방식 

localeToCharset()

star <- "별 헤는 밤, Copyright 1941. 윤동주."
star

Encoding(star)
localeToCharset()

star2 <- iconv(star, from=localeToCharset(), to="UTF-8")
Encoding(star2)
star2
Encoding(star2) <- "CP949"
star2

length(iconvlist())
library(RCurl)
enc.chk <- getURL(url = "https://www.naver.com", ssl.verifyper=FALSE)
enc.chk <- getURL(url="https://news.stanford.edu/2005/06/14/jobs-061505/", ssl.verifper=FALSE)
enc.chk
unlist(str_extract_all(enc.chk, "<meta.+?>"))[1:2]
Encoding(enc.chk)

library(readr)
guess_encoding(file="https://www.naver.com")

enc.chk <- getURL(url="https://www.mk.co.kr")
a <- getURL(url="https://news.stanford.edu/2005/06/14/jobs-061505/", SSL.VERIFYER=FALSE)
unlist(ebc.chk)

####
library(RCurl)
url <-"http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
html <- getURL(url)
html
pattern <- "<.*?>"
text <- gsub(pattern,"",html)
text
text <- gsub("[\n\t]","",text)
text

url <- "https://www.naver.com/"
text<- getURL(url)
pattern <- "<span class=\"ah_k\">.*?</span>"
unlist(regmatches(text, gregexpr(pattern, text)))[1:10]
gsub(pattern="<.*?>","", unlist(regmatches(text, gregexpr(pattern, text))))[1:10]
##스티브잡스 연설(스탠포드 홈페이지 가서 해보기 )
install.packages("curl")
library(RCurl)
library(readr)
url <- "https://news.stanford.edu/2005/06/14/jobs-061505/"
speech <- getURL(url, ssl.verifypeer = FALSE)
speech <- getURL("http://news.stanford.edu/2005/06/14/jobs-061505", cainfo = "path to R/library/RCurl/CurlSSL/ca-bundle.crt")
head(speech)
?getURL
speech

library(RCurl)
speech <- getURL(url, ssl.verifypeer=FALSE)

speech <- readLines(url, encoding = "UTF-8")
head(speech)
grep("<!.*?>",speech,value=TRUE)[1:20]
speech <- gsub("<!.*?>","",grep("[[:graph:]]",speech,value = TRUE))
speech <- unlist(gsub("<.*?>","",speech))
speech <- gsub("<!.*?>","",grep("",speech,value=TRUE)[1])
head(speech)
speech[1:20]
library(stringr)
speech <- str_trim(speech)
speech <- gsub("\\n","",speech)
cat(speech)
speech <- gsub("\\<(_|-|-|/|\\|)?","",speech)
speech <- character(0)
speech <- gsub("[\n\t]","",speech)
speech <- gsub("[^[:alnum:]_]","",speech)


#####################new
library(RCurl)
url <- "http://news.stanford.edu/2005/06/14/jobs-061505/"
speech <- getURL(url, .encoding = "UTF-8",ssl.verifypeer=FALSE)
speech
speech <- unlist(readLines(url,encoding = "UTF-8"))
speech <- scan(url, skip=50)
speech[1:100]

library(stringr)
speech <- str_trim(speech)
speech <- gsub("<.*?>","",speech)
speech <- gsub("</?\\w+((\\s+\\w+(\\s*=\\s*(?:\".*?\"|'.*?'|[^'\">\\s]+))?)+\\s*|\\s*)/?>","",speech)
speech[11:50] <- gsub("\\W+","",speech[11:50])
speech[18] <- " "
cat(speech)

speech[1:100]
address <- character(0)
skip=300
for(i in 1:5){
  one.line <- scan(url, what="",skip=skip, nlines = 1,encoding="UTF-8")
  address[i] <- paste(one.line, collapse = " ")
  skip = skip+1
}
address

string <- "eeeAiiZoooAuuuZeee"
string
grep("A.*Z",string, value=TRUE)
grep("A.*?Z",string, value=TRUE)

string <- "1. Alice's Adventures in wonder_land"
string
