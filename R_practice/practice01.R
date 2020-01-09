# matrix, data frame practice in R by sangmin

# information of data
st <- data.frame(state.x77)
head(st)
str(st)

# state data for population over 5000
subset(st, Population >= 5000)
# population, income, area for income over 4500
subset(st,
       select = c('Population', 'Income', 'Area'),
       Income >= 4500)
# state data for area over 100000 and frost over 120
subset(st, Area >= 100000 & Frost >= 1200)
# average income for illiteracy over 2.0
colMeans(subset(st,
                select = Income,
                Illiteracy >= 2.0))
# state with the hightest life exp
subset(st, Life.Exp == max(st$Life.Exp))
# state higher income than Pennsylvania
subset(st, Income > st['Pennsylvania', 'Income'])
