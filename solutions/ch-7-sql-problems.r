### --------------------------------------------------------------
### AUTOMATED DATA COLLECTION WITH R
### SIMON MUNZERT, CHRISTIAN RUBBA, PETER MEISSNER, DOMINIC NYHUIS
###
### CODE CHAPTER 7: SQL
### PROBLEM SOLUTIONS
### --------------------------------------------------------------


### Pokemon problems

setwd("pokemon")

# 1.  Load the RSQLite package and create a new RSQLite database called pokemon.sqlite.
require(RSQLite)
if(file.exists("pokemon.sqlite")) file.remove("pokemon.sqlite")
pokecon <- dbConnect( dbDriver("SQLite"), "pokemon.sqlite")

# 2.  Use read.csv2() to  read  pokemon.csv,  pokemon_species.csv,  pokemon_stats.csv,
# pokemon_types.csv, stats.csv, type_efficacy.csv, and types.csv into R and write the
# tables to pokemon.sqlite. Have a look at PokemonReadme.txt to learn about the tables
# you imported.

dbWriteTable(pokecon, "pokemon"          ,   read.csv2("pokemon.csv"           ) )
dbWriteTable(pokecon, "pokemon_species"  ,   read.csv2("pokemon_species.csv"   ) )
dbWriteTable(pokecon, "pokemon_stats"    ,   read.csv2("pokemon_stats.csv"     ) )
dbWriteTable(pokecon, "pokemon_types"    ,   read.csv2("pokemon_types.csv"     ) )
dbWriteTable(pokecon, "stats"            ,   read.csv2("stats.csv"             ) )
dbWriteTable(pokecon, "pokemon_efficacy" ,   read.csv2("type_efficacy.csv"      ) )
dbWriteTable(pokecon, "types"            ,   read.csv2("types.csv"             ) )

browseURL("PokemonReadme.txt")


# 3.  Use functions from DBI/RSQLite to read the tables that you stored in the database
# back into R and save them in objects named: pokemon , pokemon_species , pokemon_-
# stats , pokemon_types , stats , type_efficacy , and types .

pokemon         <- dbReadTable(pokecon, "pokemon"         )
pokemon_species <- dbReadTable(pokecon, "pokemon_species" )
pokemon_stats   <- dbReadTable(pokecon, "pokemon_stats"   )
pokemon_types   <- dbReadTable(pokecon, "pokemon_types"   )
stats           <- dbReadTable(pokecon, "stats"           )
pokemon_efficacy<- dbReadTable(pokecon, "pokemon_efficacy")
types           <- dbReadTable(pokecon, "types"           )


# 4.  Build a query that SELECTs those pokemon from table pokemon that are heavier than 4000. 
# Next, build a SELECT query that JOINs tables pokemon and pokemon_species.

sql <- "SELECT * FROM pokemon WHERE weight > 4000 ;"
dbGetQuery(pokecon, sql)

sql <- "SELECT * FROM pokemon 
        JOIN pokemon_species ON pokemon.species_id=pokemon_species.id ;"
head(dbGetQuery(pokecon, sql),20)


# 5.  Combining the previous SQL queries, build a query that JOIN s both tables and restricts
# the results to Pokemon that are heavier than 4000.

sql <- "SELECT * FROM pokemon 
        JOIN pokemon_species ON pokemon.species_id=pokemon_species.id 
        WHERE weight > 4000 ;"
dbGetQuery(pokecon, sql)


# 6.  Build a query that SELECTs all Pokemon names from table pokemon_species which
# have Nido as part of their name.

sql <- "SELECT * FROM pokemon_species
        WHERE identifier LIKE 'Nido%' ;"
dbGetQuery(pokecon, sql)


# 7.  Fetching names.
# (a)  Build a query that SELECTs Pokemon names.
# (b)  Send the query to the database using dbSendQuery() and save the result in an
# object.
# (c)  Use fetch() three times in a row, each time retrieving another set of ﬁve names.
# (d)  Use dbClearResult() to clean up afterwards.

sql <- "SELECT identifier FROM pokemon_species;"
request <- dbSendQuery(pokecon, sql)
fetch(request, 5)
fetch(request, 5)
fetch(request, 5)
dbClearResult(request)


# 8.  Creating views.
# (a)  Create a VIEW called pokeview . . .
# (b)  . . . that JOIN s table pokemon with table pokemon_species,
# (c)  . . . and contains the following information: height and weight, species identiﬁer,
#            Pokemon id from which the Pokemon evolves, the id of the evolution chain and
#            ids for Pokemon and species.

sql <- "CREATE VIEW pokeview  AS 
            SELECT  pokemon.id, evolves_from_species_id, evolution_chain_id, species_id, 
                    height, weight, pokemon_species.identifier
            FROM pokemon 
            JOIN pokemon_species ON pokemon.species_id = pokemon_species.id ;"
dbGetQuery(pokecon, sql)
head(dbReadTable(pokecon, "pokeview"))


