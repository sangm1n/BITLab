setwd("C:/Users/sangmin/Desktop/github/[서적] R을 활용한 머신러닝/6. 수치 데이터 예측_회귀 방법")
library(psych)

insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)
str(insurance)

summary(insurance$expenses)

hist(insurance$expenses, col="grey")
cor(insurance[c("age", "bmi", "children", "expenses")])
pairs.panels(insurance[c("age", "bmi", "children", "expenses")])

ins_model <- lm(expenses~., data = insurance)
ins_model


## 모델 성능 개선
insurance$age2 <- insurance$age^2
insurance$bmi30 <- ifelse(insurance$bmi >= 30, 1, 0)
ins_model2 <- lm(expenses ~ age + age2 + children + bmi + sex + region + bmi30*smoker,
                 data = insurance)
summary(ins_model2)

insurance$pred <- predict(ins_model2, insurance)

cor(insurance$pred, insurance$expenses)
plot(insurance$pred, insurance$expenses)
abline(a = 0, b = 1, col = "red", lwd = 3, lty = 2)

predict(ins_model2,
        data.frame(age = 30, age2 = 30^2, children = 2,
                   bmi = 30, sex = "male", bmi30 = 1,
                   smoker = "no", region = "northeast"))
predict(ins_model2,
        data.frame(age = 30, age2 = 30^2, children = 2,
                   bmi = 30, sex = "female", bmi30 = 1,
                   smoker = "no", region = "northeast"))