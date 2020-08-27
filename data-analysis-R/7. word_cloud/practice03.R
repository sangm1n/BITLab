# word cloud practice in R by sangmin

# set environments and packages
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_241")

library(RColorBrewer)
library(wordcloud)
library(KoNLP)

setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\7. word_cloud")


# show kindergardens on the map with markers
library(ggplot2)
library(ggmap)
register_google("GOOGLE_MAPS_API")

file <- read.csv("유치원_현황.csv")
addr <- as.vector(file[, 3])
names <- as.vector(file[, 2])

gc <- geocode(enc2utf8(addr))
df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)

cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center=cen, maptype="roadmap",
                     zoom=14, marker=gc)
gmap <- ggmap(map)
gmap+geom_text(data=df, aes(x=lon, y=lat),
               size=3, label=df$name, fontface="bold")


# monthly statistics
file <- read.csv("2016년_시도_시군구별_월별_교통사고.csv")
file <- file[, c(3,4,5,6)]
aggregate(file[-1], by=list(월=file$월), FUN=sum)

# regional statistics
data <- read.csv("2016년_시도_시군구별_월별_교통사고.csv")
data <- data[, c(1,4,5,6)]
aggregate(data[-1], by=list(시도=data$시도), FUN=sum)
