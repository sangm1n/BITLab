# multivariate data practice in R by sangmin

# information of data
head(cars)

# scatter plot and correlation analysis
plot(dist~speed, data=cars, pch=19, col="red",
     main="speed-distance")
cor(cars)
res <- lm(dist~speed, data=cars)
abline(res)


# information of data
head(pressure)

# scatter plot and correlation analysis
plot(pressure~temperature, data=pressure, pch=19, col="red",
     main="temperature-air pressure")
cor(pressure)
res <- lm(pressure~temperature, data=pressure)
abline(res)
