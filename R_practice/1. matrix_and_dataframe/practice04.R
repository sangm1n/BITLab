# matrix, data frame practice in R by sangmin

# write to rich_state.csv
setwd("C:/Users/sangmin/Desktop")
class(state.x77)
st <- data.frame(state.x77)
rich <- subset(st,
               select = c('Income', 'Population', 'Area'), 
               Income >= 5000)
write_csv(rich, "rich_state.csv", row.names = F)

# read from rich_state.csv
setwd("C:/Users/sangmin/Desktop")
ds <- read.csv("rich_state.csv", header = T)
head(ds)