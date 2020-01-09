# univariate data practice in R by sangmin

# information of data
head(mtcars)
class(mtcars)

# average, median, trimmed mean(15%), standard deviation for weight
mean(mtcars$wt)
median(mtcars$wt)
mean(mtcars$wt, trim=0.15)
sd(mtcars$wt)

# frequency distribution table for cyl
table(mtcars$cyl)

# bar graph for cyl
barplot(table(mtcars$cyl), main="number of cyl")

# histogram for weight
hist(mtcars$wt, main="weight", col="grey")

par(mfrow=c(1, 2))
# box plot, outlier for weight
boxplot(mtcars$wt, main="weight")
boxplot.stats(mtcars$wt)$out

# box plot, outlier for disp
boxplot(mtcars$disp, main="disp")
boxplot.stats(mtcars$disp)$out
