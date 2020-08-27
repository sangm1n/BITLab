# regression analysis practice in R by sangmin

# multi-linear regression
plot(trees, pch=16, col="red")
model <- lm(Volume~Girth+Height, trees)

b <- coef(model)[1]
W1 <- coef(model)[2]
W2 <- coef(model)[3]

pred <- b + W1*trees$Girth + W2*trees$Height
pred

compare <- data.frame(pred, trees[, 3], pred-trees[, 3])
names(compare) <- c("예측값", "실제값", "예측값-실제값")
compare


# multi-linear regression
library(MASS)
library(mlbench)
data(BostonHousing)

B.data <- BostonHousing[-4]
model <- lm(medv~., data=B.data)
summary(model)

# AIC : Akaike Information Criterion
mod2 <- stepAIC(model)
summary(mod2)


model <- lm(mpg~., data=mtcars)
summary(model)

mod2 <- stepAIC(model)
summary(mod2)
