# multivariate data practice in R by sangmin

# information of data
head(state.x77)
class(state.x77)

# scatter plot and correlation analysis
pairs(state.x77[, c(2,3,8)],
      pch=c(1,2,3),
      col=c("red", "green", "blue"))
cor(state.x77[, c(2,3,8)])


# information of data
head(iris)
class(iris)

# scatter plot and correlation analysis
point <- as.numeric(iris$Species)
color <- c("red", "blue", "green")
pairs(Sepal.Width~Sepal.Length, data=iris, pch=point, col=color[point])

