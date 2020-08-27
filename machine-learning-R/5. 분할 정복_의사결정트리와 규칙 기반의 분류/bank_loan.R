setwd("C:/Users/sangmin/Desktop/github/R을_활용한_머신러닝/5. 분할 정복_의사결정트리와 규칙 기반의 분류")
library(C50)
library(gmodels)

credit <- read.csv("credit.csv")
str(credit)

table(credit$checking_balance)
table(credit$savings_balance)
summary(credit$months_loan_duration)
summary(credit$amount)

set.seed(1234)
train_sample <- sample(1000, 900)

credit_train <- credit[train_sample, ]
credit_test <- credit[-train_sample, ]
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

credit_model <- C5.0(credit_train[-17], credit_train$default)
credit_pred <- predict(credit_model, credit_test)
CrossTable(credit_test$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))


# boosting
credit_boost10 <- C5.0(credit_train[-17], credit_train$default, trials=10)
credit_boost10
credit_boost_pred10 <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))


# cost matrix
matrix_dimensions <- list(c("no", "yes"), c("no", "yes"))
names(matrix_dimensions) <- c("predicted", "actual")

matrix_dimensions

error_cost <- matrix(c(0, 1, 4, 0), nrow=2, dimnames=matrix_dimensions)
error_cost

credit_cost <- C5.0(credit_train[-17], credit_train$default,
                    costs = error_cost)
credit_cost_pred <- predict(credit_cost, credit_test)
CrossTable(credit_test$default, credit_cost_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))