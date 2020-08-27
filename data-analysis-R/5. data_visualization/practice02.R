# data visualization practice in R by sangmin

# bubble chart
symbols(swiss$Fertility, swiss$Agriculture, circles=swiss$Education,
        inches=0.4, fg="grey", bg="green",
        xlab="Fertility", ylab="Agriculture", main="Fertility and Agriculture")
text(swiss$Fertility, swiss$Agriculture, 
     rownames(swiss), cex=0.6, col="brown")

head(trees)
symbols(trees$Girth, trees$Height, circles=trees$Volume,
        inches=0.5, fg="white", bg="blue",
        xlab="Girth", ylab="Height", main="Girth and Height")
text(trees$Girth, trees$Height,
     rownames(trees), cex=0.8, col="yellow")


