# data visualization practice in R by sangmin

# make a dataset
year <- 2015:2026
population <- c(51014,51245,51446,51635,51811,51973,52123,52261,52388,52504,52609,52704)
data <- data.frame(year, population)
# line graph using ggplot
ggplot(data, aes(x=year, y=population)) + 
  geom_line(col="red", lwd=1.5)

# make a dataset
year <- c(20144, seq(20151,20154), seq(20161,20164), seq(20171,20173))
male <- c(73.9,73.1,74.4,74.2,73.5,73,74.2,74.5,73.8,73.1,74.5,74.2)
female <- c(51.4,50.5,52.4,52.4,51.9,50.9,52.6,52.7,52.2,51.5,53.2,53.1)
data <- data.frame(year, male, female)
# two line graphs using ggplot
ggplot(data, aes(x=year, y=male)) +
  geom_line(col="red", lwd=1.3) +
  geom_line(aes(x=year, y=female), col="blue", lwd=1.3) +
  ylim(40, 80)