url <- "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=%s&solMonth=%s&ServiceKey=%s"
year <- "2018"
month <- "05"
key <- "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?solYear=2018&solMonth=05&ServiceKey=i0TZyaw8tFN7b%2B1bwQq0j%2B4eqzSsZmnz64zlf6z%2Blk9i4Xb%2FxIXWvD2xO7oxqHJpje6gRGiLexKgpExUalxtug%3D%3D"
sprintf(url,year,month,key)


library(glue)
url <- "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst?itemCode=PM10&dataGubun=DAILY&searchCondition=MONTH&pageNo={page}&numOfRows={row}&ServiceKey={key}"


library(openxlsx)
url <- "https://www.mois.go.kr/cmm/fms/FileDown.do?atchFileId=FILE_00081303NrLhQEe&fileSn=2"
