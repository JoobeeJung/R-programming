car <- mtcars
g <- split(x=car$mpg, f=car$am)
g

install.packages("dplyr")
library(dplyr)
head(airquality)

air <- filter(airquality, Month==6)
head(air)

airquality[airquality$Month==6,]
subset(airquality, subset = (Month==6))

air <- filter(airquality, Month ==6, Temp > 90)
air <- filter(airquality, Month==6 &Temp >90)

install.packages("Lahman")
library(Lahman)
str(Batting)
head(Batting)

Batting.tbl.df <- tbl_df(Batting)
?tbl_df
Batting.tbl.df <- as_tibble(Batting)

install.packages("reshape2")
library(reshape2)

smiths
##전형적인 와이드포맷

smiths.long <- melt(data=smiths)
smiths.long
smiths.long <- melt(data=smiths, id.vars = "subject")

str(airquality)
head(airquality)

aq.long <- melt(airquality,
                id.vars = c("Month", "Day"))
head(aq.long)
tail(aq.long)

install.packages("tidyr")