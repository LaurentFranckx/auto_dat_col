
setwd("D:/rwebscraping")
library(RSQLite)
sqlite <- dbDriver("SQLite")
con <- dbConnect(sqlite, dbname = "D:/rwebscraping/pokemon-sqlite-master/pokemon-sqlite-master/pokedex.sqlite")

dbGetInfo(con)

#download.file("http://parlgov.org/stable/static/data/parlgov-stable.db", "parlgov.sqlite", mode = "wb")


download.file("http://www.parlgov.org/#data/parlgov-development.db", "parlgov.sqlite", mode = "wb")
conparlgov <- dbConnect(sqlite, dbname = "parlgov.sqlite")


conparlgov <- dbConnect(sqlite, dbname = "parlgov-development.db")
dbGetInfo(conparlgov)



library(RSQLite)
download.file(
  url = "http://www.parlgov.org/static/stable/2014/parlgov-stable.db",
  destfile = "parlgov.sqlite",
  mode = "wb"
)
con <- dbConnect(SQLite(), "parlgov.sqlite")
dbListTables(con)
#RSQLite::dbGetInfo(con)
