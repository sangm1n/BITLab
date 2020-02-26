# regression analysis practice in R by sangmin

# simple linear regression
st <- data.frame(state.x77)
plot(Murder~Illiteracy, data=st, pch=16)
model <- lm(Murder~Illiteracy, st)
abline(model)

b <- coef(model)[1]
W <- coef(model)[2]

md <- c(0.5, 1.0, 1.5)
for (i in 1:3) {
    cat(W * md[i] + b, "\n")
}


# simple linear regression
plot(Volume~Girth, data=trees, pch=16)
model <- lm(Volume~Girth, trees)
abline(model)

b <- coef(model)[1]
W <- coef(model)[2]

vo <- c(8.5, 9.0, 9.5)
for (i in 1:3) {
    cat(W * vo[i] + b, "\n")
}


# simple linear regression
plot(pressure~temperature, data=pressure, pch=16)
model <- lm(pressure~temperature, pressure)
abline(model)

b <- coef(model)[1]
W <- coef(model)[2]

pr <- c(65, 95, 155)
for (i in 1:3) {
    cat(W * pr[i] + b, "\n")    
}