# (d)  Create a VIEW called typeview . . .
# (e)  . . . that JOIN s pokemon_types and types . . .
# (f)  . . . and contains the following information: slot of the type, identiﬁer of the type
# and ids for Pokemon, damage class and type.

sql <- "CREATE VIEW typeview AS 
            SELECT slot, identifier, pokemon_id, damage_class_id, type_id
            FROM pokemon_types
            JOIN types ON pokemon_types.type_id = types.id ; "
dbGetQuery(pokecon, sql)
head(dbReadTable(pokecon, "typeview"))


# (g)  Create a VIEW called statsview . . .
# (h)  . . . that JOIN s pokemon_stats and stats . . .
# (i)  . . . and contains the following information: identiﬁer of the statistic, base value
# of the statistics and ids for Pokemon, statistics and damage class.

sql <- "CREATE VIEW statsview AS 
            SELECT  stats.identifier, base_stat, pokemon_id, stat_id, damage_class_id,
                    pokemon_species.identifier AS name
            FROM pokemon_stats
            JOIN stats ON pokemon_stats.stat_id = stats.id 
            JOIN pokemon_species ON pokemon_stats.pokemon_id = pokemon_species.id; "
dbGetQuery(pokecon, sql)
head(dbReadTable(pokecon, "statsview"))


# 9.  Using the views you created, which Pokemon are of type dragon? Which Pokemon has
# most health points, which has the best attack, defense and speed?

