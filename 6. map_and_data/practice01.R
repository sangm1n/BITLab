# map and data practice in R by sangmin

library(ggmap)
library(ggplot2)
register_google("GOOGLE_MAPS_API")

# show map using GoogleMaps
# roadmap type map
gc <- geocode(enc2utf8("서울시청"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     size=c(600,600))
ggmap(map)


# hybrid type map
gc <- geocode(enc2utf8("금강산"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, maptype="hybrid",
                     size=c(500,500), zoom=8)
ggmap(map)


# terrain type map
gc <- geocode(enc2utf8("강남역"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     size=c(640,640), zoom=16)
ggmap(map)


cen <- c(127.397692, 36.337058)
map <- get_googlemap(center=cen, maptype="roadmap", zoom=9)
ggmap(map)


cen <- c(135.502330, 34.693594)
map <- get_googlemap(center=cen, maptype="roadmap")
ggmap(map)
