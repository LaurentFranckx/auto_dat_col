library(RJSONIO)
library(stringr)


isValidJSON("http://api.citybik.es/networks.json")
networks <- fromJSON("http://api.citybik.es/networks.json")
networks_df <- lapply(networks, function(x) do.call("cbind",x))
networks_df <- do.call("rbind", networks_df)
networks_df <- as.data.frame(networks_df)
networks_df[networks_df$city == "Antwerpen"  , ]

isValidJSON("http://api.citybik.es/velo-antwerpen.json")
velo_ant <- fromJSON("http://api.citybik.es/velo-antwerpen.json")
velo_ant_df <- lapply(velo_ant, function(x) do.call("cbind",x))
velo_ant_df <- do.call("rbind", velo_ant_df)
velo_ant_df <- as.data.frame(velo_ant_df)

# velo_ant_df$lat <- sprintf("%.7f" , as.numeric(velo_ant_df$lat)/10^6)
# velo_ant_df$lng <- sprintf("%.7f" ,as.numeric(velo_ant_df$lng)/10^6)

velo_ant_df$lat <- as.numeric(as.character(velo_ant_df$lat))/10^6
velo_ant_df$lng <- as.numeric(as.character(velo_ant_df$lng))/10^6

coordinates_url <- "https://www.google.be/maps/@51.1847038,4.4304128,15z?hl=en"
coordinates_url <- str_split(coordinates_url, "@")
coordinates_url <- coordinates_url[[1]][2]

#######
#trying out leaflet
#########


#install.packages('leaflet')
library(leaflet)
library(magrittr)
#(m <- leaflet() %>% addTiles())
m <- leaflet() %>% setView(lat = 51.1847038, lng = 4.4304128, zoom = 12)
m %>% addTiles()
# 
# content <- paste(sep = "<br/>",
#                  "<b><a href='http://www.samurainoodle.com'>Samurai Noodle</a></b>",
#                  "606 5th Ave. S",
#                  "Seattle, WA 98138"
# )
# 
# id: CityBikes station id
# name: Station name
# lat: Latitude in E6 format
# lng: Longitude in E6 format
# bikes: Number of bikes in the station
# free: Number of free slots
# timestamp: The last time the station has been updated

# 
for(i in nrow(velo_ant_df)){
  station <- paste("Station:",  velo_ant_df[i, "name"])
  bikes <- paste("Aanwezige fietsen:",  velo_ant_df[i, "bikes"])
  free <- paste("Vrije plaatsen:",  velo_ant_df[i, "free"])
  time <- paste("Laatste update:",  velo_ant_df[i, "timestamp"])
  content <- paste(sep = "<br/>", station,bikes, free, 
                   velo_ant_df[i, "bikes"])
  leaflet() %>% addTiles() %>%
    addPopups(lat = velo_ant_df[i, "lat"], lng = velo_ant_df[i, "lng"], content,
              options = popupOptions(closeButton = FALSE)
    )
}



library(htmltools)
# 
df <- velo_ant_df

leaflet(data = velo_ant_df) %>% addTiles() %>% addMarkers(~lng, ~lat, popup = ~htmlEscape(name))
# 
# leaflet(df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = ~htmlEscape(name, bikes))  
# 
# leaflet(df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = ~htmlEscape(paste(name, bikes, free, timestamp)))

# station <- paste("Station:",  name)
# bikes <- paste("Aanwezige fietsen:",  bikes)
# free <- paste("Vrije plaatsen:", free)
# # time <- paste("Laatste update:",  timestamp)
# content <- paste(sep = "<br/>", name, bikes, free, timestamp)
# 
# leaflet(df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = ~htmlEscape(content))

# leaflet() %>% addTiles() %>%
#   addPopups(-122.327298, 47.597131, content,
#             options = popupOptions(closeButton = FALSE)
#   )

# 
# leaflet(data = velo_ant_df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = ~as.character(name, bikes, free, timestamp))
# 
# 
# leaflet(data = velo_ant_df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = c(~as.character(name), ~as.character(bikes), 
#                                    ~as.character(free), ~as.character(timestamp)))
# 
# leaflet(data = velo_ant_df) %>% addTiles() %>%
#   addMarkers(~lng, ~lat, popup = paste(~as.character(name), ~as.character(bikes), 
#                                    ~as.character(free), ~as.character(timestamp)))




coordinates_url <- str_split(coordinates_url, ",")
coordinates_url <- coordinates_url[[1]][1:2]
coordinates_url <- as.numeric(coordinates_url)

distance <- function(x,y,u,v){
  res <- sqrt((x-u)^2 + (y - v)^2   )
  return(res)
}

velo_ant_df$dist <- with(velo_ant_df, distance(lat,lng,coordinates_url[1], coordinates_url[2]) )
summary(velo_ant_df$dist)