dbGetQuery(pokecon, "SELECT * FROM typeview WHERE identifier = 'dragon'")
dbGetQuery(pokecon, "SELECT typeview.*, pokemon_species.identifier FROM typeview 
                    JOIN pokemon_species ON pokemon_id=pokemon_species.id
                    WHERE typeview.identifier = 'dragon'")

dbGetQuery(pokecon, "SELECT id, identifier, weight 
                    FROM pokeview 
                    WHERE weight = (SELECT MAX(weight) FROM pokeview)")
                    
dbGetQuery(pokecon, "SELECT pokemon_id, base_stat, identifier, name FROM statsview 
                    WHERE   identifier = 'attack' AND 
                            base_stat = (   SELECT MAX(base_stat) FROM statsview 
                                            WHERE identifier = 'attack'             )")

dbGetQuery(pokecon, "SELECT pokemon_id, base_stat, identifier, name FROM statsview 
                    WHERE   identifier = 'defense' AND 
                            base_stat = (   SELECT MAX(base_stat) FROM statsview 
                                            WHERE identifier = 'defense'             )")
                                            
dbGetQuery(pokecon, "SELECT pokemon_id, base_stat, identifier, name FROM statsview 
                    WHERE   identifier = 'speed' AND 
                            base_stat = (   SELECT MAX(base_stat) FROM statsview 
                                            WHERE identifier = 'speed'             )")
                                            
dbGetQuery(pokecon, "SELECT pokemon_id, base_stat, identifier, name FROM statsview 
                    WHERE   identifier = 'hp' AND 
                            base_stat = (   SELECT MAX(base_stat) FROM statsview 
                                            WHERE identifier = 'hp'             )")


                                            
### ParlGov problems

# 10.  Use download.file() with mode="wb" to save the following resource http://parlgov.
# org/stable/static/data/parlgov-stable.db as parlgov.sqlite and establish a connection.

download.file("http://parlgov.org/stable/static/data/parlgov-stable.db","parlgov.sqlite",mode="wb")
require(RSQLite)
parlcon <- dbConnect( dbDriver("SQLite"), "parlgov.sqlite")


# 11.  Get a list of all tables in the database. According to info_data_source, which external
# data sources were used for the database?

dbListTables(parlcon)
unique(iconv(dbReadTable(parlcon, "info_data_source")$short,"utf8","latin1"))


# 12.  Figure out for which countries the database offers data.

dbReadTable(parlcon, "country")$name


# 13.  Which time span is covered by the election table?

electionDates <- dbReadTable(parlcon, "election")$date
min(electionDates)
max(electionDates)


# 14.  How many early elections were there in Spain, UK and Switzerland?

sql <- "SELECT country_id, date, name, early 
        FROM election
        JOIN country ON (country_id = country.id)
        WHERE name in ('Spain', 'Switzerland', 'United Kingdom') 
          AND early = 1"
dbGetQuery(parlcon, sql)


# 15.  Creating views.
# (a) CREATE a VIEW named edata . . .
# (b)  . . . that JOIN s table election_result . . .
# (c)  . . . with tables election, country and party . . .
# (d)  . . . so that the view contains the following information: country name, date of the
# election, the abbreviated party name, party name in English, seats to be won in
# total, seats won by party, vote share won by the party as well as ids for country,
# election, election results and party.

sql <- "CREATE VIEW edata AS
            SELECT 
                election.date AS el_date,
                election.id AS el_id
            FROM election 
        ;"
dbGetQuery(parlcon, sql)


dbGetQuery(parlcon,"DROP VIEW edata")
sql <- "CREATE VIEW edata AS
            SELECT 
                election.date AS el_date,
                election.id AS el_id, 
                election_result.id AS elres_id,
                party_id,
                seats,
                seats_total,
                vote_share
            FROM election 
            JOIN election_result ON (el_id = election_id)
        ;"
dbGetQuery(parlcon, sql)


dbGetQuery(parlcon,"DROP VIEW edata")
sql <- "CREATE VIEW edata AS
            SELECT 
                country.name AS country,
                election.date AS el_date,
                election.id AS el_id, 
                election_result.id AS elres_id,
                party_id,
                party.name_short AS pnam,
                party.name_english AS pname,
                seats,
                seats_total,
                vote_share
            FROM election 
            JOIN country ON (country.id = election.country_id)
            JOIN election_result ON (el_id = election_id)
        ;"
dbGetQuery(parlcon, sql)


dbGetQuery(parlcon,"DROP VIEW edata")
sql <- "CREATE VIEW edata AS
            SELECT 
                country.name AS country,
                election.date AS el_date,
                election.id AS el_id, 
                election_result.id AS elres_id,
                party_id,
                party.name_short AS pnam,
                party.name_english AS pname,
                seats,
                seats_total,
                vote_share
            FROM election 
            JOIN country ON (country.id = election.country_id)
            JOIN election_result ON (el_id = election_id)
            JOIN party ON (election_result.party_id = party.id)
        ;"
dbGetQuery(parlcon, sql)




# (e)  Make sure the VIEW is restricted to elections of type 13 (elections to parliament).

dbGetQuery(parlcon,"DROP VIEW edata")
sql <- "CREATE VIEW edata AS
            SELECT 
                country.name AS country,
                election.date AS el_date,
                election.id AS el_id, 
                election_result.id AS elres_id,
                party_id,
                party.name_short AS pnam,
                party.name_english AS pname,
                seats,
                seats_total,
                vote_share
            FROM election 
            JOIN country ON (country.id = election.country_id)
            JOIN election_result ON (el_id = election_id)
            JOIN party ON (election_result.party_id = party.id)
            WHERE election.type_id=13
        ;"
dbGetQuery(parlcon, sql)


# (f)  Read the data of the view into R and save it in an object.
eres <- dbReadTable(parlcon, "edata")

# (g)  Add a variable storing the seat share.
eres$seat_share <- 100 * eres$seats / eres$seats_total

# (h)  Plot vote shares versus seat shares. Use text() to add the name of the country if
# vote share and seat share differ by more than 20 percentage points.
plot(eres$vote_share, eres$seat_share , col=rgb(1,0,0,0.3))
iffer <- abs(eres$vote_share - eres$seat_share) > 20
text(eres$vote_share[iffer],  
     eres$seat_share[iffer],
     eres$country[iffer], 
     srt = -45, cex=0.75, col=rgb(0,0,1,0.7))




# 16.  Find answers to the following questions in the database.
# (a)  Which country had a cabinet lead by Lojze Peterle?

sql <- "SELECT country.name
        FROM cabinet
        JOIN country ON (cabinet.country_id = country.id)
        WHERE cabinet.name = 'Peterle'; "
dbGetQuery(parlcon, sql)


# (b)  Which parties were part of that government?

sql <- "SELECT country.name, cabinet.country_id, start_date,
        cabinet_id, party_id,
        family_id, party.name_short
        FROM cabinet
        JOIN country ON (cabinet.country_id = country.id)
        JOIN cabinet_party ON (cabinet.id = cabinet_id)
        JOIN party ON (party_id = party.id)
        WHERE cabinet.name = 'Peterle'; "
dbGetQuery(parlcon, sql)


# (c)  What were their vote shares in the election?

sql <- "SELECT country.name, cabinet.country_id, start_date,
        cabinet_id, cabinet_party.party_id,
        family_id, party.name_short, party.name_english,
        seats, vote_share, date, start_date
        FROM cabinet
        JOIN country ON (cabinet.country_id = country.id)
        JOIN cabinet_party ON (cabinet.id = cabinet_id)
        JOIN party ON (cabinet_party.party_id = party.id)
        JOIN election_result ON (election_result.party_id = cabinet_party.party_id)
        JOIN election ON (election.id = election_result.election_id)
        WHERE cabinet.name = 'Peterle' and date < start_date; "
dbGetQuery(parlcon, sql)


# 17.  More SELECT queries.
# (a)  Build a query that SELECT s column tbl_name and type from table sqlite_master.

sql <- "SELECT tbl_name, type FROM sqlite_master"
dbGetQuery(parlcon, sql)


# (b)  Build a query that SELECT s column sql from table sqlite_master WHERE column
# tbl_name equals edata. Save the result in an object and use cat() to display the
# contents of the object.

sql <- "SELECT sql FROM sqlite_master WHERE tbl_name = 'edata'"
cat(unlist(dbGetQuery(parlcon, sql)))


# (c)  Do the same for tbl_name equal to view_election.

sql <- "SELECT sql FROM sqlite_master WHERE tbl_name = 'view_election'"
cat(unlist(dbGetQuery(parlcon, sql)))







































