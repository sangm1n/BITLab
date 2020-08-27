setwd("C:/Users/sangmin/Desktop/github/R을_활용한_머신러닝/5. 분할 정복_의사결정트리와 규칙 기반의 분류")
library(OneR)
library(gmodels)
library(RWeka)

mushrooms <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)
str(mushrooms)

mushrooms$veil_type <- NULL
table(mushrooms$type)

mushroom_1R <- OneR(type~., data=mushrooms)
mushroom_1R

mushroom_1R_pred <- predict(mushroom_1R, mushrooms)
table(actual = mushrooms$type, predicted = mushroom_1R_pred)

mushroom_JRip <- JRip(type~., data=mushrooms)
mushroom_JRip