# univariate data practice in R by sangmin

# information of data
head(trees)

# average, median, trimmed mean(15%), standard deviation for girth
mean(trees$Girth)
median(trees$Girth)
mean(trees$Girth, trim=0.15)
sd(trees$Girth)

# average, median, trimmed mean(15%), standard deviation for height
mean(trees$Height)
median(trees$Height)
mean(trees$Height, trim=0.15)
sd(trees$Height)

par(mfrow=c(1, 2))
# histogram, box plot for girth
hist(trees$Girth, main="tree girth",
     border="white", col="grey")
boxplot(trees$Girth, main="tree girth")

# histogram, box plot for height
hist(trees$Height, main="tree height",
     border="white", col="grey")
boxplot(trees$Height, main="tree height")
par(mfrow=c(1, 1))
