### --------------------------------------------------------------
### AUTOMATED DATA COLLECTION WITH R
### SIMON MUNZERT, CHRISTIAN RUBBA, PETER MEISSNER, DOMINIC NYHUIS
###
### CODE CHAPTER 2: HTML
### PROBLEM SOLUTIONS
### --------------------------------------------------------------


# 1.  Why is it important that HTML is a web standard?

###D.U.N.O###

# 2.  Write down the HTML tags for (a) the primary heading, (b) starting a new paragraph,
# (c) inserting foreign code, (d) constructing ordered lists, (e) creating a hyperlink, and
# (f) creating an e-mail link!

message(" (a) <h1>                                           ")
message(" <p>                                                ")
message(" <script>                                           ")
message(" <ol>                                               ")
message(" <a href='linktofile.html'> text <a/>               ")
message(" <a href='mailto:Edie@r-datacollection.com'>mail</a>")


# 3.  HTML source code inspection.
# (a)  Open three webpages you frequently use in your browser.
# (b)  Have a look at the source code of all three.
# (c)  Inspect various elements with the Inspect Elements tool of your browser.
# (d)  Save each of them to your hard drive.


# 4.  Building a basic HTML document, part I.
# (a)  Write a minimal HTML ﬁle.
# (b)  Add your name as a comment.
# (c)  Add a level one and a level two headline.
# (d)  Add some further content, e.g., a sentence about the current weather.
# (e)  Add a paragraph with some further content, e.g., a sentence about tomorrow’s weather.

html1 <- '
<!DOCTYPE html>
 <head>
   <title>I</title>
 </head>
 <body>
   <!-- Eddie Adecear -->
   <h1>Level One Headline</h1>
   <h2>Level Two Headline</h2>
   Today (2014-08-07) it is raining cats and dogs.
   <p>I hope tomorow comes with some sun.</p>
 </body>
</html>
'
writeLines(html1, "minHTML1.html")
browseURL("minHTML1.html")


# 5.  Building a basic HTML document, part II.
# (a)  Write a minimal HTML document.
# (b)  Include a paragraph that contains 10 special characters – only 5 of them may be
# mentioned in Table 2.1.
# (c)  Use http://www.r-datacollection.com/materials/html/simple.css as your default
# style ﬁle.
# (d)  Check the validity of your document at http://validator.w3.org.

html2 <- '
<!DOCTYPE html>
 <head>
   <title>II</title>
   <link href="http://www.r-datacollection.com/materials/html/simple.css" rel="stylesheet"/>
 </head>
 <body>
   <p>1: <br> &amp;    &amp;amp;        <br>
   <p>2: <br> &#35;    &amp;#35;        <br>
   <p>3: <br> &#36;    &amp;#36;        <br>
   <p>4: <br> &#37;    &amp;#37;        <br>
   <p>5: <br> &#40;    &amp;#40;        <br>
   <p>6: <br> &#41;    &amp;#41;        <br>
   <p>7: <br> &gt;     &amp;gt;         <br>
   <p>8: <br> &lt;     &amp;lt;         <br>
   <p>9: <br> &szlig;  &amp;szlig;      <br>
   <p>10:<br> &beta;   &amp;beta;       <br>
</p>
 </body>
</html>
'
writeLines(html2, "minHTML2.html")
browseURL("minHTML2.html")


# 6.  Building a basic HTML document, part III.
# (a)  Write a minimal HTML document.
# (b)  Include a table with two columns and three rows.
# (c)  The ﬁrst column should contain ﬁrst, second, and third. The second column
# should contain links to your top three web pages.
# (d)  Have a look at the list of tags at http://www.w3schools.com/tags/default.asp . 
# Try to use some of the tags you are not yet familiar with in your HTML document.

html3 <- '
<!DOCTYPE html>
 <head>
   <title>III</title>
   <link href="http://www.r-datacollection.com/materials/html/simple.css" rel="stylesheet"/>
 </head>
 <body>
    <table>
        <tr><td>1</td><td><a href="http://r-datacollection.com"> ADCR </a></td></tr>
        <tr><td>2</td><td><a href="http://www.r-bloggers.com/">  R-Bloggers</a></td></tr>
        <tr><td>3</td><td><a href="http://flowingdata.com/">     FlowingData</a></td></tr>
    </table>
    <br>
    <adress>Edie@r-datacollection.com<adress>
    <a href="mailto:Edie@r-datacollection.com">mail</a>
    <details><summary>Some more details?</summary> ... here we go</details>
    <details><summary>Embedded Journalism ...</summary> 
        <embed 
        height="1000" width="800"
        src="http://en.wikipedia.org/wiki/Embedded_journalism">
    </details>
 </body>
</html>
'
writeLines(html3, "minHTML3.html")
browseURL("minHTML3.html")


# 7.  The base R function download.file() is a standard tool to gather data from the Web
# with R. Investigate the function’s syntax and try to use it to save the front pages of your
# three most favorite websites to your local disk.

download.file("http://www.r-datacollection.com", "frontpage.html")
download.file("http://www.r-datacollection.com/authors.html", "authors.html")
download.file("http://www.r-datacollection.com/blog/", "blog.html")


# 8.  The base R functions readLines() and writeLines() can be used to import and export
# character data to and from R Try to use them to import the webpages you have gathered
# in the previous exercise and save them in different objects. Next, combine the three
# objects into a list object. Finally, use writeLines() to store the pages again in external
# ﬁles.

frontpage <- readLines("frontpage.html")
authors   <- readLines("authors.html")
blog      <- readLines("blog.html")

pages <- list(frontpage, authors, blog)
for(i in seq_along(pages)){
    writeLines(pages[[i]], paste0("pages", i, ".html"))
}


# 9.  An encounter with JavaScript.
# (a)  Check out http://www.r-datacollection.com/materials/html/fortunes3.html in your browser.
# (b)  View the page’s source code.
# (c)  Download both JavaScript files linked    to    the    document    using    the
# download.file() function.

browseURL("http://www.r-datacollection.com/materials/html/fortunes3.html")

fname <- "http://www.r-datacollection.com/materials/ajax/jquery-1.8.0.min.js"
download.file(fname, basename(fname))

fname <- "http://www.r-datacollection.com/materials/ajax/script3.js"
download.file(fname, basename(fname))


# 10.  Building a basic HTML document, part IV.
# -  Write a minimal HTML-document.
# -  Include a form that has two inputs – name and age .
# -  Deﬁne the form in a way that it sends data to 
# http://www.r-datacollection.com/materials/http/GETexample.php via the GET method.
# -  Make sure it works – the server should respond with Hello YourName! You are
# YourAge years old..
# -  Try to send high age values. At what point does the response message change?

html4 <- '
<!DOCTYPE html>
 <head>
   <title>IV</title>
   <link href="http://www.r-datacollection.com/materials/html/simple.css" rel="stylesheet"/>
 </head>
 <body>
    <form action="http://www.r-datacollection.com/materials/http/GETexample.php" method="GET">
    Name: <input name="name">
    Age:  <input type="number" name="age">
    <input type="submit">
    </form>
 </body>
</html>
'
writeLines(html4,"minHTML4.html")
browseURL("minHTML4.html")












