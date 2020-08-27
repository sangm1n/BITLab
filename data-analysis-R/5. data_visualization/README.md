# Data visualization
### This is practice for data visualization
***
#### What is Data visualization ?
> Representing numerical data in the form of graphs or figures.

* Treemap
> it is composed of square tiles and shows the size of data by the size and color of each tile
```r
library(treemap)                    # import treemap package
data(GNI2014)                       # import data
treemap(GNI2014,
        vSize="population",         # size of tile
        vColor="GNI")               # size of color
```
<img src="https://user-images.githubusercontent.com/46131688/73436545-0e25d980-438e-11ea-8fd4-510aad25058e.png">

* Bubble chart
> visualization method to display information as bubble size over scatter plot
```r
st <- data.frame(state.x77)
symbols(st$Illiteracy, st$Murder,   # (x, y)
        circles=st&Population,      # radius
        inches=0.3,                 # size of circle
        fg=COLOR, bg=COLOR)         
```
<img src="https://user-images.githubusercontent.com/46131688/73436615-34e41000-438e-11ea-8db8-73aa659c84d7.png">

* Mosaic plot
> display the proportions of each variable's group by area for multivariate categorical data
```r
mosaicplot(~X+Y, data=mtcars, color=T)
```
<img src="https://user-images.githubusercontent.com/46131688/73436672-504f1b00-438e-11ea-8755-dccdfe149e67.png">


* ggplot package
> data visualization package for creating complex and colorful graphs
```r
library(ggplot2)
```
* ggplot example<br><br>
<b>bar graph</b>
<img src="https://user-images.githubusercontent.com/46131688/73436773-783e7e80-438e-11ea-9489-75b7576a29e7.png">
<b>histogram</b>
<img src="https://user-images.githubusercontent.com/46131688/73436825-8e4c3f00-438e-11ea-8e6c-ad817ab670c3.png">
<b>scatter plot</b>
<img src="https://user-images.githubusercontent.com/46131688/73437006-e4b97d80-438e-11ea-8310-11b4b98ebccc.png">
<b>box plot</b>
<img src="https://user-images.githubusercontent.com/46131688/73437125-1df1ed80-438f-11ea-8f52-a7d4bdb6fa27.png">

