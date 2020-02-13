# word cloud practice in R by sangmin

# set environments and packages
Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_241")

library(RColorBrewer)
library(wordcloud)
library(KoNLP)

setwd("C:\\Users\\sangmin\\Desktop\\code\\RStudio\\R_practice\\7. word_cloud")


# Steve Jobs Stanford Univ. graduation speech
text <- readLines("ex_10-4.txt", encoding="UTF-8")
buildDictionary(ext_dic="woorimalsam")
pal2 <- brewer.pal(8, "Dark2")

noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)
noun2 <- noun2[nchar(noun2) > 1]

wordcount <- table(noun2)
wordcloud(names(wordcount), freq=wordcount,
          scale=c(6,0.7), min.freq=3,
          random.order=F, rot.per=.1, colors=pal2)


# Obama election speech
text <- readLines("ex_10-5.txt", encoding="UTF-8")
buildDictionary(ext_dic="woorimalsam")
pal2 <- brewer.pal(8, "Dark2")

noun <- sapply(text, extractNoun, USE.NAMES=F)
noun2 <- unlist(noun)
noun2 <- noun2[nchar(noun2) > 1]

wordcount <- table(noun2)
wordcloud(names(wordcount), freq=wordcount,
          scale=c(6,0.7), min.freq=3,
          random.order=F, rot.per=.1, colors=pal2)