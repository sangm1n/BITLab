# clustering and classification practice in R by sangmin

# k-nearest neighbor algorithm
library(cvTools)
library(mlbench)
library(class)
data("PimaIndiansDiabetes")

mydata <- PimaIndiansDiabetes
k <- 10
folds <- cvFolds(nrow(mydata), K=k)
acc <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- mydata[-ts.idx, -9]
    ds.ts <- mydata[ts.idx, -9]
    cl.tr <- factor(mydata[-ts.idx, 9])
    cl.ts <- factor(mydata[ts.idx, 9])
    
    pred <- knn(ds.tr, ds.ts, cl.tr, k=5)
    acc[i] <- mean(pred == cl.ts)
}
mean(acc)



data("Vehicle")

k <- 10
folds <- cvFolds(nrow(Vehicle), K=k)
acc <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- Vehicle[-ts.idx, -19]
    ds.ts <- Vehicle[ts.idx, -19]
    cl.tr <- factor(Vehicle[-ts.idx, 19])
    cl.ts <- factor(Vehicle[ts.idx, 19])
    
    pred <- knn(ds.tr, ds.ts, cl.tr, k=3)
    acc[i] <- mean(pred == cl.ts)
}
mean(acc)



data("Vowel")

k <- 10
folds <- cvFolds(nrow(Vowel), K=k)
acc <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- Vowel[-ts.idx, -11]
    ds.ts <- Vowel[ts.idx, -11]
    cl.tr <- factor(Vowel[-ts.idx, 11])
    cl.ts <- factor(Vowel[ts.idx, 11])
    
    pred <- knn(ds.tr, ds.ts, cl.tr, k=5)
    acc[i] <- mean(pred == cl.ts)
}
mean(acc)
