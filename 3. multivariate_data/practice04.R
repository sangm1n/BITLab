# multivariate data practice in R by sangmin

# information of data
year <- 2015:2026
total <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)

# line graph
plot(year, total, lty=1, lwd=2, type="l", col="red",
     main="estimated population by year")


# information of data
year <- c(20144,seq(20151,20154),seq(20161,20164),seq(20171,20173))
male <- c(73.9,73.1,74.4,74.2,73.5,73,74.2,74.5,73.8,73.1,74.5,74.2)
female <- c(51.4,50.5,52.4,52.4,51.9,50.9,52.6,52.7,52.2,51.5,53.2,53.1)

# line graph
plot(year, male, type="l", col="red", lty=1, lwd=2,
     main="economic activity participation rate",
     ylim=c(50,75))
lines(year, female, col="blue", lwd=2)
