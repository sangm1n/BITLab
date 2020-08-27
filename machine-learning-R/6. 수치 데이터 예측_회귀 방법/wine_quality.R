setwd("C:/Users/sangmin/Desktop/github/[서적] R을 활용한 머신러닝/6. 수치 데이터 예측_회귀 방법")
library(Cubist)
library(rpart)
library(rpart.plot)

wine <- read.csv("whitewines.csv")
str(wine)

hist(wine$quality, col="grey")

wine_train <- wine[1:3750, ]     # 75% data
wine_test <- wine[3751:4898, ]   # 25% data


m.rpart <- rpart(quality~., data = wine_train)
m.rpart

# 숫자의 자리 수 조정
rpart.plot(m.rpart, digits = 3)

rpart.plot(m.rpart, digits = 4, 
           fallen.leaves = TRUE,  # 리프 노드가 바닥에 오도록 
           type = 3,         
           extra = 101)

p.rpart <- predict(m.rpart, wine_test)

summary(p.rpart)
summary(wine_test$quality)

cor(p.rpart, wine_test$quality)

MAE <- function(actual, predicted) {
    mean(abs(actual - predicted))
}

MAE(p.rpart, wine_test$quality)

mean(wine_train$quality)
MAE(5.87, wine_test$quality)

m.cubist <- cubist(x = wine_train[-12], y = wine_train$quality)
m.cubist

p.cubist <- predict(m.cubist, wine_test)
summary(p.cubist)
cor(p.cubist, wine_test$quality)
MAE(wine_test$quality, p.cubist)