install.packages("XML")
library(XML)
books <- xmlParse("books.xml") ##?Ľ̵? ??????

books
root <- xmlRoot(books)
root[[1]][[1]]
/