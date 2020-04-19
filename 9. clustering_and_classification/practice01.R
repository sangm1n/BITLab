# clustering and classification practice in R by sangmin

# k-means clustering (5 cluster)
library(cluster)

std <- function(X) {
    return((X-min(X)) / (max(X)-min(X)))
}

mydata <- apply(state.x77, 2, FUN=std)
fit <- kmeans(x=mydata, centers=5)

clusplot(mydata, fit$cluster, color=T, shade=T,
         labels=1, lines=0)


# 2 cluster
library(mlbench)
data("Sonar")

mydata <- Sonar[, -61]
fit <- kmeans(x=mydata, centers=2)

clusplot(mydata, fit$cluster, color=T, shade=T,
         labels=1, lines=0)


# 3 cluster
std <- function(X) {
    return((X-min(X)) / (max(X)-min(X)))
}

mydata <- apply(swiss, 2, FUN=std)
fit <- kmeans(x=mydata, centers=3)

clusplot(mydata, fit$cluster, color=T, shade=T,
         labels=1, lines=0)


# 3 cluster
std <- function(X) {
    return((X-min(X)) / (max(X)-min(X)))
}

mydata <- apply(rock, 2, FUN=std)
fit <- kmeans(x=mydata, centers=3)

clusplot(mydata, fit$cluster, color=T, shade=T,
         labels=1, lines=0)
