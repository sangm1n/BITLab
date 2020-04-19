# matrix, data frame practice in R by sangmin

# information of data
head(mtcars)
str(mtcars)

# data with the highest mpg
subset(mtcars, mpg == max(mtcars$mpg))
# data with the lowest mpg where 4 gear
mt <- subset(mtcars, gear == 4)
subset(mt, mpg == min(mt$mpg))
# mpg, gear for Honda Civic
mtcars['Honda Civic', c('mpg', 'gear')]
# data higher mpg than Pontiac Firebird
subset(mtcars,
       mpg >= mtcars['Pontiac Firebird', 'mpg'])
# average mpg
colMeans(subset(mtcars, select = mpg))
# number of gears
unique(mtcars$gear)
