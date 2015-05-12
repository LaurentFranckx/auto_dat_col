### --------------------------------------------------------------
### AUTOMATED DATA COLLECTION WITH R
### SIMON MUNZERT, CHRISTIAN RUBBA, PETER MEISSNER, DOMINIC NYHUIS
###
### CODE CHAPTER 2: AJAX
### PROBLEM SOLUTIONS
### --------------------------------------------------------------


#1. Why are AJAX-enriched webpages often valuable for web users, but an obstacle to web scrapers? 
Many web pages that provide data-based services employ AJAX - or more specifically XHR - to serve the information to the site's visitor in a convinient fashion without requiering a reload of a page. To web scrapers this poses an obstacle since the information are concealed from the front-page HTML document.


##2. What are the three methods to embed JavaScript in HTML?
In-line code, external reference, and as a method attached to HTML elements
##3. Why are Web Developer Tools particularly useful for web scraping when the goal is to gather information from websites using dynamic HTML?
Web Developer Tools are helpful to reenact the requests a web site makes to additional resources, such as style sheets, JavaScript scripts or data files. The information provided by these tools can be used to discover the source of a target data file.
##4. Return to fortunes3.html. Implement the JavaScript alert() function at two points of the document. First, put the function in the <node> section of the document with text ‘fortunes3.html successfully loaded!’. Second, open script3.js and include the alert() function here as well with text ‘quotes.html successfully loaded!’. Watch the page’s behavior in the browser.
See fortunes3_problem.html

#5. Use the appropriate parsing function for fortunes3.html and verify that it does not contain the quotes of interest.
fortunes3 <- htmlParse("fortunes/fortunes3.html")
fortunes3

#6. Write a script for fortunes2.html that extracts the source of the quote.
##(a) Parse fortunes2.html into an R object called fortunes2.
fortunes3 <- htmlParse("fortunes/fortunes3.html")

##(b) Write an XPath statement to extract the names of the JavaScript files and createa regular expression for extracting the name of the JavaScript script (and not thelibrary).

require(stringr)

scripts <- xpathSApply(fortunes2, "//script", xmlGetAttr, "src")
js_scripts <- scripts[which(!str_detect(scripts, "jquery"))]

##(c) Import the JavaScript code using readLines() and extract the file path of therequested HTML document quotes.html.
script_loc <- paste0("fortunes/", script2)
script_code <- readLines(script_loc)
str_extract(script_code, "load")

##(d) Parse quotes.html into an R object called quotes and query the document for thenames.
quotes <- htmlParse("fortunes/quotes/quotes.html")
names <- xpathSApply(quotes, "//h1", xmlValue)


#8. Repeat exercise two for fortunes3.html. Extract the sources of the quotes.
fortunes3 <- htmlParse("fortunes/fortunes3.html")
scripts <- xpathSApply(fortunes3, "//script", xmlGetAttr, "src")
script3 <- scripts[which(!str_detect(scripts, "jquery"))]
script_loc <- paste0("fortunes/", script3)

require(RJSONIO)
fromJSON(script_loc)

#9. The website http://www.parl.gc.ca/About/Parliament/FederalRidingsHistory/hfer.asp?Language=E&Search=C provides information on candidates in Canadian federal elections via a request to a database.
##(a) Request information for all candidates with the name "Smith". Inspect the live DOM tree with Web Developer Tools and find out the HTML tags of the returned information.
##(b) Which HTTP method is used to request the information from the server? 
The candidate information are requested by a HTTP GET request. This information can be read from the header of the first request in the WDT Network tab. 
##(c) Can you manipulate the request manually to obtain information for all candidates named "Brown"?
From the Network Tab we must first identify the relevant request to our target information. Through a combination of common sense (search information are oftentimes contained in the URL) and knowledge on PHP queries (search information are encoded in a &variable=value format), we can infer this to be the appropriate URL "http://www.parl.gc.ca/About/Parliament/FederalRidingsHistory/hfer.asp?Language=E&Search=Cres&canName=Smith&canParty=0&ridProvince=0&ridName=&submit1=Search". Apparently, relevant information is passed to the web server through an encodement in the url and so easy to adopt to our task. For a custom search, we merely replace the relevant string (here, the part after &canName=) with surname "Brown" to yield the following url "http://www.parl.gc.ca/About/Parliament/FederalRidingsHistory/hfer.asp?Language=E&Search=Cres&canName=Brown&canParty=0&ridProvince=0&ridName=&submit1=Search". In R, we can download this resource through a GET request:

require(RCurl)
brownes <- getURL("http://www.parl.gc.ca/About/Parliament/FederalRidingsHistory/hfer.asp?Language=E&Search=Cres&canName=Brown&canParty=0&ridProvince=0&ridName=&submit1=Search")

#10. The city of Seattle maintains an open data platform, providing ample information on city services. Take a look at the violations database at https://data.seattle.gov/Community/Seattle-code-violations-database/8agr-hifc.##(a) Use the Web Developer Tools to learn about how the database information is stored in HTML code.##(b) Asses the data requesting mechanism. Can you access the underlying database directly?
