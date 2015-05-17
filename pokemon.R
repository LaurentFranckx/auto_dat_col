setwd("D:/rwebscraping/solutions/ch-7-sql-problems/pokemon")

library(RSQLite)

pokemon <- read.csv2("pokemon.csv")
pokemon_species <- read.csv2("pokemon_species.csv")
pokemon_stats <- read.csv2("pokemon_stats.csv")
pokemon_types <- read.csv2("pokemon_types.csv")
stats <- read.csv2("stats.csv")
type_efficacy <- read.csv2("type_efficacy.csv")
types <- read.csv2("types.csv")

#con <- dbConnect(SQLite(), dbname = tempfile())
#con <- dbConnect(SQLite(), dbname = "")
con <- dbConnect(SQLite(), dbname = "pokemondb.sqlite")
dbListTables(con)

dbWriteTable(con,"pokemon", pokemon)
dbWriteTable(con,"pokemon_species", pokemon_species)
dbWriteTable(con,"pokemon_stats", pokemon_stats)
dbWriteTable(con,"pokemon_types", pokemon_types)
dbWriteTable(con,"stats", stats)
dbWriteTable(con,"type_efficacy", type_efficacy)
dbWriteTable(con,"types", types)


sq1 <- "SELECT * FROM pokemon WHERE weight > 4000"
res1 <- dbGetQuery(con,sq1)

sq2 <- "SELECT * FROM pokemon INNER JOIN pokemon_species ON pokemon.id=pokemon_species.id"
res2 <- dbGetQuery(con,sq2)

sq3 <- "SELECT * FROM pokemon INNER JOIN pokemon_species ON pokemon.id=pokemon_species.id WHERE weight > 4000"
res3 <- dbGetQuery(con,sq3)


sq4 <- "SELECT identifier FROM  pokemon_species WHERE identifier LIKE '%Nido%' "
res4 <- dbGetQuery(con,sq4)

res <- dbSendQuery(con, "SELECT identifier FROM pokemon_species")
fetch(res, n = 5)
dbClearResult(res)

pokeview <- dbSendQuery(con,"CREATE VIEW [pokeview] AS
SELECT     species_id , height, weight,    identifier, evolves_from_species_id, evolution_chain_id
FROM pokemon
INNER JOIN pokemon_species ON pokemon.id=pokemon_species.id   ")
sq5 <- "SELECT * FROM [pokeview] WHERE identifier = 'dragon'" 
res5 <- dbGetQuery(con,sq5)


typeview <- dbSendQuery(con,"CREATE VIEW typeview AS
SELECT pokemon_id, slot,  identifier,    damage_class_id
FROM pokemon_types
INNER JOIN types ON pokemon_types.type_id=types.id   ")

statsview <- dbSendQuery(con,"CREATE VIEW statsview AS
SELECT  base_stat, damage_class_id, pokemon_id, damage_class_id
FROM pokemon_stats
INNER JOIN stats ON pokemon_stats.stat_id = stats.id   ")



sq6 <- "SELECT * FROM [typeview] INNER JOIN pokeview ON [typeview].pokemon_id = [pokeview].species_id WHERE [typeview].identifier = 'dragon' " 
res6 <- dbGetQuery(con,sq6)

max_attack <- "SELECT MAX(base_stat) AS 'Highest attack value' FROM pokemon_stats WHERE stat_id = 2 "
res6 <- dbGetQuery(con,max_attack)
#max_att_num <- as.numeric(res6)


sq7 <- "SELECT * FROM [statsview] INNER JOIN pokeview ON [statsview].pokemon_id = [pokeview].species_id WHERE base_stat = res6 " 
res7 <- dbGetQuery(con,sq7)

# sq7 <- "SELECT * FROM [statsview] INNER JOIN pokeview ON [statsview].pokemon_id = [pokeview].species_id WHERE [statsview].base_stat = MAX( [statsview].base_stat) " 
# res7 <- dbGetQuery(con,sq7)

sq7 <- "SELECT * FROM [statsview], 
(SELECT MAX(base_stat) AS 'Highest_attack' FROM pokemon_stats WHERE stat_id = 2 ) maxresult
INNER JOIN pokeview ON [statsview].pokemon_id = [pokeview].species_id WHERE base_stat = maxresult.Highest_attack " 
res7 <- dbGetQuery(con,sq7)



sq8 <- "SELECT * FROM [statsview], 
(SELECT MAX(base_stat) AS 'Highest_defense' FROM pokemon_stats WHERE stat_id = 3 ) maxresult
INNER JOIN pokeview ON [statsview].pokemon_id = [pokeview].species_id WHERE base_stat = maxresult.Highest_defense " 
res8 <- dbGetQuery(con,sq8)








dbDisconnect(con)
