# data visualization practice in R by sangmin

# require packages
library(Rtsne)
library(car)
library(rgl)
library(mgcv)


# dimension reduction using state.x77 dataset
st <- data.frame(state.x77)
head(st)
which(duplicated(st))

tsne <- Rtsne(st, dims=2, perplexity=10)
st.tsne <- data.frame(tsne$Y)
head(st.tsne)
# 2D scatter plot
ggplot(st.tsne, aes(x=X1, y=X2)) +
  geom_point(size=2)

tsne.2 <- Rtsne(st, dims=3, perplexity=10)
st.tsne.2 <- data.frame(tsne.2$Y)
head(st.tsne.2)
# 3D scatter plot
scatter3d(x=st.tsne.2$X1, y=st.tsne.2$X2, z=st.tsne.2$X3, surface=F)


# dimension reduction using swiss dataset
head(swiss)
which(duplicated(swiss))

tsne <- Rtsne(swiss, dims=2, perplexity=10)
sw.tsne <- data.frame(tsne$Y)
head(sw.tsne)
# 2D scatter plot
ggplot(sw.tsne, aes(x=X1, y=X2)) +
  geom_point(size=2)

tsne.2 <- Rtsne(swiss, dims=3, perplexity=10)
sw.tsne.2 <- data.frame(tsne.2$Y)
head(sw.tsne.2)
# 3D scatter plot
scatter3d(x=sw.tsne.2$X1, y=sw.tsne.2$X2, z=sw.tsne.2$X3, surface=F)