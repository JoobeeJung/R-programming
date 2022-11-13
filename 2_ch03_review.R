string <- c("banana is yellow",
            "panda is next to bamboo",
            "X-men are dancing the samba")
string
grep("X-men",string)
grep("X-men",string, value=TRUE)
grep("x-men",string, ignore.case=TRUE, value=TRUE)

grep("ana",string, value=TRUE)
grep("next to", string, value=TRUE)
grep("ba", string, value = TRUE)
grep("^ba", string, value = TRUE)
grep("ba$", string, value = TRUE)
grep("banana|bamboo",string, value = TRUE)
grep("p.", string, value = TRUE)

string <- c("R version 3.4.4 (2018-03-15)",
            "Platform: X86_64-w64-mingw32/x6",
            "R is free software and comes with ABSOLUTELY NO WARRANTY")
string
grep("[Aa]",string, value = TRUE)
grep("[0-9]",string, value = TRUE)
grep("[A-Q]",string, value = TRUE)
grep("[uqz.]",string, value = TRUE)
grep("[^0-9a-zA-Z]",string, value = TRUE)

string <- "Tweet (@tweet) Food for thought 2020-10-07"
string
gsub("[[:alpha:]]", "",string)
gsub("[:alpha:]", "",string)
gsub("[[:alnum:]]","*",string)
gsub("[[:punct:]]","*",string)
gsub("[[:digit:]]","*",string)
gsub("[[:blank:]]","*",string)

gsub("[^[:blank:]]","_",string)
gsub("[[:punct:]0-9 ]","",string)
gsub("t[[:alpha:]][[:alpha:]][[:alpha:]]t","*",string)

string
gsub("t[[:alpha:]]{3}t","*",string)
gsub("t[[:alpha:]]{5}t","*",string)

string <- c("x","xz","xyz","xyyz","xyyyz","xyxyxyz")
string
grep("xy?z",string, value = TRUE)
grep("xy*z",string, value = TRUE)
grep("xy+z",string, value = TRUE)
grep("xy{2}z",string, value = TRUE)
grep("xy{2,}z",string, value = TRUE)
grep("xy{2,3}z",string, value = TRUE)
grep("(xy){2,3}",string, value = TRUE)
grep("xy{2,3}",string, value = TRUE)

string <- "eeeAiiZoooAuuuZeee"
string
regmatches(string, gregexpr(pattern="A.*Z",text = string))
regmatches(string, gregexpr(pattern="A.*?Z",text = string))
grep("A.*Z",string,value=TRUE)
grep("A.*?Z",string,value=TRUE)

html.doc <- "<TITLE>HAPPY Days</TITLE>"
gsub("<.*>","",html.doc)
gsub("<.*?>","",html.doc)

string <- 'Alice\'s Adventures'
string

string <- "long\t\ttab lines can be \nbroken with newlines"
string
cat(string)

cat(gsub("\t\t"," ", string))

string <- "I need 100$, but she gave me a ^. I\\don't\\know\\why."
string
cat(string)
gsub("\\.","!",string)
gsub("\\$"," dollars",string)
gsub("\\^","carrot",string)
gsub("\\\\"," ",string)
gsub("\\^\\.", "carrot!",string)
gsub("^.", "carrot!",string, fixed = TRUE)

gsub("\\w","*","1. Alice's Adventures in Wonder_land!")
gsub("\\W","*","1. Alice's Adventures in Wonder_land!")

gsub("\\W+","+","1. Alice's Adventures in Wonder_land!")
gsub("\\w+","+","1. Alice's Adventures in Wonder_land!")

gsub("\\d+","*","111 + 22 = 133")
gsub("\\D+","_","111 + 22 = 133")

string <- "Badly \t spaced text \n can be fixed."
cat(string)
gsub("\\s+"," ", string)
gsub("\\S+"," ", string)

gsub("\\b","_","Through the Looking-Glass",perl = TRUE)
gsub("s\\b","ses","Through the Looking-Glass",perl = TRUE)
gsub("\\B","_","Through the Looking-Glass",perl = TRUE)

gsub("\\<b", "*", "banana is next to bamboo and panda")
gsub("^b", "*", "banana is next to bamboo and panda")
gsub("a\\>", "*", "banana is next to bamboo and panda")
gsub("a$", "*", "banana is next to bamboo and panda")

gsub("([[:alpha:]]).+?\\1","*","# a small thing makes a big difference #")

string <- "Badly \t spaced text \n can be fixed."
cat(string)
gsub("\\s+"," ", string)
gsub("\\S+"," ", string)

gsub("\\b","_","Through the Looking-Glass",perl=TRUE)
gsub("s\\b","ses","Through the Looking-Glass",perl=TRUE)
gsub("\\B","_","Through the Looking-Glass",perl=TRUE)

gsub("\\<b", "*", "banana is next to bamboo and panda")
gsub("^b", "*", "banana is next to bamboo and panda")

gsub("a\\>", "*", "banana is next to bamboo and panda")
gsub("a$", "*", "banana is next to bamboo and panda")

string <- "<div class='power'>100%</div>"
gsub("(<.*?>)(.*)(<.*?>)","\\2",string)
gsub("(<.*?>)(.*)(<.*?>)","\\1",string)
gsub("(<.*?>)(.*)(<.*?>)","\\3",string)

