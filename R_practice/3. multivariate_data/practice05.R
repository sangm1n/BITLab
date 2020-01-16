# multivariate data practice in R by sangmin

# information of data
library(mlbench)
data("Glass")
myds <- Glass

# scatter plot and correlation analysis without Type
pairs(myds[, -10], pch=19, col="red")
cor(myds[, -10])

# group by Type
point <- as.factor(myds$Type)
color <- c("red", "blue", "green", "yellow", "black", "brown", "purple")
pairs(myds[, -10], pch=c(point), col=color[point])


# information of data
years <- 1875:1972
hlevel <- as.vector(LakeHuron)

# line graph
plot(hlevel~years, type="l", lwd=2, col="blue",
     main="LakeHuron")
