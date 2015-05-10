library(plyr)
library(RCurl)
library(stringr)



getItalics <- function(){
  i_container <- character()
  list(i = function(node, ...){
    i_container <<- c(i_container, xmlValue(node))
  }, returnI = function() i_container
    )
}

h3 <- getItalics()

htmlTreeParse(url, handlers = h3)

h3$returnI()

download.file("http://en.wikipedia.org/wiki/Gate_control_theory", "D:\\rwebscraping\\wikigate.html")
wikigate <- readLines(con= "D:\\rwebscraping\\wikigate.html")
wiki_acti <- readLines(con = "http://en.wikipedia.org/wiki/Transportation_forecasting#Activity-based_models
")
wiki_church <- readLines(con = "http://en.wikipedia.org/wiki/Churchill_tank")


writeLines(wiki_church, "D:\\rwebscraping\\wikichurch.html" )


testrow <- c(1:131509)
summary(testrow)
summary(as.numeric(testrow))
max(testrow)

parsed_stocks <- xmlParse(file= "http://www.r-datacollection.com/materials/ch-3-xml/stocks/technology.xml", validate = TRUE)
parsed_stocks <- xmlParse(file= "http://www.r-datacollection.com/materials/ch-3-xml/stocks/technology-manip.xml", validate = TRUE)


bond <- xmlParse(file= "http://www.r-datacollection.com/materials/ch-3-xml/bond.xml")
class(bond)
root <- xmlRoot(bond)
xmlName(root)
xmlSize(root)

root[[1]]
root[[1]][[1]]

xmlSApply(root[[1]], xmlValue)
xmlSApply(root[[1]][[3]], xmlValue)


xmlToDataFrame(root)



isValidJSON("http://www.r-datacollection.com/materials/ch-3-xml/indy.json")

indy <- fromJSON(content = "http://www.r-datacollection.com/materials/ch-3-xml/indy.json")


indy.vec <- unlist(indy, recursive= TRUE, use.name = TRUE)

indy.vec[str_detect(names(indy.vec),"name")]

sapply(indy[[1]],"[[","year")

library(plyr)
indy.unlist <- sapply(indy[[1]],unlist)
indy.df <- do.call("rbind.fill",lapply(lapply(indy.unlist,t),data.frame, stringsAsFactors = FALSE))




peanuts.json <- fromJSON(content = "http://www.r-datacollection.com/materials/ch-3-xml/peanuts.json", nullValue = NA, simplify = FALSE)
peanuts.df <- do.call("rbind",lapply(peanuts.json,data.frame, stringsAsFactors = FALSE))

peanuts.json2 <- toJSON(peanuts.df,pretty = TRUE)
file.output <- file("D:\\rwebscraping\\peanuts_out.json")
writeLines(peanuts.json2, file.output)
close(file.output)


peanuts.json3 <- toJSON(t(peanuts.df),pretty = TRUE)
file.output <- file("D:\\rwebscraping\\peanuts_out.json2")
writeLines(peanuts.json3, file.output)
close(file.output)

x <- '[1,2,true,false]'
fromJSON(x)

family <- xmlParse(file = "D:\\rwebscraping\\familiy.xml")

records <- xmlParse(file = "D:\\rwebscraping\\records.xml")
recordroot <- xmlRoot(records)
xmlName(recordroot)
xmlSApply(recordroot[[1]], xmlValue)
xmlToDataFrame(recordroot)




isValidJSON("bond.json")
jbond <- fromJSON(content = "bond.json")


jbond[[1]]
jbond.unlist <-  lapply(jbond[[1]],unlist)
jbond.df <- do.call("rbind",jbond.unlist)

indy <- fromJSON(txt = "http://www.r-datacollection.com/materials/ch-3-xml/indy.json")

#chapter 3

parsed_doc <- htmlParse(file = "http://www.r-datacollection.com/materials/ch-4-xpath/fortunes/fortunes.html")
xpathSApply(doc= parsed_doc, path = "/html/body/div/p/i"  )

xpathSApply(doc= parsed_doc, path = "//p/i"  )

xpathSApply(doc= parsed_doc, path = "//div/p"  )
xpathSApply(doc= parsed_doc, path = "//p"  )

xpathSApply(doc= parsed_doc, path = "//div/*/i"  )
xpathSApply(doc= parsed_doc, path = "//p/i"  )
xpathSApply(doc= parsed_doc, path = "//i"  )



xpathSApply(doc= parsed_doc, "//h1/.."  )

xpathSApply(doc= parsed_doc, "//address | //title"  )

xpathSApply(doc= parsed_doc, "//a/ancestor::div"  )

xpathSApply(doc= parsed_doc, "//b/ancestor::div"  )

xpathSApply(doc= parsed_doc, "//b/ancestor::p"  )

xpathSApply(doc= parsed_doc, "//b/ancestor::p//a"  )

xpathSApply(doc= parsed_doc, "//emph/preceding-sibling::i"  )

xpathSApply(doc= parsed_doc, "//a/parent::*"  )

xpathSApply(doc= parsed_doc, "//div/p[position()=1]"  )

xpathSApply(doc= parsed_doc, "//div/p[last()]"  )

xpathSApply(doc= parsed_doc, "//div[count(.//b )> 0 and count(.//i)> 0]"  )

xpathSApply(doc= parsed_doc, "//div[count(.//b )> 0 and count(.//i)> 0 and count(.//emph) > 0]"  )

xpathSApply(doc= parsed_doc, "//div[count(./@* ) = 2] "  )

xpathSApply(doc= parsed_doc, "//div[count(./@* ) = 3] "  )

xpathSApply(doc= parsed_doc, "//h1[string-length(text()) < 15] "  )


xpathSApply(doc= parsed_doc, "//div[@lang='english'] "  )
xpathSApply(doc= parsed_doc, "//div[contains(@date, '20')] "  )

# xpathSApply(doc= parsed_doc, "//h1[contains(@value, 'Robert')] "  )
# xpathSApply(doc= parsed_doc, "//h1[contains(./@value, 'Robert')] "  )
# xpathSApply(doc= parsed_doc, "//*[contains(@value, 'Robert')] "  )

xpathSApply(doc= parsed_doc, "//h1[contains(text(), 'Robert')] "  )
xpathSApply(doc= parsed_doc, "//h1[contains(text(), 'Turner')] "  )


#xpathSApply(doc= parsed_doc, "//*[contains(@value, 'help')] "  )
xpathSApply(doc= parsed_doc, "//*[contains(text(), 'help')] "  )

xpathSApply(doc= parsed_doc, "//div[substring-after(./@date,'/') >= 2003]//i "  )

xpathSApply(doc= parsed_doc, "//b/ancestor::p//a" , fun = xmlValue )

xpathSApply(doc= parsed_doc, "//h1[contains(text(), 'Ro')] " , fun = xmlValue )

xpathSApply(doc= parsed_doc, "//h1[contains(text(), 'Ro')] " , fun = xmlAttrs)

xpathSApply(doc= parsed_doc, "//a/ancestor::div", fun = xmlAttrs  )

xpathSApply(doc= parsed_doc, "//a", fun = xmlAttrs  )

xpathSApply(doc= parsed_doc, "//a/ancestor::div", fun = xmlGetAttr, name = "date"  )

parsed_stocks <- xmlParse(file= "http://www.r-datacollection.com/materials/ch-3-xml/stocks/technology.xml", validate = TRUE)
companies <- c("Apple","IBM","Google")
expQuery <- sprintf("//%s/close", companies)
getClose <- function(node){
  value <- xmlValue(node)
  company <- xmlName(xmlParent(node))
  mat <- c(company = company, value = value)
}

stocks <- as.data.frame(t(xpathSApply(parsed_stocks, expQuery,getClose)))

xpathSApply(doc= parsed_doc, "//h1[text()[contains(., 'Robert')]]"  )

dateOctober <- function(x){
  require(stringr)
  date <- xmlGetAttr(node = x, name = "date")
  month <- str_extract(date,"[A-Za-z]+")
  month == "October"
}

xpathSApply(doc= parsed_doc, "//div",  dateOctober )


presidents <- xmlParse(file="http://www.r-datacollection.com/materials/ch-4-xpath/potus/potus.xml")

presidentsroot <- xmlRoot(presidents)

xpathSApply(presidents,"//president/name", fun =xmlValue)

president <- xpathSApply(presidents,"//president/name", fun =xmlValue)

startfirstterm <- 1789
start40term <- startfirstterm + 39 *4 -1

after40term <- function(x){
  require(stringr)
  children <- xmlChildren(x)
  beginyear <- xmlValue(children$start)
#  browser()
  #beginyear <- xmlGetAttr(node = x, name="start")
  year <- str_extract(beginyear, "[0-9]{4}$")
  year >= 1944
}


post40term <- xpathSApply(presidents,"//president", fun =after40term)

president[post40term]


republican <- function(x){
  require(stringr)
  children <- xmlChildren(x)
  party <- xmlValue(children$party)
  party == "Republican"
}

rep_pres <- xpathSApply(presidents,"//president", fun =republican)
occup <- xpathSApply(presidents,"//president/occupation", fun =xmlValue)
occup[rep_pres]

baptist <- function(x){
  require(stringr)
  children <- xmlChildren(x)
  party <- xmlValue(children$religion)
  party == "Baptist"
}

baptist_pres <- xpathSApply(presidents,"//president", fun =baptist)


occup[rep_pres & baptist_pres]

president[rep_pres & baptist_pres]

president[baptist_pres]


edu <- xpathSApply(presidents,"//president/education", fun =xmlValue)



getURL("http://www.r-datacollection.com/materials/http/helloworld.html")

pngfile <- getBinaryURL("http://www.r-datacollection.com/materials/http/sky.png")

writeBin(pngfile, "sky.png")

url <- "http://www.r-datacollection.com/materials/http/GETexample.php"
namepar <- "Laurent+Franckx"
agepar <- "477"
url_get <- paste(url,"?","name=",namepar,"&","age =", agepar,sep="")
cat(getURL(url_get))

cat(getForm(url, name = "Laurent Franckx", age = 47))

url <- "http://www.r-datacollection.com/materials/http/POSTexample.php"
cat(postForm(url, name = "Laurent Franckx", age = 47, style = "post"))


url <- "http://www.r-datacollection.com/materials/http/helloworld.html"
pres <- curlPerform(url = url)

content <- basicTextGatherer()
header <- basicTextGatherer()
debug <- debugGatherer()


performOptions <- curlOptions(url = url, writefunc = content$update, 
                              headerfunc = header$update, debugfunc = debug$update)


curlPerform(.opts = performOptions)

content$value()
header$value()

handle <- getCurlHandle(useragent = str_c(R.version$platform, R.version$version.string,sep=","),
                        httpheader=c(from = "ed@datacollection.com"), followlocation = TRUE, cookiefile = "")


res <- getURL(url=url, header= TRUE)
cat(str_split(res,"\r")[[1]])

handle <- getCurlHandle(customrequest = "HEAD")
res <- getURL(url = url, curl = handle)
cat(str_split(res,"\r")[[1]])

res <- getURL(url = url, curl = handle, header = TRUE)

res <- getURL("http://www.r-datacollection.com/materials/http/POSTexample.php", customrequest= "POST",
              postfields="name=Eddie&age=32")

cat(str_split(res,"\n")[[1]])

res <- getURL("httpbin.org/get")
cat(res)


debugInfo <- debugGatherer()

url <- "http://www.r-datacollection.com/materials/http/helloworld.html"
res <- getURL(url = url, debugfunction = debugInfo$update, verbose = TRUE )

debugInfo$value()

cat(debugInfo$value()[["text"]])

cat(debugInfo$value()[["headerIn"]])

cat(debugInfo$value()[["headerOut"]])

cat(debugInfo$value()[["dataIn"]])

cat(debugInfo$value()[["dataOut"]])

handle <- getCurlHandle()
res <- getURL(url = url, curl = handle )
handleInfo <- getCurlInfo(handle)


problemsH <- getCurlHandle(autoreferer = TRUE, httpheader= list(from = "franckx.laurent@gmail.com",
                                                                'user-agent'= str_c(R.version$platform, 
                                                          R.version$version.string,sep=",")) )

url <- "http://www.r-datacollection.com/materials/http/simple.html"
simple1 <- getURL(url = url, curl =  problemsH)
writeBin(simple1, "simple1.html")
simple2 <- getBinaryURL(url = url, curl =  problemsH)
writeBin(simple2, "simple2.html")
simple3 <- getURLContent(url = url, curl =  problemsH)
writeBin(as.vector(simple3), "simple3.html")


problemsH <- getCurlHandle(autoreferer = TRUE,cookiefile = "", httpheader= 
                             list(from = "franckx.laurent@gmail.com", followlocation = TRUE, 
                              'user-agent'= str_c(R.version$platform,  R.version$version.string,sep=",")
                              #,cookiefile = "RCurlCoockies.txt"                        
                              #, cookiejar= "" 
                              ))

h = basicTextGatherer()

returnverse <- function(){
  verse_aux <- getURL(url = "http://www.r-datacollection.com/materials/http/SessionCookie.php", 
                      curl =  problemsH, customrequest = "POST"
                      # , header = TRUE, headerfunction = h$update
                      #,write = basicTextGatherer(.mapUnicode = .mapUnicode)
  )
  verse_aux <- str_split(verse_aux, "\r")
  verse_aux <- grep("relaod",verse_aux[[1]],value = TRUE)
  verse_aux <- str_split(verse_aux, "\n")
  verse_aux <- verse_aux[[1]][3]
  return(verse_aux)
}

verse <- returnverse()
loop_continue <- TRUE
while(loop_continue){
  verse_aux <- returnverse()
  cat(verse_aux, "\n")
  if(verse_aux == verse[1]) loop_continue <- FALSE else verse <- c(verse,verse_aux) 
  cat(verse,"\n")
}

postForm(uri = "http://www.r-datacollection.com/materials/http/SessionCookie.php", 
       curl =  problemsH)

getURLContent(url = "http://www.r-datacollection.com/materials/http/SessionCookie.php", 
         curl =  problemsH)


prestest <- NULL

curlPerform(url = "http://www.r-datacollection.com/materials/http/SessionCookie.php", 
              curl =  problemsH, writefunc = function(con) prestest <<- con)



info <- debugGatherer()

problemsD <- getCurlHandle(autoreferer = TRUE, httpheader= 
                             list(from = "franckx.laurent@gmail.com", followlocation = TRUE, 
                                  'user-agent'= str_c(R.version$platform,  R.version$version.string,sep=","),
                                  cookiefile = "RCurlCoockies.txt" ), debugfunction = info$update)


problemsD <- getCurlHandle(autoreferer = TRUE, httpheader= 
                             list(from = "franckx.laurent@gmail.com", followlocation = TRUE, 
                                  'user-agent'= str_c(R.version$platform,  R.version$version.string,sep=","),
                                  cookiefile = "" ), debugfunction = info$update)

url <- "http://www.r-datacollection.com/materials/http/simple.html"
simple1 <- getURL(url = url, curl =  problemsD)
simple2 <- getBinaryURL(url = url, curl =  problemsD)
simple3 <- getURLContent(url = url, curl =  problemsD)







