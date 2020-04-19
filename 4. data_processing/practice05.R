# data processing practice in R by sangmin

# data merge
combn(levels(iris$Species), 2)

color <- c("red", "green", "blue", "black", "yellow")
combn(color, 3)


# merge practice
authors <- data.frame(
  surname = c("Twein", "Venables", "Tierney", "Ripley", "McNeil"),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  retired = c("yes", rep("no", 4))
)
books <- data.frame(
  name = c("Johns", "Venables", "Tierney", "Ripley", "Ripley", "McNeil"),
  title = c("Exploratory Data Analysis", 
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", 
            "Stochastic Simulation",
            "Interactive Data Analysis"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA)
)

merge(authors, books, by.x=c("surname"), by.y=c("name"))
merge(authors, books, by.x=c("surname"), by.y=c("name"), all.x=T)
merge(authors, books, by.x=c("surname"), by.y=c("name"), all.y=T)
merge(authors, books, by.x=c("surname"), by.y=c("other.author"))
