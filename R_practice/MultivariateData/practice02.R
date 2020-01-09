# multivariate data practice in R by sangmin

# information of data
head(state.x77)
class(state.x77)

# # scatter plot and correlation analysis
pairs(state.x77[, c(2,3,8)],
      pch=c(1,2,3),
      col=c("red", "green", "blue"))
cor(state.x77[, c(2,3,8)])


# information of data
head(iris)
class(iris)
point <- as.numeric(iris$Species)

# scatter plot and correlation analysis
pairs(state.x77[, c(2,3,8)],
      pch=c(1,2,3),
      col=c("red", "green", "blue"))
cor(state.x77[, c(2,3,8)])

