# data visualization practice in R by sangmin

# ggplot practice
# bar graph using ggplot
library(ggplot2)
ggplot(mtcars, aes(x=gear)) + 
  geom_bar(stat="count", width=0.7, fill="pink") + 
  ggtitle("기어의 수") +
  theme(plot.title=element_text(size=25, face="bold", color="red")) +
  labs(x="기어의 수", y="빈도수")

ggplot(mtcars, aes(x=cyl)) +
  geom_bar(width=0.7, fill="green") +
  ggtitle("실린더의 수") +
  theme(plot.title=element_text(size=25, face="bold", color="darkgreen")) +
  labs(x="실린더 수", y="개수")


# histogram using ggplot
ggplot(mtcars, aes(x=mpg)) +
  geom_histogram(binwidth=5.0, color="white", fill="skyblue") +
  ggtitle("연비") +
  theme(plot.title=element_text(size=25, face="bold", color="blue")) +
  labs(x="연비", y="")

ggplot(trees, aes(x=Girth)) +
  geom_histogram(binwidth=3.0, color="white", fill="steelblue") +
  ggtitle("나무 둘레") +
  theme(plot.title=element_text(size=25, face="bold", color="blue")) +
  labs(x="나무 둘레", y="수")


# scatter plot using ggplot
ggplot(mtcars, aes(x=mpg, y=wt, color=as.factor(gear))) + 
  geom_point(size=4) +
  ggtitle("연비-중량") +
  theme(plot.title=element_text(size=25, face="bold", color="grey"))


# box plot using ggplot
ggplot(mtcars, aes(y=mpg, fill=as.factor(cyl))) +
  geom_boxplot() +
  ggtitle("실린더 수에 따른 연비") +
  theme(plot.title=element_text(size=25, face="bold", color="navy"))


