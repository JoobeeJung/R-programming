?regex

string <- c("banana is yellow",
            "panda is next to bamboo",
            "X-men are dancing the samba")
string
grep(pattern="X-men", x=string) ##x-men이 패턴이됨 이를 가진 원소 찾아내 
grep(pattern="X-men", x= string, value=TRUE) ##실제 값을 보기위한 것 

grep(pattern="x-men", x= string, value=TRUE) ##소,대문자 구별함 
grep(pattern="X-men", x= string, value=TRUE, ignore.case=TRUE) ##대소문자 무시 

grep("ana", string, value=TRUE)
grep("next to", string, value=TRUE)

grep("ba", string, value=TRUE)
grep("^ba", string , value=TRUE) ##ba로 시작하는 패턴 
grep("ba$", string, value=TRUE) ##ba로 끝나는 패턴 

grep("banana|bamboo", string, value=TRUE)
grep("p.", string, value=TRUE)

###character class
string <- c("R version 3.4.4 (2018-03-15)",
            "Platform: X86_64-w64-mingw32/x6",
            "R is free software and comes with ABSOLUTELY NO WARRANTY")
string
grep("[Aa]", string, value=TRUE)##A또는 a 포함된 문자열 찾아주세요
grep("[0-9]", string, value=TRUE)
grep("[A-Q]", string, value=TRUE)
grep("[uqz.]",string, value=TRUE)

grep("[^0-9a-zA-Z ]", string, value=TRUE)

string <- "Tweet (@tweet) Food for thought 2020-10-07"
string
gsub(pattern="[[:alpha:]]", replacement = "",x=string)

gsub("[[:alnum:]]","*",string)
gsub("[[:punct:]]","*",string)
gsub("[[:digit:]]","*",string)
gsub("[[:blank:]]","*",string)

gsub("[^[:blank:]]","_", string)
gsub("[[:punct:]0-9 ]","", string)
gsub("t[[:alpha:]][[:alpha:]][[:alpha:]]t","*",string)

string
gsub("t[[:alpha:]]{3}t","*", string)
gsub("t[[:alpha:]]{5}t","*", string)

string <- c("x","xz","xyz","xyyz","xyyyz","xyxyxyz")
string
grep("xy?z",string, value=TRUE)
grep("xy*z",string, value=TRUE)
grep("xy+z",string, value=TRUE)
grep("xy{2}z",string, value=TRUE)
grep("xy{2,}z",string, value=TRUE)
grep("xy{2,3}z",string, value=TRUE)

grep("(xy){2,3}", string, value=TRUE)
grep("xy{2,3}", string, value=TRUE)


##greedy matching
string <- "eeeAiiZoooAuuuZeee"
string
regmatches(x=string, m=gregexpr(pattern="A.*Z", text=string))
regmatches(x=string, m=gregexpr(pattern="A.*?Z", text=string))

html.doc <- "<TITLE>Happy Days</TITLE>"
gsub("<.*>", "", html.doc)
gsub("<.*?>", "", html.doc)

string <- 'Alice's Adventures'
string <- 'Alice\'s Adventures'
string

string <- "long\t\ttab lines can be \nbroken with newlines"
string
string <- "I need 100 $, but she gave me a ^. I\\don't\\know\\why."
cat(string)
gsub(".", "!", string)
gsub("\\.","!", string)
gsub("\\$","dollars", string)
gsub("\\^","carrot", string)
gsub("\\\\", " ", string)
?cat

gsub("\\w","*", "1. Alice's Adventures in wonder_land!")
gsub("\\w+","*", "1. Alice's Adventures in wonder_land!") ##단어 자체를 매ㅐ칭 
gsub("\\W+","+", "1. Alice's Adventures in wonder_land!")
