library(caret)
library(klaR)
setwd("C:\\Users\\sangmin\\Desktop\\BITlab")
data <- read.csv("radiomics_fundus_ds.csv")
label <- as.factor(data[, 1])
new_data <- data[, -c(2, 3)]

data_nrow <- nrow(new_data)
data_ncol <- ncol(new_data)
sum(is.na(new_data))

full <- lm(cl~., data=new_data)
null <- lm(cl~1, data=new_data)

forward <- step(null, direction="forward",
                scope=list(lower=null, upper=full))
backward <- step(full, direction="backward")
stepwise <- step(null, direction="both",
                 scope=list(upper=full))

forward_col <- rownames(data.frame(forward[["coefficients"]][-1]))
backward_col <- rownames(data.frame(backward[["coefficients"]][-1]))
stepwise_col <- rownames(data.frame(stepwise[["coefficients"]][-1]))

head(new_data, 2)
head(new_data[, forward_col])
new_data <- new_data[, -1]
head(new_data, 2)

set.seed(100)
folds <- createFolds(label, k=5, returnTrain=TRUE)

forward_nb <- lapply(folds, function(x) {
    train <- new_data[x, forward_col]
    test <- new_data[-x, forward_col]
    
    classTrain <- label[x]
    classTest <- label[-x]
    
    model <- train(train, classTrain, method="nb")
    pred <- predict(model, test)
    matrix <- confusionMatrix(pred, classTest)
    
    return(matrix$overall[[1]])
})

backward_nb <- lapply(folds, function(x) {
    train <- new_data[x, backward_col]
    test <- new_data[-x, backward_col]
    
    classTrain <- label[x]
    classTest <- label[-x]
    
    model <- train(train, classTrain, method="nb")
    pred <- predict(model, test)
    matrix <- confusionMatrix(pred, classTest)
    
    return(matrix$overall[[1]])
})

stepwise_nb <- lapply(folds, function(x) {
    train <- new_data[x, stepwise_col]
    test <- new_data[-x, stepwise_col]
    
    classTrain <- label[x]
    classTest <- label[-x]
    
    model <- train(train, classTrain, method="nb")
    pred <- predict(model, test)
    matrix <- confusionMatrix(pred, classTest)
    
    return(matrix$overall[[1]])
})

str(forward_nb)
mean(unlist(forward_nb))
str(backward_nb)
mean(unlist(backward_nb))
str(stepwise_nb)
mean(unlist(stepwise_nb))

stepwise_rf <- lapply(folds, function(x) {
    train <- new_data[x, stepwise_col]
    test <- new_data[-x, stepwise_col]
    
    classTrain <- label[x]
    classTest <- label[-x]
    
    model <- train(train, classTrain, method="svmLinear")
    pred <- predict(model, test)
    matrix <- confusionMatrix(pred, classTest)
    
    return(matrix$overall[[1]])
})

str(stepwise_rf)
mean(unlist(stepwise_rf))


ctrl <- trainControl(method="cv", 5, verbose=FALSE)
set.seed(100)

forward <- function(x) {
    fw_data <- rbind(label, new_data[, forward_col])
    model <- train(cl~., data=fw_data,
                   trControls=ctrl, method=x)
    
}


fw_data <- cbind("cl"=label, new_data[, forward_col])
model <- train(cl~.,
               fw_data,
               method="nb",
               trControl=ctrl)
model

head(fw_data, 2)
head(fw_data)
head(new_data, 2)

forward_col
c(1, forward_col)
head(fw_data)
head(rbind(label, fw_data), 3)





library(tidyverse)

head(data, 2)
data <- data[-2]

set.seed(100)
indexTrain <- createDataPartition(data$cl, p=.7, list=FALSE)
train_dt <- data[indexTrain, ]
test_dt <- data[-indexTrain, ]

fitControl <- trainControl(method="repeatedcv", number=5, repeats=5)

forward <- function(x) {
    train_dt <- data[indexTrain, c("cl", forward_col)]
    test_dt <- data[-indexTrain, c("cl", forward_col)]
    
    model <- train(cl~., data=train_dt, method=x, trControl=fitControl, verbose=FALSE)
    pred <- predict(model, test_dt)
    matrix <- confusionMatrix(pred, test_dt$cl)
    
    return(matrix)
}

forward_mat <- forward("rf")
forward_mat
forward_mat$overall["Accuracy"]



train_dt <- data[indexTrain, c("cl", forward_col)]
head(train_dt, 2)

colnames(train_dt)
colnames(test_dt)

data[, 1] <- as.factor(data[, 1])
head(data, 2)
as.factor(data[1])
data[1]
as.factor(data[, 1])


###
data <- read.csv("radiomics_fundus_ds.csv")
data <- data[-2]

full <- lm(cl~., data)
null <- lm(cl~1, data)

forward <- step(null, direction="forward",
                scope=list(lower=null, upper=full))
backward <- step(full, direction="backward")
stepwise <- step(null, direction="both",
                 scope=list(upper=full))

forward_col <- rownames(data.frame(forward[["coefficients"]][-1]))
backward_col <- rownames(data.frame(backward[["coefficients"]][-1]))
stepwise_col <- rownames(data.frame(stepwise[["coefficients"]][-1]))


data[, 1] <- as.factor(data[, 1])


set.seed(100)
indexTrain <- createDataPartition(data$cl, p=.7, list=FALSE)
train_dt <- data[indexTrain, ]
test_dt <- data[-indexTrain, ]

fitControl <- trainControl(method="repeatedcv", number=5, repeats=5)

forward <- function(x) {
    train_dt <- data[indexTrain, c("cl", forward_col)]
    test_dt <- data[-indexTrain, c("cl", forward_col)]
    
    model <- train(cl~., data=train_dt, method=x, trControl=fitControl, verbose=FALSE)
    pred <- predict(model, test_dt)
    matrix <- confusionMatrix(pred, test_dt$cl)
    
    return(matrix)
}

backward <- function(x) {
    train_dt <- data[indexTrain, c("cl", backward_col)]
    test_dt <- data[-indexTrain, c("cl", backward_col)]
    
    model <- train(cl~., data=train_dt, method=x, trControl=fitControl, verbose=FALSE)
    pred <- predict(model, test_dt)
    matrix <- confusionMatrix(pred, test_dt$cl)
    
    return(matrix)
}

stepwise <- function(x) {
    train_dt <- data[indexTrain, c("cl", stepwise_col)]
    test_dt <- data[-indexTrain, c("cl", stepwise_col)]
    
    model <- train(cl~., data=train_dt, method=x, trControl=fitControl, verbose=FALSE)
    pred <- predict(model, test_dt)
    matrix <- confusionMatrix(pred, test_dt$cl)
    
    return(matrix)
}

forward_mat <- forward("rf")
forward_mat
forward_mat$overall["Accuracy"]

backward_mat <- backward("rf")
backward_mat
backward_mat$overall["Accuracy"]

stepwise_mat <- stepwise("rf")
stepwise_mat
stepwise_mat$overall["Accuracy"]

result <- cbind(forward_mat$overall["Accuracy"], 
                backward_mat$overall["Accuracy"], 
                stepwise_mat$overall["Accuracy"])
colnames(result) <- c("forward", "backward", "stepwise")
result