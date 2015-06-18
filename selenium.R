library(Rwebdriver)
library(XML)
start_session(root="http://localhost:4444/wd/hub/")

post.url(url = "http://www.r-datacollection.com/materials/selenium/intro.html")

# > get.url()
# [1] "http://www.r-datacollection.com/materials/selenium/dbQuery.html"

#buttonID <- element_xpath_find(value= "/html/body/div/div[2]/form/input")
buttonID <- element_xpath_find(value= "/html/body/div/form/div/button")

element_click(ID = buttonID)
allHandles <- window_handles()
window_change(allHandles[1])

yearID <- element_xpath_find(value= '//*[@id ="yearSelect"]')
monthID <- element_xpath_find(value= '//*[@id ="monthSelect"]')
recipID <- element_xpath_find(value= '//*[@id ="recipientSelect"]')


element_click(yearID)
keys("2013")
element_click(monthID)
keys("January")
element_click(recipID)
keys("Barack Obama")

submitID <- element_xpath_find(value= '//*[@id ="yearForm"]/div/button')
element_click(submitID)

pagesource = page_source()
moneyTab <- readHTMLTable(pagesource, which = 1)