# univariate data practice in R by sangmin

# information of data
head(Orange)

# average, median, trimmed mean(15%), standard deviation for age
mean(Orange$age)
median(Orange$age)
mean(Orange$age, trim=0.15)
sd(Orange$age)

# average, median, trimmed mean(15%), standard deviation for circumference
mean(Orange$circumference)
median(Orange$circumference)
mean(Orange$circumference, trim=0.15)
sd(Orange$circumference)

par(mfrow=c(1, 2))
# histogram, box plot for age
hist(Orange$age, main="orange age",
     border="white", col="grey")
boxplot(Orange$age~Orange$Tree, main="orange age",
        col=c("red", "blue", "green", "grey", "yellow"))

# histogram, box plot for circumeference
hist(Orange$circumference, main="orange circumference",
     border="white", col="grey")
boxplot(circumference~Tree, data = Orange, 
        main="orange circumference",
        col=c("red", "blue", "green", "grey", "yellow"))
par(mfrow=c(1, 1))
head(iris)
state.x77

class(state.x77)
head(state.x77)

head(iris)
class(iris)
