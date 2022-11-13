install.packages("XML")
library(XML)
books <- xmlParse("books.xml") ##파싱된 결과물

books
root <- xmlRoot(books)
root[[1]][[1]]
/