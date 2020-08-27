# data visualization practice in R by sangmin

# treemap and symbols using state.x77 dataset
us <- data.frame(state.x77, state.division)
head(us)
library(treemap)
state.name <- as.factor(rownames(us))
us.2 <- data.frame(us, state.name)
head(us.2)
treemap(us.2, index=c("state.division", "state.name"), 
        vSize="Population", vColor="Income", type="dens",
        bg.labels="yellow", title="US state")

treemap(us.2, index=c("state.division", "state.name"),
        vSize="HS.Grad", vColor="Murder", type="value",
        bg.labels="yellow", title="US state")

symbols(us.2$Income, us.2$Illiteracy, circles=us.2$Population,
        inches=0.4, fg="grey", bg="green",
        xlab="Income", ylab="Illiteracy", main="Income and Illiteracy")
text(us.2$Income, us.2$Illiteracy,
     rownames(us), cex=0.6, col="brown")

symbols(us.2$Illiteracy, us.2$Murder, circles=us.2$Area,
        inches=0.5, fg="grey", bg="green",
        xlab="Illiteracy", ylab="Murder", main="Illiteracy and Murder")
text(us.2$Illiteracy, us.2$Murder, 
     rownames(us), cex=0.6, col="brown")


# treemap using swiss dataset
head(swiss)
a <- data.frame(subset(swiss, Education <= 6), group="low")
b <- data.frame(subset(swiss, Education >= 13), group="high")
c <- data.frame(subset(swiss, Education > 6 & Education < 13), group="mid")
swiss.name <- rownames(swiss)
swiss.2 <- rbind(a, b, c)
swiss.2 <- data.frame(swiss.2, swiss.name)
swiss.2

treemap(swiss.2, index=c("group", "swiss.name"), 
        vSize="Fertility", vColor="Agriculture", type="value",
        bg.labels="yellow", title="Swiss state name")

treemap(swiss.2, index="swiss.name",
        vSize="Catholic", vColor="Examination", type="dens",
        title="Swiss state name")