
# load packages
library(RCurl)
library(XML)
library(stringr)
library(plyr)
library(dplyr)

cog_bias_url <- "https://en.wikipedia.org/wiki/List_of_cognitive_biases"
cog_bias_source <- readLines(cog_bias_url, encoding = "UTF-8")
cog_bias_parsed <- htmlParse(cog_bias_source, encoding = "UTF-8")

xpathSApply(cog_bias_parsed, "//h2/span", fun= xmlAttrs)

#getHTMLLinks(cog_bias_parsed, xpQuery = "//h2/span[@id='Social_biases']/ancestor::h2/following-sibling::table/*/td/b/a/@href")

getHTMLLinks(cog_bias_parsed, xpQuery = "//h2/span[@id='Social_biases']/ancestor::h2/following-sibling::table[position()=1]/*/td/b/a/@href")

MP_url <- "https://en.wikipedia.org/wiki/List_of_MPs_elected_in_the_United_Kingdom_general_election,_1992"
MP_contents <- getURL(MP_url, ssl.verifypeer = FALSE)

all_table <- readHTMLTable(MP_contents, stringsAsFactors = FALSE, header = TRUE)
MP_table <- all_table[[4]]
names(MP_table) <- MP_table[1, ]
MP_table <- MP_table[-1, ]
sirs <- grep("Sir", MP_table$MP)
MP_sirs <- MP_table[sirs, ]
dplyr::group_by(MP_sirs, Party)
#MP_sirs %>% group_by(Party) %>% summarise()
dplyr::count(MP_sirs, Party)


list_of_cap_url <- "https://en.wikipedia.org/wiki/List_of_national_capitals_by_population"
list_of_cap_source <- readLines(list_of_cap_url, encoding = "UTF-8")
list_of_cap_parsed <- htmlParse(list_of_cap_source, encoding = "UTF-8")

#xpathSApply(list_of_cap_parsed, "//thead/tr/th", fun= xmlAttrs)

xpathSApply(list_of_cap_parsed, "//table", fun= xmlAttrs)

#xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable jquery-tablesorter']")
table_with_caps <- xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable']")
#table_with_capbod <- xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable']/descendant::tbody")
#table_with_capbod <- xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable']/tbody")
table_with_country <- xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable']")

table_with_capbod <- xpathSApply(list_of_cap_parsed, "//table[@class='wikitable sortable']/descendant::tr/td[position()=3]/b")



#getHTMLLinks(list_of_cap_parsed, xpQuery = "//table[@class='wikitable sortable jquery-tablesorter']/descendant::tbody/tr/td/b/@href")
#╠getHTMLLinks(list_of_cap_parsed, xpQuery = "//table[@class='wikitable sortable']/descendant::tbody/tr/td/b/@href")
cap_links <- getHTMLLinks(list_of_cap_parsed, xpQuery = "//table[@class='wikitable sortable']/descendant::tr/td[position()=3]/b/a/@href")


library(httr)

#ny_times_best_sellers <- oauth_endpoint(authorize = )


ny_key <- "e3b0514f5133f21156df3809c962009d:15:69577313"
ny_date <- "2010-10-01"
ny_list <- "hardcover-fiction"
#response <- ".json"
response <- ".xml"
#ny_best_url <- paste("http://api.nytimes.com/svc/books/v3/lists/", ny_date, "/", response, "&", ny_list , sep ="")
ny_best_url <- paste("http://api.nytimes.com/svc/books/v3/lists/", ny_date, "/",  ny_list ,  response, "&api-key=", ny_key ,  sep ="")
res <- getURL(ny_best_url)

http://api.nytimes.com/svc/books/v2/lists/2010-10-01/trade-fiction-paperback.xml

http://api.nytimes.com/svc/books/{version}/lists/[date/]{list-name}[.response_format]?[optional-param1=value1]&[...]&api-key={your-API-key}




             
             
             