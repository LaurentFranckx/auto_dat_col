### --------------------------------------------------------------
### AUTOMATED DATA COLLECTION WITH R
### SIMON MUNZERT, CHRISTIAN RUBBA, PETER MEISSNER, DOMINIC NYHUIS
###
### CODE CHAPTER 4: XPATH
### PROBLEM SOLUTIONS
### --------------------------------------------------------------


#1. What makes XPath a domain-specific language?
Syntactically and structurally, XPath is domain-specific, meaning that the language has been designed for working on the domain of tree-structured XML documents. 
#2. XPath is the XML Path language, but it also works for HTML documents. Explain why.
XPath works on both because HTML can be described as a subset or variant of the more general XML.
#3. Return to the fortunes1.html file and consider the following XPath expression: //a[text()[contains(., ’R-help’)]].... Replace ... to get the <h1> node with value “Robert Gentleman”.
fortunes1 <- htmlParse("fortunes/fortunes1.html")
gentleman <- xpathSApply(fortunes1, "//a[text()[contains(., 'R-help')]]/ancestor::body/div[1]/h1", xmlValue)
#4. Construct a predicate with the appropriate string functions to test whether the month of a quote is October.
xpathSApply(fortunes1, "//div[substring-before(./@date, '/')='October']")
#5. Consider the following two XPath statements for extracting paragraph nodes from a HTML file. 1. //div//p, 2. //p. Decide which of the two statements makes a more narrow request. Explain why.
The first expression (//div//p) defines a more narrow set of elements since it requires a p node to have a div ancestor, while the second expression makes no such restriction
#6. Verify that for extracting the quotes from fortunes.html the XPath expression //i does not return the correct results. Explain why not.
xpathSApply(fortunes1, "//i")

The expression does not exclusively identify the quote information since the address information uses italic tags as well to mark-up the hyperlink text. 
#7. The XML file potus.xml contains biographical informationon USpresidents. Parse the file into an object of the R session.
potus <- xmlParse("potus/potus.xml")
##(a) Extract the names of all the presidents.
xpathSApply(potus, "//document/president/name", xmlValue)
##(b) Extract the names of all presidents, beginning with the 40th term.
xpathSApply(potus, "//document/president[./number>39]/name", xmlValue)
##(c) Extract the value of the <occupation> node for all Republican presidents.
xpathSApply(potus, "//document/president[./party='Republican']/occupation", xmlValue)
##(d) Extract the <occupation> node for all Republican presidents that are also Baptists.
xpathSApply(potus, "//document/president[./party='Republican' and ./religion='Baptist']/occupation", xmlValue)
##(e) The <occupation> node contains a string with additional whitespace at the beginning and the end of the string. Remove the whitespace by extending the extractor function.
removeWhitespace <- function(x){
	require(stringr)
	x <- xmlValue(x)
	x <- str_trim(x)
	return(x)
}

xpathSApply(potus, "//document/president/occupation", removeWhitespace)
##(f) Extract information from the <education> nodes. Replace all instances of ‘No formal education’ with NA.
eduFun <- function(x){
	x <- xmlValue(x)
	x <- ifelse(x=="No formal education", NA, x)
	return(x)
}

xpathSApply(potus, "//document/president/education", eduFun)
##(g) Extract the <name> node for all presidents whose term started in or after the year 1960.
eduFun <- function(x){
	x <- xmlValue(x)
	x <- ifelse(x=="No formal education", NA, x)
	return(x)
}

xpathSApply(potus, "//document/president/education", eduFun)