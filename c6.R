library(plyr)
library(RCurl)
library(stringr)
library(XML)
library(RJSONIO)


setwd("D:\\rwebscraping")

fortunes1 <- htmlParse("fortunes1.html")





fortunes2 <- htmlParse("fortunes2.html")
jsfiles <- xpathSApply(fortunes2, "/html/head/script", fun = xmlAttrs)
jsscript <- grep("^scrip*", jsfiles, value = TRUE)
jscode <- readLines(jsscript)
firstit <- grep("load.+\\.html",jscode, value = TRUE)
quote_pat <- str_split(firstit, '\\\"')[[1]][[4]]
quotes <- htmlParse(quote_pat)
xpathSApply(quotes, "/*/h1", fun = xmlAttrs)
xpathSApply(quotes, "//html/body/*/h1", fun = xmlValue)
# xpathSApply(quotes, "/html/body/div/h1")
# xpathSApply(quotes, "//h1")
# xpathSApply(quotes, "//div")
# xpathSApply(quotes, "//div/h1")
xpathSApply(quotes, "//div/h1")


fortunes3 <- fromJSON("quotes/all_quotes.json")
#sources <- sapply(fortunes3[[1]], "[[", "source")
sources <- sapply(fortunes3, "[[", "source")


seatle_viol <- htmlParse("https://data.seattle.gov/Community/Seattle-code-violations-database/8agr-hifc")
xpathSApply( seatle_viol, "//*[@id='blist-t1-r17']", fun= xmlName)
xpathSApply( seatle_viol, "//*[@id='blist-t1-r17']", fun= xmlValue)




xpathSApply(seatle_viol, "/html/body", fun= xmlChildren)
xpathSApply(seatle_viol, "/html/body", fun= xmlValue)

seatle_viol2 <- htmlParse("https://data.seattle.gov/Community/Seattle-code-violations-database/8agr-hifc")

xpathSApply(seatle_viol  , "/html/body/*/*[@id='blist-t1-r17']", fun= xmlValue)
xpathSApply(seatle_viol  , "//div[@id='blist-t1-r17']", fun= xmlName)
xpathSApply(seatle_viol  , "//*[@id='blist-t1-r17']", fun= xmlChildren)

xpathSApply( seatle_viol, "//*[@id='blist-t1-r17']", fun= xmlName)
xpathSApply( seatle_viol, "//div[@id='blist-t1-r17']", fun= xmlName)

xpathSApply( seatle_viol, "//*[@id='blist-t1-r39']/div[2]",  fun= xmlValue)
xpathSApply( seatle_viol, "//*[@id='blist-t1-r39']/div[2]")

xpathSApply( seatle_viol, '//*[@id="renderTypeContainer"]/div[3]')


xpathSApply( seatle_viol, '/html/body', fun= xmlChildren)
xpathSApply( seatle_viol, '//*[@id="skipLinks"]', fun= xmlChildren)
xpathSApply( seatle_viol, '//*[@id="skipLinks"]', fun= xmlValue)


//*[@id="blist-t1-r22"]

//*[@id="blist-t1-r25"]

xpathSApply(seatle_viol  , '//*[@id="blist-t1"]/div[3]/div/div[1]', fun= xmlChildren)
xpathSApply(seatle_viol  , "//*[@id='blist-t1']/div[3]/div/div[1]", fun= xmlValue)


seatle_viol3 <- htmlParse("https://assets.zendesk.com/external/zenbox/v2.1/loading.html")
xpathSApply(seatle_viol3  , "//*[@id='blist-t1-r17']", fun= xmlChildren)


#blist-t1-r42


xpathSApply( seatle_viol, "/html/body/div[2]/div/div[5]/div[1]/div[3]/div[2]/div[3]/div/div[1]/div[28]/div")

xpathSApply( seatle_viol, "/html/body/div[2]/div/div[5]/div[1]/div[3]/div[2]/div[3]/div/div[1]/div[13]", fun= xmlValue)

xpathSApply( seatle_viol, "/html/body/div[2]/div/div[5]/div[1]", fun= xmlValue)

xpathSApply( seatle_viol, '//*[@id="blist-t1-r15"]', fun= xmlValue)








//*[@id="blist-t1-r13"]