telephones <- "Barabasi, Albert-Laszlo917 1843James Bond(02)563-1987(1)John F.Kennedy051-
776-5879(123)Dr. Who(062) 324-9576McCartney, J. Paul0648323912"
telephones

name <- unlist(regmatches(telephones, gregexpr("[[:alpha:]., -]{2,}", telephones)))
name

unlist(regmatches(telephones, gregexpr("[[:alpha:]., -]", telephones)))
unlist(regmatches(telephones, gregexpr("[[:alpha:]., -]{1,}", telephones)))

pattern <- "\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,3})?\\)?"
phone <- unlist(regmatches(telephones, gregexpr(pattern , telephones)))
phone

data.frame(Name=name, Phone=phone)

library(stringr)
name <- unlist(str_extract_all(telephones,"[[:alpha:]., -]{2,}"))
name
phone <- unlist(str_extract_all(telephones,"\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,3})?\\)?"))
phone
data.frame(Name=name, Phone=phone)

#####3.2 텍스트 함수####
string <- c("data analytics is useful",
            "business analytics is helpful",
            "visualization of data is interesting for data scientists")
grep("data",string, value=TRUE)
string[grep("data",string)]
grep("useful|helpful", string, value = TRUE, invert = TRUE)
grepl("data",string)

head(state.name)
grepl("new",state.name,ignore.case=TRUE)
state.name[grepl("new",state.name,ignore.case=TRUE)]
sum(grepl("new",state.name,ignore.case=TRUE))

regexpr("data",string)
gregexpr("data",string)

regmatches(string, regexpr("data",string))
regmatches(string, gregexpr("data",string))

regmatches(string, gregexpr("data",string),invert = TRUE)
sub("data","text",string)
gsub("data","text",string)

strsplit(string," ")
unlist(strsplit(string," "))
unique(unlist(strsplit(string," ")))

library(stringr)
string <- c("data analytics is useful",
            "business analytics is helpful",
            "visualization of data is interesting for data scientists")
string
str_detect(string, "data")
str_detect(string, fixed("DATA", ignore_case=TRUE))
str_detect(c("abz","ayz","a.z"),"a.z")
str_detect(c("abz","ayz","a.z"),fixed("A.Z",ignore_case = TRUE))
str_detect(c("abz","ayz","a.z"),"a\\.z")

str_locate(string, "data")
str_locate_all(string , "data")

str_extract(string, "data")
str_extract_all(string, "data", simplify = TRUE)

unlist(str_extract_all(string, "data"))

sentences5 <- sentences[1:5]
sentences5

str_extract(sentences5, "(a|A|the|The) (\\w+)")
str_match_all(sentences5, "(a|A|the|The) (\\w+)")

name.pattern <- "([[:alpha:]., -]{2,})"
phone.pattern <- "\\(?(\\d{2,3})?\\)?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,3})?\\)?"
phonebook <- str_match_all(telephones, paste0(name.pattern, phone.pattern))
phonebook<- phonebook[[1]]
phonebook

phonebook[,2]
phonebook[,3]
data.frame(Name=phonebook[,2],Phone=phonebook[,3])

str_replace(string, "data", "text")
str_replace_all(string, "data", "text")

str_split(string, " ")
unique(unlist(str_split(string, " ")))
str_split(string, " ", n=3, simplify = TRUE)

str_length(string)
str_count(string, "data")
str_count(string, "\\w+")
str_pad(string=c("a","abc","abcde"),width = 6, side = "left",pad=" ")
mon <- c(1:12)
str_pad(mon, width=2, side="left", pad="0")

str_pad <- str_pad(string, max(str_length(string)), side="both", pad=" ")
str_pad
str_trim(str_pad, "both")

str_c("data","mining",sep=" ")
str.mining <- str_c(c("data mining","text mining"),"is useful", sep = " ")
str.mining
str_c(str.mining, collapse = ";")
str_c(str.mining, collapse = "\n")
cat(str_c(str.mining, collapse = "\n"))

str_sub(str.mining, start = 1, end = 4)
str_sub(str.mining,5,5)<- "-"
str.mining

str_sub("abcdefg",-2)
str_sub("abcdefg",end=-3)

Sys.getlocale()
Sys.setlocale("LC_CTYPE")
localeToCharset()
star <- "별 헤는 밤, Copyright 1941. 윤동주."
star
Encoding(star)
star2 <- iconv(star, from=localeToCharset(),to="UTF-8")
Encoding(star2) <-"CP949"
Encoding(star2) <-"UTF-8"
star2

length(iconvlist())
sample(iconvlist(),10)

library(RCurl)
library(stringr)
enc.chk <- getURL("https://www.naver.com")
Encoding(enc.chk)
unlist(str_extract_all(enc.chk,"<meta.+?>"))[1:2]
Encoding(enc.chk)

library(readr)
guess_encoding("https://www.naver.com")
enc.chk <- getURL("http://www.mk.co.kr/")
unlist(str_extract_all(enc.chk,"<li class=('first2'|'add')>.*?</li>"))

unlist(str_extract_all(enc.chk,"<meta.+?>"))[1:2]
enc <- as.character(guess_encoding("http://www.mk.co.kr/")[1,1])
enc
enc.chk <- getURL("http://www.mk.co.kr/",.encoding = enc)
unlist(str_extract_all(enc.chk,"<li class=('first2'|'add')>.*?</li>"))
