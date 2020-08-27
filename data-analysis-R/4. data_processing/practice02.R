# data processing practice in R by sangmin

# sorting
head(state.x77)
st <- data.frame(state.x77)
st[order(st$Population), ]
st[order(st$Income, decreasing=T), ]
ill <- st[order(st$Illiteracy), ]
subset(ill, select=c("Illiteracy"))
ill[1:10, ]


# data extraction
mt.gear <- split(mtcars, mtcars$gear)
mt.gear
mt.gear$'4'
mt.gear.35 <- merge(mt.gear$'3', mt.gear$'5', all=T)[order(mt$gear), ]
mt.gear.35
subset(mtcars, wt >= 1.5 & wt <= 3.0)