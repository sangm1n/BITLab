# univariate data practice in R by sangmin

# information of data
score <- c(90,85,73,80,85,65,78,50,68,96)
names(score) <- c('KOR', 'ENG', 'ATH', 'HIST', 'SOC', 'MUSIC', 'BIO', 'EARTH', 'PHY', 'ART')

# average, median
mean(score)
median(score)

# the highest score
names(score[which.max(score)])

par(mfrow=c(1, 2))
# box plot
boxplot(score, main="score")
boxplot.stats(score)$out

# histogram
hist(score, main="score of student",
     xlab="score", ylab="student", col="grey")