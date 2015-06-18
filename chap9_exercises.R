
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
             
             
             