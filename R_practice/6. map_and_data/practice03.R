# map and data practice in R by sangmin

library(ggmap)
library(ggplot2)
register_google("AIzaSyAU_3MpDapUjPlkDXFlNskojuSN8hKx1o4")

# the number of traffic accidents by district in Seoul
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


# the number of death by state in South Korea
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


# the number of injured by state in South Korea
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
