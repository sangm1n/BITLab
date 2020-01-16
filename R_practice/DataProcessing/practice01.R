# data processing practice in R by sangmin

# missing value practice
ds <- state.x77
ds[2,3] <- NA
ds[3,1] <- NA
ds[2,4] <- NA
ds[4,3] <- NA

head(ds)

count_na <- function(x) {
  return(sum(is.na(x)))
}
apply(ds, 2, FUN=count_na)
ds[!complete.cases(ds), ]
sum(rowSums(is.na(ds)) > 0)
ds.new <- ds[complete.cases(ds), ]
ds.new


# missing value and outlier practice
st <- data.frame(state.x77)
head(st)
par(mfrow=c(2, 4))
for(i in 1:ncol(st)) {
  boxplot(st[, i], main=colnames(st[i]))  
}
par(mfrow=c(1, 1))

head(st)
val <- boxplot.stats(st$Population)$out
st$Population[st$Population %in% val] <- NA
val <- boxplot.stats(st$Income)$out
st$Income[st$Income %in% val] <- NA
val <- boxplot.stats(st$Area)$out
st$Area[st$Area %in% val] <- NA
st.2 <- st[!complete.cases(st), ]
st.2


# missing value and outlier practice
AQ <- airquality
head(AQ)
count <- function(x) {
  return(sum(is.na(x)))
}
apply(AQ, 2, FUN=count)
rowSums(is.na(AQ))
AQ[complete.cases(AQ), ]
head(AQ)

not <- AQ[complete.cases(AQ), ]
AQ$Ozone[AQ$Ozone %in% NA] <- mean(not$Ozone)
AQ$Solar.R[AQ$Solar.R %in% NA] <- mean(not$Solar.R)
AQ.2 <- AQ
AQ.2