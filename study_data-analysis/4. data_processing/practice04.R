# data processing practice in R by sangmin

# data sampling
set.seed(100)
idx <- sample(1:nrow(state.x77), size=20, replace=F)

st20 <- state.x77[idx, ]
st.other <- state.x77[-idx, ]
st20
st.other

set.seed(100)
idx <- sample(1:nrow(iris), size=10, replace=F)

iris.10 <- iris[idx, ]
iris.10

set.seed(100)
idx <- sample(1:nrow(iris), size=nrow(iris), replace=F)

iris[idx, ]
