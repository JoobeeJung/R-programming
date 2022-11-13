x <- "We have a dream"
nchar(x)
length(x)

y <- c("We","have","a","dream")
y
length(y)
nchar(y[4])
nchar(y)

sort(letters)
sort(letters, decreasing = TRUE)
?sort

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says)
toupper(fox.says)

fox.said <- "What Is essential is invisible to the eye"
fox.said
strsplit(x=fox.said, split = " ")
strsplit(x=fox.said, split = "")

fox.said.words <- unlist(strsplit(fox.said, " "))
fox.said.words
fox.said.words[1]
strsplit(fox.said, " ")[[1]]

fox.said.words <- strsplit(fox.said, " ")[[1]]
unique(fox.said.words)
unique(tolower(fox.said.words))

paste("Everybody","wants","to","fly")
paste(c("Everybody","wants","to","fly"))

fox.said <- "WHAT IS ESSENTIAL is invisible to the Eye"
fox.said.words <- strsplit(fox.said," ")[[1]]      
fox.said.words
paste(fox.said.words)
?paste

paste("25 degrees Celsius is", 25*1.8 + 32)
heros <- c("Batman", "Captain America", "Hulk")
colors <- c("Black", "Blue", "Green")
paste(heros, colors)
paste("Type",1:5)

paste(heros,"want","to", "fly", collapse = ", and ")
paste(month.abb, 1:12, sep="_", collapse = "-")

outer(c(1,2,3), c(3,2,1))

asian.countries <- c("Korea", "China", "Japan")
info <- c("GDP", "Population", "Area")
x <- outer(asian.countries, info, FUN=paste, sep="-")
as.vector(x)
y <- outer(asian.countries, asian.countries, paste, sep="-")
y
y[!lower.tri(y)]

?sprintf
head(islands)
landmasses <- names(islands)
landmasses
index <- grep(patter="New", landmasses)
landmasses[index]
grep("New", landmasses, value = TRUE)
grep(" ", landmasses, value=TRUE)
landmasses[grep(" ", landmasses)]

txt <- "Data "

words <- c("at","bat","cat","chaenomeles","chase","chasse","cheap","check","cheese",
           "chick","hat")
grep("che", words, value = TRUE)
?regex


Sys.Date()
date()
Sys.time()
class(Sys.Date())

as.Date("2020-12-31")
?strptime

Sys.setlocale()
?POSIXlt
Sys.time()


##1
a <- c("Happy", "Birthday", "to", "You")
length(a)
sum(nchar(a))

#2
b <- paste(a, collapse = " ")
length(b)
sum(nchar(b))

#3
paste(LETTERS[1:10], 1:10)
paste(LETTERS[1:10], 1:10, sep="")
