library(httr)
library(XML)
url <- "https://www.amazon.com/Who-Moved-My-Cheese-Amazing/product-reviews/0399144463/ref=cm_cr_getr_d_paging_btm_1?ie=UTF8&reviewerType=all_reviews&pageNumber=1"
html <- GET(url)
html.parsed <- htmlParse(html)

product <- xpathSApply(html.parsed, "//h1/a[@data-hook='product-link']", xmlValue) 
product 

author <- xpathSApply(html.parsed, "//span[@data-hook='review-date']/parent::div",  
                      function(x) {val <- unlist(xpathSApply(x, ".//span[@class='a-profile-name']",  
                                                  if (is.null(val)) val <- "Amazon Customer"  
                                                  else val}) 
author

amazonReview <- function(baseurl, n=NULL){
  library(httr)
  library(XML)
  library(stringr)
  if(is.null(n)){
    url <- baseurl
    html <- GET(url)
    html.parsed <- htmlParse(html)
    total.pages <- xpathSApply(html.parsed,"//li[@class='page-button'][last()]/a", xmlValue) 
         total.pages <- as.numeric(gsub(",", "", total.pages)) 
         n <- total.pages
  }
  
  amazon.review <- data.frame() 
  for (i in c(1:n)) {                                                           
         spliturl <- unlist(strsplit(baseurl, "\\?")) 
         url <- paste0(str_sub(spliturl[1], end=-2), i, "?", 
                                           str_sub(spliturl[2], end=-2), i) 
     html <- GET(url)
     html.parsed <- htmlParse(html)
     product <- xpathSApply(html.parsed, "//h1/a[@data-hook='product-link']", xmlValue) 
     
     author <- xpathSApply(html.parsed, "//span[@data-hook='review-date']/parent::div",  
                           function(x) {val <- unlist(xpathSApply(x, ".//span[@class='a-profile-name']",  
                                                                  if (is.null(val)) val <- "Amazon Customer"  
                                                                  else val})
      amazon.r <- data.frame(product=product, author=author, stringsAsFactors=FALSE) 
     amazon.review <- rbind(amazon.review, amazon.r) 
        
                                     Sys.sleep(sample(10,1)*0.1)}
                                     amazon.review <- cbind(id=1:nrow(amazon.review), amazon.review)
                                     return(amazon.review)
  }
  