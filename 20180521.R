install.packages("quantmod")
library(quantmod)
ibm <- getSymbols(Symbols="IBM", auto.assign = FALSE)
head(ibm)
tail(ibm)
ibm

sessionInfo()
packageVersion("quantmod")
install.packages("WDI")
library(WDI)
WDIsearch("unemployment")[1:5,]
WDIsearch("gdp.*capita.*current")
WDIsearch("Unemployment, Total")

WDI(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"), start = 2007, end = 2016)

install.packages("wbstats")
library(wbstats)

wbsearch("gdp.*capita.*current")
wbsearch("Unemployment, Total")
wb(country = "KR", indicator = c("NY.GDP.PCAP.CD", "SL.UEM.TOTL.ZS"), start = 2007, end = 2016)

wb.data <- wb(country = c("KR","JP","EU","US"), indicator = "NY.GDP.PCAP.CD", startdate = 1997, enddate = 2016 )
wb.data$date <- as.numeric(wb.data$date)
wb.data[-5]

install.packages("ggplot2")
library(ggplot2)
# ggplot(wb.data, aes(x=date, y= value, color=indicator)) + geom

pi
print(pi)

prime <- c(2,3,5,7,11,13,17,19)
cat(prime, file="prime.txt", sep="\t","\n")

file.create("temp.txt")
file.exists("temp.txt")
file.remove("temp.txt")
file.exists("temp.txt")

install.packages("RODBC")
library(RODBC)
saledb <- odbcConnect(dsn="Sale")
class(saledb)
odbcGetInfo(channel= saledb)
sqlTables(channel = saledb)
sqlColumns(channel = saledb, sqtable = "Customer")
sa <- sqlFetch(channel = saledb, sqtable = "Orders")
str(sa)
head(sa)
options(scipen = 999)
tail(sa)

subset(sa, 
       select = c("order_date", "customer_no", "product_no"),
       subset = (sa$amount >= 5000000))
odbcCloseAll()
head(USArrests)
library(RODBC)
arrestdb <- odbcConnect(dsn="Arrest")
sqlTables(arrestdb)

install.packages("RSQLite")
library(RSQLite)

drv <- dbDriver("SQLite")
class(drv)
saledb <- dbConnect(drv=drv, dbname="Sale.sqlite")
saledb <- dbConnect(SQLite(), dbname="Sale.sqlite")
dbListTables(conn=saledb)
#dbGetQuery(conn=saledb, statement =)

dbDisconnect(saledb)

library(RSQLite)
irisdb <- dbConnect(SQLite(), "iris.sqlite")
dbDisconnect(irisdb)

##########ch 8##################
x <- c(30, 50, 90)
tlength <- round(x*0.9144, digits = 1)
