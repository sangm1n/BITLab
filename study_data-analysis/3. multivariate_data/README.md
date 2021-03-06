# Multivariate data
### This is practice for multivariate data
***
#### What is Multivariate data ?
> the data consisting of two or more variables
#### Scatter
* Scatter plot (two variables)
```r
plot(x, y, col=COLOR, main="TITLE", xlab="X LABEL", ylab="Y LABEL")
```
<img src="https://user-images.githubusercontent.com/46131688/72048173-89e8b500-32ff-11ea-861f-d55ba33a2cb0.png">

* Scatter plot (multiple variables)
```r
pairs(data, col=COLOR, main="TITLE")
```
<img src="https://user-images.githubusercontent.com/46131688/72047898-e7303680-32fe-11ea-8418-0c796b14ab95.png">

* Line graph
```r
plot(type="l", lwd=LINE WIDTH, lty=LINE TYPE)
```
<img src="https://user-images.githubusercontent.com/46131688/72050283-17c69f00-3304-11ea-95e4-24c6e41751b7.png">

#### Correlation analysis
* Correlation
```r
cor(data1, data2)
```
<img src="https://user-images.githubusercontent.com/46131688/72047986-1b0b5c00-32ff-11ea-805e-776f1fc62a2a.png">

* Regression
```r
res <- lm(dist~speed, data)         # regression line derivation
abline(res)                         # regression
```
<img src="https://user-images.githubusercontent.com/46131688/72048100-61f95180-32ff-11ea-85ee-4962904a9c63.png">
