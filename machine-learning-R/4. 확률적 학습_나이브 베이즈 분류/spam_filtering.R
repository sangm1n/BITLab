setwd("C:/Users/sangmin/Desktop/github/R을_활용한_머신러닝/4. 확률적 학습_나이브 베이즈 분류")
library(tm)
library(SnowballC)
library(wordcloud)
library(e1071)
library(gmodels)


sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)
str(sms_raw)

sms_raw$type <- factor(sms_raw$type)
str(sms_raw$type)
table(sms_raw$type)

sms_corpus <- VCorpus(VectorSource(sms_raw$text))
print(sms_corpus)

sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)

lapply(sms_corpus[1:3], as.character)
lapply(sms_corpus_clean[1:3], as.character)

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
    tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE,
    removePunctuation = TRUE, stemming = TRUE))

sms_dtm
sms_dtm2

train_idx <- 1:4169
test_idx <- 4170:5559

sms_dtm_train <- sms_dtm[train_idx, ]
sms_dtm_test <- sms_dtm[test_idx, ]
sms_train_labels <- sms_raw[train_idx, ]$type
sms_test_labels <- sms_raw[test_idx, ]$type

prop.table(table(sms_train_labels))
prop.table(table(sms_test_labels))

pal2 <- brewer.pal(8, "Dark2")

wordcloud(sms_corpus_clean, min.freq=50, random.order=FALSE, colors=pal2)

spam <- subset(sms_raw, type=="spam")
ham <- subset(sms_raw, type=="ham")
wordcloud(spam$text, max.words=40, scale=c(3, 0.5), colors=pal2)
wordcloud(ham$text, max.words=40, scale=c(3, 0.5), colors=pal2)

sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
str(sms_freq_words)

sms_dtm_freq_train <- sms_dtm_train[, sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[, sms_freq_words]

convert_counts <- function(x) {
    x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN=2, convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN=2, convert_counts)

sms_classifier <- naiveBayes(sms_train, sms_train_labels)
sms_test_pred <- predict(sms_classifier, sms_test)
CrossTable(sms_test_pred, sms_test_labels,
           prop.chisq=FALSE, prop.c=FALSE,
           prop.r=FALSE, dnn=c("predicted", "actual"))

sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace=1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq=FALSE, prop.c=FALSE,
           prop.r=FALSE, dnn=c("predicted", "actual"))
