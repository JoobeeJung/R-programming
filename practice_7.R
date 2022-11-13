library(quantmod)
ibm <- getSymbols(Symbols = "IBM", auto.assign = FALSE)
head(ibm)
tail(ibm)
library(WDI)
WDIsearch("gdp")[1:5,]
WDIsearch("gdp.*capita.*current")
WDIsearch("Umemployment, Total")
WDI(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL>ZS"),
    start = 2005, end=2014)
library(wbstats)
wbsearch("gdp.*capita.*current")
wbsearch("Umemployment, Total")
wb(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"),
   startdate = 2015, enddate = 2014)
wb.data <- wb(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"),
              startdate = 2005, enddate = 2014)
wb.data[-4]
wb(country = "KR", indicator = c("NY.GDP.PCAAP.CD", "SL.UEM.TOTL.ZS"), mrv=10)
wbsearch("crude oil")
install.packages(lubridate)
library(lubridate)
crude.oil <- wb(indicator = c("CRUDE_DUBAI","CRUDE_BRENT","CRUDE_WTI","CRUDE_PETRO"),
                startdate = "2011M01", enddate = "2015M12", freq = "M", POSIXct = TRUE)
library(ggplot2)

pi
sqrt(3)
print(pi)
print(sqrt(3))
print(matrix(c(1,2,3,4), ncol=2))
print(list("Batman","Spiderman","Ironman"))
print("The square root of 3 is", sqrt(3), ".")
cat("The square root of 3 is", sqrt(3), ".")
cat("The square root of 3 is", sqrt(3), "\b","\n")
name <- "Jenny"
cat("Hello", name, "\b.\n", "Isn\'t it", "\t", "A LOVELY DAY?\n")

prime <- c(2,3,5,7,11,13,17,19)
cat("The prime numbers are: ", prime, "...\n")
hero  <- list("Batman", "Spiderman", "Ironman")
cat(hero)
cat(unlist(hero),"\n")
pi
pi*100
pi/100
print(pi, digits=3)
print(pi*100, digits = 3)
cat(pi, "\n")
cat(format(pi, digits = 3),"\n")

x <- c(30, 50, 90)
tlength <- round(x*0.9144, digits = 1)
result <- paste(tlength, "m", sep="")
print(result)
source("transLength.R")
transLength <- function(x){
  tlength <- round(x*0.9144, digits = 1)
  result <- paste(tlength, "m", sep="")
  return(result)}

