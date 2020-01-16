# matrix, data frame practice in R by sangmin

# information of data
class(airquality)
head(airquality)

# month, day for the highest temperature
subset(airquality,
       select = c('Month', 'Day'),
       Temp == max(airquality$Temp))
# the highest wind in June
june <- subset(airquality, Month == 6)
subset(june,
       select = Wind,
       Wind == max(june$Wind))
# average ozone in May without NA
colMeans(subset(airquality,
                select = Ozone,
                Month == 5 & Ozone != 'NA'))
# number of days when ozone over 100
nrow(subset(airquality, Ozone > 100))