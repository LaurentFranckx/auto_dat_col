
# load packages
library(RCurl)
library(XML)
library(stringr)
library(plyr)

cog_bias_url <- "https://en.wikipedia.org/wiki/List_of_cognitive_biases"
cog_bias_source <- readLines(cog_bias_url, encoding = "UTF-8")
cog_bias_parsed <- htmlParse(cog_bias_source, encoding = "UTF-8")

xpathSApply(cog_bias_parsed, "//h2/span", fun= xmlAttrs)

getHTMLLinks(cog_bias_parsed, xpQuery = "//h2/span[@id='Social_biases']/ancestor::h2/following-sibling::table/*/td/b/a/@href")

getHTMLLinks(cog_bias_parsed, xpQuery = "//h2/span[@id='Social_biases']/ancestor::h2/following-sibling::table[position()=1]/*/td/b/a/@href")

