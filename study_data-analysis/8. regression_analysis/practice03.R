# regression analysis practice in R by sangmin

# logistic regression
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

model <- glm(admit~., data=mydata)

test <- mydata[-1]
pred <- predict(model, test)
pred <- round(pred, 0)
answer <- mydata[, 1]

acc <- mean(answer == pred)
acc


# logistic regression
library(mlbench)
dt <- data.frame(PimaIndiansDiabetes)

set.seed(100)
# train data, test data
train.cnt <- sample(1:nrow(dt), size=nrow(dt)*0.6, replace=F)
train.cnt <- sort(train.cnt)
train <- dt[train.cnt, ]
test <- dt[-train.cnt, ]

train$diabetes <- as.integer(train$diabetes)
model <- glm(diabetes~., data=train)

pred <- predict(model, test)
pred <- round(pred, 0)
answer <- as.integer(test$diabetes)

# accuracy
acc <- mean(pred == answer)
acc


# logistic regression
library(mlbench)
data(Glass)

set.seed(100)
# train data, test data
train.cnt <- sample(1:nrow(Glass), size=nrow(Glass)*0.6, replace=F)
train.cnt <- sort(train.cnt)
train <- Glass[train.cnt, ]
test <- Glass[-train.cnt, ]

train$Type <- as.integer(train$Type)
model <- glm(Type~., data=train)

pred <- predict(model, test)
pred <- round(pred, 0)
answer <- as.integer(test$Type)

# accuracy
acc <- mean(pred == answer)
acc
