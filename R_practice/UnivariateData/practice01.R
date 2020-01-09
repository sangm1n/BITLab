# univariate data practice in R by sangmin

# information of data
gender <- c('F', 'F', 'F', 'M', 'M', 'F', 'F', 'F', 'M', 'M')
color <- c("green", "blue")
names(gender) <- color

par(mfrow=c(1, 2))
# frequency distribution table
table(gender)

# bar graph
barplot(table(gender), main="gender", col=color)

# circle graph
pie(table(gender), main="gender", col=color)
par(mfrow=c(1, 1))


# information of data
season <- c("summer", "winter", "spring", "fall", "summer", "fall", "winter", "summer", "summer", "fall")
color <- c("red", "blue", "green", "grey")
names(season) <- color

par(mfrow=c(1, 2))
# frequency distribution table
table(season)

# bar graph
barplot(table(season), main="season", col=color)

# circle graph
pie(table(season), main="season", col=color)