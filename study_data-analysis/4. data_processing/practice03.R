# data processing practice in R by sangmin

# data aggregate using package
library(mlbench)
data("Glass")
myds <- Glass
head(myds)
aggregate(myds[, -10], by=list(type=myds$Type), FUN=mean)

library(mlbench)
data("Ionosphere")
myds <- Ionosphere
head(myds)
aggregate(myds[, 3:10], by=list(class=myds$Class), FUN=sd)