library(ggplot2)
library(dplyr)
library(gridExtra)
library(DMwR)

setwd("C:/Users/sangmin/Desktop/Kaggle/kaggle-titanic/타이타닉 데이터 분석")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

str(train)
str(test)

test$Survived <- NA
train$Survived <- factor(train$Survived, levels=c(0, 1),
                         labels=c("No", "Yes"))

total <- rbind(train, test)
str(total)


## 결측값 처리
NA_num <- t(colSums(is.na(total)))
NA_prob <- t(colSums(is.na(total))) / nrow(total)
rbind(NA_num, NA_prob)

age_sum <- total[complete.cases(total$Age), "Age"]
age_mean <- sum(age_sum) / length(age_sum)
fare_sum <- total[complete.cases(total$Fare), "Fare"]
fare_mean <- sum(fare_sum) / length(fare_sum)

for(i in 1:nrow(total)) {
    if (is.na(total$Age[i]) == TRUE) {
        total$Age[i] <- age_mean
    } else if (is.na(total$Fare[i]) == TRUE) {
        total$Fare[i] <- fare_mean
    }
}

colSums(is.na(total))


## PassengerId
length(unique(total$PassengerId)) == length(total$PassengerId)


## Survived
table(total$Survived)

ggplot(train) +
    geom_bar(aes(x=Survived, fill=Survived)) +
    ggtitle("number of passengers survived") +
    theme(plot.title=element_text(size=20, face="bold"))


## Pclass
str(total$Pclass)

total$Pclass <- factor(total$Pclass, levels=c(1, 2, 3),
                       labels=c("1st", "2nd", "3rd"))

ggplot(total) +
    geom_bar(aes(x=Pclass, fill=Pclass)) +
    ggtitle("number of passengers by seat class") +
    theme(plot.title=element_text(size=20, face="bold"))

with(train, table(Survived, Pclass))
with(train, chisq.test(Survived, Pclass))


## Sex
table(total$Sex)

ggplot(total) +
    geom_bar(aes(x=Sex, fill=Sex)) +
    ggtitle("number of passengers by sex") +
    theme(plot.title=element_text(size=20, face="bold"))

with(train, table(Survived, Sex))
with(train, chisq.test(Survived, Pclass))


## Age
mean(total$Age)


age_10 <- ggplot(total) +
    geom_histogram(aes(x=Age), binwidth=10) +
    ggtitle("bin = 10")
age_1 <- ggplot(total) + 
    geom_histogram(aes(x=Age), binwidth=1) +
    ggtitle("bin = 1")

grid.arrange(age_10, age_1, ncol=2)

total[which(total$Age == mean(total$Age)), "Age"] <- NA

knn <- knnImputation(total)
total$Age <- knn$Age

knn_age_10 <- ggplot(total) +
    geom_histogram(aes(x=Age), binwidth=10) +
    ggtitle("bin = 10")
knn_age_1 <- ggplot(total) + 
    geom_histogram(aes(x=Age), binwidth=1) +
    ggtitle("bin = 1")

grid.arrange(knn_age_10, knn_age_1, ncol=2)

dt <- total[1:nrow(train), ]

max(dt$Age)
age_group <- cut(dt$Age, c(seq(0, 80, 5)))

surv <- as.numeric(dt$Survived) - 1
df <- data.frame(age_group, surv)

df_surv_cnt <- aggregate(df$surv, by=list(age_group), sum)
df_age_cnt <- aggregate(df$surv, by=list(age_group), length)

df <- cbind(df_surv_cnt, df_age_cnt$x)
colnames(df) <- c("range", "survived", "count")
df$ratio <- with(df, survived / count) 

ggplot(df, aes(x=range, y=ratio)) +
    geom_bar(stat="identity", width=0.7, fill="purple") +
    ggtitle("ratio of passengers by age group") +
    theme(plot.title=element_text(size=20, face="bold"))

rbind(head(df, 3), tail(df, 3))


## Cabin
head(table(total$Cabin))
sum(total$Cabin == "")


## Embarked
table(total$Embarked)
str(total$Embarked)

total[which(total$Embarked == ""), "Embarked"] <- "S"

total$Embarked <- as.factor(as.character(total$Embarked))
str(total$Embarked)

ggplot(total) +
    geom_bar(aes(x=Embarked, fill=Embarked)) +
    ggtitle("number of passengers by embarked") +
    theme(plot.title=element_text(size=20, face="bold")) 

with(total, table(Survived, Embarked))
with(total, chisq.test(Survived, Embarked))
