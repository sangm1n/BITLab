# map and data practice in R by sangmin

library(ggmap)
library(ggplot2)
register_google("AIzaSyAU_3MpDapUjPlkDXFlNskojuSN8hKx1o4")

# show markers on map
addrs <- c("서울특별시 양천구 신정동 목동동로 105",
           "서울특별시 강서구 화곡6동 화곡로 302",
           "서울특별시 마포구 성산2동 월드컵로 212",
           "서울특별시 용산구 이태원1동 녹사평대로 150",
           "서울특별시 서초구 서초2동 남부순환로 2584")
names <- c("양천구청", "강서구청", "마포구청", "용산구청", "서초구청")

gc <- geocode(enc2utf8(addrs))
dt <- data.frame(gc, names)
cen <- c(mean(gc$lon), mean(gc$lat))

map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=11, marker=gc)
gmap <- ggmap(map)
gmap + geom_text(data=dt, aes(x=lon, y=lat),
                 size=5, label=dt$names, color="navy",
                 fontface="bold")


# show Korea metropolitan city
names <- c("인천광역시", "대전광역시", "대구광역시",
           "부산광역시", "광주광역시", "울산광역시")
gc <- geocode(enc2utf8(names))
cen <- c(mean(gc$lon), mean(gc$lat))
dt <- data.frame(names, gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=7, marker=gc)
gmap <- ggmap(map)
gmap + geom_text(data=dt, aes(x=lon, y=lat),
                 size=5, label=dt$names, color="navy",
                 fontface="bold")


# show National park
addrs <- c("서울시 성북구 보국문로262길 103",
           "강원도 속초시 설악산로 833번지",
           "강원도 원주시 소초면 무쇠점2길 26",
           "강원도 평창군 진부면 오대산로 2",
           "강원도 태백시 태백산로4778")
names <- c("북한산국립공원", "설악산국립공원",
           "치악산국립공원", "오대산국립공원",
           "태백산국립공원")
gc <- geocode(enc2utf8(addrs))
dt <- data.frame(names, gc)

cen <- c(mean(dt$lon), mean(dt$lat))
map <- get_googlemap(center=cen, maptype="satellite",
                     zoom=8, marker=gc)
gmap <- ggmap(map)
gmap + geom_text(data=dt, aes(x=lon, y=lat),
                 size=5, label=dt$names, color="white",
                 fontface="bold")