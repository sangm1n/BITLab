library(ggmap)
library(ggplot2)
register_google("AIzaSyAU_3MpDapUjPlkDXFlNskojuSN8hKx1o4")

### 1
gc <- geocode(enc2utf8("서울시청"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     size=c(600,600))
ggmap(map)



gc <- geocode(enc2utf8("금강산"))
cen <- as.numeric(gc)

map <- get_googlemap(center=cen, maptype="hybrid",
                     size=c(500,500), zoom=8)
ggmap(map)



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


### 2
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


### 3
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


### 4
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


### 5
library(treemap)
data(GNI2014)
name <- subset(GNI2014, continent == "North America")

names <- name$country
gc <- geocode(enc2utf8(names))
dt <- data.frame(gc, name)
cen <- c(mean(gc$lon), mean(gc$lat)+10)

map <- get_googlemap(center=cen, zoom=3)
gmap <- ggmap(map)
gmap + geom_point(data=dt, aes(x=lon, y=lat, 
                               size=population),
                  alpha=0.7, color="red") +
    scale_size_continuous(range=c(2, 15))


### 6
setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\6. map_and_data")
data <- read.csv("도로교통공단_시도_시군구별_월별_교통사고(2018).csv")
seoul <- subset(data, 
                select=c("시군구", "월", "발생건수"), 
                시도=="서울")
gu.data <- aggregate(list(발생건수=seoul$"발생건수"),
                     by=list(시군구=seoul$"시군구"), sum)
gu.names <- as.vector(gu.data$"시군구")

gc <- geocode(enc2utf8(gu.names))
cen <- c(mean(gc$lon), mean(gc$lat))
dt <- data.frame(gu.data, gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=11, size=c(640,640))
gmap <- ggmap(map)

gmap + geom_point(data=dt, 
                  aes(x=lon, y=lat, size=발생건수),
                  alpha=0.5, color="red") +
    scale_size_continuous(range=c(1, 15))


### 7
setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\6. map_and_data")
data <- read.csv("도로교통공단_시도_시군구별_월별_교통사고(2018).csv")
data.2 <- subset(data, 
                 select=c("시도", "월", "사망자수"),
                 시도!="세종")
si.data <- aggregate(list(사망자수=data.2$"사망자수"),
                     by=list(시도=data.2$"시도"), sum)           
si.names <- as.vector(si.data$"시도")

gc <- geocode(enc2utf8(si.names))
cen <- c(mean(gc$lon), mean(gc$lat)-0.5)
dt <- data.frame(si.data, gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=7, size=c(640,640))
gmap <- ggmap(map)
gmap + geom_point(data=dt,
                  aes(x=lon, y=lat, size=사망자수),
                  alpha=0.5, color="black") +
    scale_size_continuous(range=c(1, 15))


### 8
setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\6. map_and_data")
data <- read.csv("도로교통공단_시도_시군구별_월별_교통사고(2018).csv")
data.2 <- subset(data,
                 select=c("시도", "월", "부상자수"),
                 시도!="세종" & (월=="07월" | 월=="08월"))
si.data <- aggregate(list(부상자수=data.2$"부상자수"),
                     by=list(시도=data.2$"시도"), sum)
si.names <- as.vector(si.data$"시도")

gc <- geocode(enc2utf8(si.names))
cen <- c(mean(gc$lon), mean(gc$lat))
dt <- data.frame(si.data, gc)

map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=7, size=c(640,640))
gmap <- ggmap(map)
gmap + geom_point(data=dt,
                  aes(x=lon, y=lat, size=부상자수),
                  alpha=0.5, color="blue") +
    scale_size_continuous(range=c(1, 15))
