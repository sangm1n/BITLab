# clustering and classification practice in R by sangmin

# k-nearest neighbor algorithm
library(mlbench)
data(Sonar)

tr.idx <- seq(1, 208, 2)
ds.tr <- Sonar[tr.idx, -61]
ds.ts <- Sonar[-tr.idx, -61]
cl.tr <- Sonar[tr.idx, 61]
cl.ts <- Sonar[tr.idx, 61]

pred <- knn(ds.tr, ds.ts, cl.tr, k=3, prob=T)
acc3 <- mean(pred == cl.ts)
acc3

pred <- knn(ds.tr, ds.ts, cl.tr, k=5, prob=T)
acc5 <- mean(pred == cl.ts)
acc5

pred <- knn(ds.tr, ds.ts, cl.tr, k=7, prob=T)
acc7 <- mean(pred == cl.ts)
acc7


library(cvTools)
library(mlbench)
data(Sonar)

k <- 5
folds <- cvFolds(nrow(Sonar), K=k)
acc <- c()
for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- Sonar[-ts.idx, -61]
    ds.ts <- Sonar[ts.idx, -61]
    cl.tr <- factor(Sonar[-ts.idx, 61])
    cl.ts <- factor(Sonar[ts.idx, 61])
    
    pred <- knn(ds.tr, ds.ts, cl.tr, k=3)
    acc[i] <- mean(pred == cl.ts)
}
mean(acc)


library(cvTools)
library(mlbench)
data("BreastCancer")

for (i in 1:10) {
    this.na <- is.na(BreastCancer[,i])
    cat(colnames(BreastCancer)[i], "\t", sum(this.na), "\n")
}

mydata <- BreastCancer[, -7]
k <- 10
folds <- cvFolds(nrow(mydata), K=k)
acc <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- mydata[-ts.idx, -10]
    ds.ts <- mydata[ts.idx, -10]
    cl.tr <- factor(mydata[-ts.idx, 10])
    cl.ts <- factor(mydata[ts.idx, 10])
    
    pred <- knn(ds.tr, ds.ts, cl.tr, k=5)
    acc[i] <- mean(pred == cl.ts)
}
mean(acc)