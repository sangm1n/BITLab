# Data processing
### This is practice for data processing
***
#### What is Data processing ?
> it is to refine and process the initially acquired to obtain the data suitable for analysis.

* Missing value 
> occurs when data cannot be obtained while saving and collecting data 
```r
is.na(data)               # check for NA
complete.cases(data)      # find the index value of complete rows
```
* Outlier
> values outside the distribution range of data that are considered normal
```r
boxplot.stats(data)$out   # check for outlier
```
* Sort
> the process of rearranging data in order of size based on given criteria
```r
sort(data)                # ascending order
sort(data, decreasing=T)  # descending order

order(data)               # umbering starts with small values based on the size of the value
```
* Split and subset
> <b>split</b> : splitting a dataset into multiple datasets based on the values in a column
```r
sp <- split(data, data$COLUMN)
summary(sp)               # check for summary information
```
> <b>subset</b> : extracting rows that meet the criteria from the dataset
```r
subset(data, select="COLUMN", CONDITION)
```
* Aggregation and merge
> <b>aggregation</b> : calculating sums or averages for a group of data in two-dimensional data
```r
aggregate(data, by=list(data$BASE), FUN)
```
> <b>merge</b> : use when associated information is scattered in multiple files
```r
merge(X, Y, by=c("BASE"))  # X, Y is data frame
merge(X, Y, all.x=T)       # show all rows of the first dataset
merge(X, Y, all.y=T)       # show all rows of the second dataset
merge(X, Y, all=T)         # show all rows of the both dataset
```
