# data visualization practice in R by sangmin

# mosaic plot
HairEyeColor
par(mfrow=c(1, 3))
mosaicplot(~Sex+Hair, data=HairEyeColor,
           color=T, main="Gender and Hair")
mosaicplot(~Sex+Eye, data=HairEyeColor,
           color=T, main="Gender and Eye")
mosaicplot(~Hair+Eye, data=HairEyeColor,
           color=T, main="Hair and Eye")
par(mfrow=c(1, 1))


# mosaic plot practice
santa <- data.frame(belief=c("no belief", "no belief", "no belief", "no belief",
                             "belief", "belief", "belief", "belief",
                             "belief", "belief", "no belief", "no belief",
                             "belief", "belief", "no belief", "no belief"),
                    sibling=c("older brother", "older brother", 
                              "older brother", "older sister", 
                              "no older sibling", "no older sibling", 
                              "no older sibling", "older sister",
                              "older brother", "older sister",
                              "older brother", "older sister",
                              "no older sibling", "older sister",
                              "older brother", "no older sibling"))
colors <- c("red", "blue", "green")

mosaicplot(~belief+sibling, data=santa,
           color=colors)
