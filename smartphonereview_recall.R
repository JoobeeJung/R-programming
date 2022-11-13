#아이폰 리뷰 데이터 불러오기
iphone.review <- readRDS("iphone_review.rda")
#갤럭시 리뷰 데이터 불러오기 
galaxy.review <- readRDS("galaxy_review.rda")
#스마트폰 리뷰 데이터 불러오기
smartphone.review <- readRDS("galaxy_review.rda")

##아이폰 데이터 수집하기

###iphone5s
baseurl <- "https://www.ebay.com/urw/Apple-iPhone-5s-16GB-Space-Grey-Unlocked-A1457-GSM-/product-reviews/168512729?pgn=1"
iphone5s.review <- ebayreview(baseurl=baseurl)
iphone5s.review$review<-gsub("[^[:alnum:]///' ]", "",iphone5s.review$review) ##이모티콘 삭제 
