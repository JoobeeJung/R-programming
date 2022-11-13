gsub("([[:alpha:]]).+?\\1","*","# a small thing makes a big difference #")
string <- "<div class='power'>100%</div>"
gsub("(<.*?>)(.*)(<.*?>)","\\2",string)


telephones <- "Barabasi, Albert-Laszlo917 1843James Bond(02)563-1987(1)John F.Kennedy051-
776-5879(123)Dr. Who(062) 324-9576McCartney, J. Paul0648323912"
telephones

name <- unlist(regmatches(telephones,gregexpr("[[:alpha:]., -]{2,}", telephones)))
name

pattern <- "\\(?(\\d{2,3})?(-| )?\\d{3}(-| )?\\d{4}\\(?(\\d{1,3})?\\)?"
phone <- unlist(regmatches(telephones, gregexpr(pattern , telephones)))
phone
data.frame(name, phone)

library(RCurl)
url <- "https://www.naver.com/"
text <- getURL(url)
pattern <- "(<span class=\"ah_k\">.*?</span>)"
a<- unlist(regmatches(text, gregexpr(pattern, text)))[1:10]

gsub("<.*?>","",a)

readtext <- readLines(url, encoding = "UTF-8")
grep("ah_k",readtext, value=TRUE)[1:10]

url <-"http://www.abrahamlincolnonline.org/lincoln/speeches/gettysburg.htm"
text <- getURL(url)
head(text)
b <- gsub("<.*?>","",text)
gsub("\n|\t","",b)
