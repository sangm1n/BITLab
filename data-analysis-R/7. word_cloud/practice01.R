# word cloud practice in R by sangmin

# set environments and packages
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_241")

library(RColorBrewer)
library(wordcloud)
library(KoNLP)

setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\7. word_cloud")


# 20th national assembly speech
text1 <- readLines("ex_10-1.txt", encoding="UTF-8")
buildDictionary(ext_dic="woorimalsam")
pal2 <- brewer.pal(8, "Dark2")

noun <- sapply(text1, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)
noun2 <- noun2[nchar(noun2) > 1]

wordcount <- table(noun2)
wordcloud(names(wordcount), freq=wordcount,
          scale=c(6,0.7), min.freq=3,
          random.order=F, rot.per=.1, colors=pal2)


text2 <- readLines("ex_10-2.txt", encoding="UTF-8")
noun <- sapply(text2, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)
noun2 <- noun2[nchar(noun2) > 1]

wordcount <- table(noun2)
wordcloud(names(wordcount), freq=wordcount,
          scale=c(6,0.7), min.freq=3,
          random.order=F, rot.per=.1, colors=pal2)


text3 <- readLines("ex_10-3.txt", encoding="UTF-8")
noun <- sapply(text3, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)
noun2 <- noun2[nchar(noun2) > 1]

wordcount <- table(noun2)
wordcloud(names(wordcount), freq=wordcount,
          scale=c(6,0.7), min.freq=3,
          random.order=F, rot.per=.1, colors=pal2)