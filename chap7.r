
setwd("D:/rwebscraping")
library(RSQLite)
sqlite <- dbDriver("SQLite")
#con <- dbConnect(sqlite, dbname = "D:/rwebscraping/pokemon-sqlite-master/pokemon-sqlite-master/pokedex.sqlite")
#dbGetInfo(con)

#download.file("http://parlgov.org/stable/static/data/parlgov-stable.db", "parlgov.sqlite", mode = "wb")
#download.file("http://www.parlgov.org/#data/parlgov-development.db", "parlgov.sqlite", mode = "wb")
#conparlgov <- dbConnect(sqlite, dbname = "parlgov.sqlite")
#conparlgov <- dbConnect(sqlite, dbname = "parlgov-development.db")
#dbGetInfo(conparlgov)

library(RSQLite)
download.file(
  url = "http://www.parlgov.org/static/stable/2014/parlgov-stable.db",
  destfile = "parlgov.sqlite",
  mode = "wb"
)
con <- dbConnect(SQLite(), "parlgov.sqlite")
dbListTables(con)
#RSQLite::dbGetInfo(con)

sq1 <- "SELECT * FROM info_data_source"
datasource <- dbGetQuery(con, sq1)

sq2 <- "SELECT * FROM country"
countries <- dbGetQuery(con, sq2)

sq3 <- "SELECT * FROM viewcalc_country_year_share"
viewcalc_country_year_share <- dbGetQuery(con, sq3)

rec_year <- "SELECT MAX(year) AS 'Most recent year' FROM viewcalc_country_year_share"
res6 <- dbGetQuery(con,rec_year)

old_year <- "SELECT MIN(year) AS 'Oldest year' FROM viewcalc_country_year_share"
res7 <- dbGetQuery(con,old_year)

sq4 <- "SELECT * FROM election"
elections <- dbGetQuery(con, sq4)

sq5 <- "SELECT name FROM country INNER JOIN election ON election.country_id = country.id WHERE early = 1 AND (name in ('Spain','Switzerland', 'United Kingdom'))"
early_elections  <- dbGetQuery(con, sq5)

sq6 <- "SELECT * FROM election_result"
election_result <- dbGetQuery(con, sq6)

sq7 <- "SELECT * FROM party"
party <- dbGetQuery(con, sq7)


edata <- dbSendQuery(con,"CREATE VIEW edata AS
SELECT  country.name, date, party.name_short, name_english, seats_total , seats, vote_share
FROM election_result
INNER JOIN election ON election_result.election_id = election.id  
INNER JOIN country ON country.id = election.country_id  
INNER JOIN party on party.id =  election_result.party_id  
WHERE type_id = 13
                     ")


sq8 <- "SELECT * FROM edata"
election_info <- dbGetQuery(con, sq8)
election_info$seat_share <- with(election_info, seats/seats_total)
plot(election_info$seat_share, election_info$vote_share)

sq9 <- "SELECT * FROM cabinet"
cabinet <- dbGetQuery(con, sq9)

sq91 <- "SELECT * FROM cabinet_party"
cabinet_party <- dbGetQuery(con, sq91)




sq10 <- "SELECT country.name, cabinet.name, party.name_short, name_english, election.id, vote_share
          FROM cabinet
          INNER JOIN country ON cabinet.country_id = country.id
          INNER JOIN cabinet_party ON cabinet_party.cabinet_id = cabinet.id 
          INNER JOIN party ON party.id =  cabinet_party.party_id  
          INNER JOIN election ON cabinet.previous_parliament_election_id = election.id
  INNER JOIN election_result ON (election_result.election_id = election.id AND party.id =  election_result.party_id)

          WHERE cabinet.name LIKE '%Peterle%' "
peterle <- dbGetQuery(con, sq10)

