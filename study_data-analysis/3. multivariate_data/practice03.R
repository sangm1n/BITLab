# multivariate data practice in R by sangmin

# information of data
income <- c(121,99,41,35,40,29,35,24,50,60)
edu <- c(19,20,16,16,18,12,14,12,16,17)
time <- data.frame(income, edu)

# scatter plot and correlation analysis
plot(edu~income, data=time, pch=19, col="red",
     main="income-education time")
col(time)
res <- lm(edu~income, data=time)
abline(res)


# information of data
score <- c(77.5,60,50,95,55,85,72.5,80,92.5,87.5)
tv <- c(14,10,20,7,25,9,15,13,4,21)
time <- data.frame(score, tv)

# scatter plot and correlation analysis
plot(tv~score, data=time, pch=19, col="red",
     main="score-TV hours per week")
cor(time)
res <- lm(tv~score, data=time)
abline(res)
