나이브 베이즈 알고리즘을 이용한 스팸 필터링
================
*이상민*

-----

## 나이브 베이즈 알고리즘으로 휴대폰 스팸 필터링

나이브 베이즈는 이메일 스팸 필터링에 성공적으로 사용되어 왔기 때문에 SMS 스팸에도 적용될 수 있을 것이다. 하지만 이메일
스팸과 비교해서 SMS 스팸은 자동화 필터에 대한 어려움이 있다. 문자 길이의 제한이 작은 휴대폰 키보드와 합쳐지면
많은 사람이 SMS 속기 형태의 용어를 쓸 수 있고, 이로 인해 스팸인지 아닌지의 구분이 더욱 모호해졌다.

-----

### 1단계 : 데이터 수집

<http://www.dt.fee.unicamp.br/~tiago/smsspamcollection/>에 있는 SMS 스팸 모음을
조정한 데이터를 활용한다.  
이 데이터셋에는 SMS 메시지의 텍스트와 원치 않는 메시지인지를 나타내는 레이블이 함께 들어있다. 정크 메시지는 스팸으로 레이블된
반면 합법적인 메시지는 햄으로 레이블된다.

-----

### 2단계 : 데이터 탐색좌 준비

``` r
sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)
str(sms_raw)
```

    ## 'data.frame':    5559 obs. of  2 variables:
    ##  $ type: chr  "ham" "ham" "ham" "spam" ...
    ##  $ text: chr  "Hope you are having a good week. Just checking in" "K..give back my thanks." "Am also doing in cbe only. But have to pay." "complimentary 4 STAR Ibiza Holiday or ￡10,000 cash needs your URGENT collection. 09066364349 NOW from Landline"| __truncated__ ...

``` r
sms_raw$type <- factor(sms_raw$type)
str(sms_raw$type)
```

    ##  Factor w/ 2 levels "ham","spam": 1 1 1 2 2 1 1 1 2 1 ...

``` r
table(sms_raw$type)
```

    ## 
    ##  ham spam 
    ## 4812  747

#### 데이터 준비 : 텍스트 데이터 정리 및 표준화

텍스트 데이터 처리의 첫 단계는 텍스트 문서의 모음인 코퍼스(corpus)를 생성하는 것이다. VCorpus() 함수는 휘발성
코퍼스를 참조하고, PCorpus() 함수는 영구적인 코퍼스에 접근하고자 사용한다.

``` r
library(tm)
library(SnowballC)

sms_corpus <- VCorpus(VectorSource(sms_raw$text))
print(sms_corpus)
```

    ## <<VCorpus>>
    ## Metadata:  corpus specific: 0, document level (indexed): 0
    ## Content:  documents: 5559

소문자만 사용하도록 메시지를 표준화시킨다.

``` r
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
```

SMS 메시지에서 숫자를 제거한다. 어떤 숫자는 유용한 정보를 제공해주겠지만 대부분 개별 발신자에게 고유한 것일 수 있어서 전체
메시지에 유용한 패턴을 제공해주지는 않을 것 같다.

``` r
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)
```

불용어를 제거해준다. 불용어는 to, and, but, or와 같은 채우기 단어이다.

``` r
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())
```

문자 메시지에서 구두점을 제거한다.

``` r
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)
```

다른 텍스트 데이터에 대한 일반적인 표준화인 형태소 분석 과정에서 단어를 어근 형태로 줄인다.

``` r
wordStem(c("learn", "learned", "learning", "learns"))
```

    ## [1] "learn" "learn" "learn" "learn"

``` r
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
```

추가 여백을 제거한다.

``` r
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)
```

정리 전 SMS 메시지와 정리 후 SMS 메시지를 비교하면 다음과 같다.

``` r
lapply(sms_corpus[1:3], as.character)
```

    ## $`1`
    ## [1] "Hope you are having a good week. Just checking in"
    ## 
    ## $`2`
    ## [1] "K..give back my thanks."
    ## 
    ## $`3`
    ## [1] "Am also doing in cbe only. But have to pay."

``` r
lapply(sms_corpus_clean[1:3], as.character)
```

    ## $`1`
    ## [1] "hope good week just check"
    ## 
    ## $`2`
    ## [1] "kgive back thank"
    ## 
    ## $`3`
    ## [1] "also cbe pay"

#### 데이터 준비 : 텍스트 문서를 단어로 나누기

메시지를 토큰과 과정을 통해 개별 용어로 나눈다. 토큰은 텍스트 문자열의 한 요소로, 이 경우 토큰은 단어다.
DocumentTermMatrix() 함수는 코퍼스를 가져와 문서 용어 행렬(DTM)이라고 하는 데이터 구조를 만든다. 이때 행은
문서(SMS 메시지), 열은 용어(단어)를 나타낸다.

``` r
sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
    tolower = TRUE, removeNumbers = TRUE, stopwords = TRUE,
    removePunctuation = TRUE, stemming = TRUE))

sms_dtm
```

    ## <<DocumentTermMatrix (documents: 5559, terms: 6542)>>
    ## Non-/sparse entries: 42112/36324866
    ## Sparsity           : 100%
    ## Maximal term length: 40
    ## Weighting          : term frequency (tf)

``` r
sms_dtm2
```

    ## <<DocumentTermMatrix (documents: 5559, terms: 6940)>>
    ## Non-/sparse entries: 43185/38536275
    ## Sparsity           : 100%
    ## Maximal term length: 40
    ## Weighting          : term frequency (tf)

sms\_dtm2는 앞에서 했던 것과 같은 순서로 SMS 코퍼스에 동일한 사전 처리 단계를 적용한다. 하지만 행렬의 용어 개수가
약간 다른 것을 알 수 있는데, 이는 사전 처리 단계 순서에서 약간의 차이가 있기 때문이다.

#### 데이터 준비 : 훈련 및 테스트 데이터셋 생성

분석을 위해 준비된 데이터를 훈련 데이터셋과 테스트 데이터셋으로 분리할 필요가 있다. 분류기가 테스트 데이터셋의 내용을 보지
못하게 할 필요가 있지만, 데이터가 정리되고 처리된 이후에 분할이 일어나는 것이 중요하다. 따라서 훈련 데이터셋과
테스트 데이터셋 모두에 대해 정확히 동일한 준비 단계가 필요하다.

``` r
train_idx <- 1:4169
test_idx <- 4170:5559

sms_dtm_train <- sms_dtm[train_idx, ]
sms_dtm_test <- sms_dtm[test_idx, ]
sms_train_labels <- sms_raw[train_idx, ]$type
sms_test_labels <- sms_raw[test_idx, ]$type
```

이 부분집합이 SMS 데이터의 전체 집합을 대표하는지 확인해보면 훈련 데이터와 테스트 데이터 모두 13% 스팸을 포함하고 있다는
것을 알 수 있다. 이는 스팸 메시지가 두 데이터셋에 균등하게 분할됐음을 보여준다.

``` r
prop.table(table(sms_train_labels))
```

    ## sms_train_labels
    ##       ham      spam 
    ## 0.8647158 0.1352842

``` r
prop.table(table(sms_test_labels))
```

    ## sms_test_labels
    ##       ham      spam 
    ## 0.8683453 0.1316547

#### 텍스트 데이터 시각화 : 워드 클라우드

``` r
library(wordcloud)
pal2 <- brewer.pal(8, "Dark2")

wordcloud(sms_corpus_clean, min.freq=50, random.order=FALSE, colors=pal2)
```

![](spam_filtering_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

``` r
spam <- subset(sms_raw, type=="spam")
ham <- subset(sms_raw, type=="ham")
wordcloud(spam$text, max.words=40, scale=c(3, 0.5), colors=pal2)
```

![](spam_filtering_files/figure-gfm/unnamed-chunk-13-2.png)<!-- -->

``` r
wordcloud(ham$text, max.words=40, scale=c(3, 0.5), colors=pal2)
```

![](spam_filtering_files/figure-gfm/unnamed-chunk-13-3.png)<!-- --> 스팸
메시지는 urgent, free, mobile, claim과 같은 단어를 포함한다. 정상적인 메시지에는 can,
sorry, need, time과 같은 단어를 사용한다. 이 극명한 차이는 나이브 베이즈 모델이 클래스를 구별하는 강력한 핵심
단어를 갖게 될 것을 말해준다.

#### 데이터 준비 : 자주 사용하는 단어의 지시자 특성 생성

희소 행렬을 나이브 베이즈 분류기를 훈련시키고자 사용하는 데이터 구조로 변환한다. 현재 희소 행렬은 6,500개 이상의 특징을
포함한다. 이러한 모든 특징이 분류에 유용한 것은 아닐 것이기 때문에 특징의 개수를 줄이고자 한다. 다섯 개 이하의
메시지에 나타나거나 훈련 데이터에서 약 0.1% 레코드보다 작게 나타나는 단어를 제거한다.

``` r
sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
str(sms_freq_words)
```

    ##  chr [1:1137] "￡wk" "abiola" "abl" "abt" "accept" "access" "account" ...

``` r
sms_dtm_freq_train <- sms_dtm_train[, sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[, sms_freq_words]

convert_counts <- function(x) {
    x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN=2, convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN=2, convert_counts)
```

-----

### 3단계 : 데이터로 모델 훈련

``` r
library(e1071)

sms_classifier <- naiveBayes(sms_train, sms_train_labels)
```

-----

### 4단계 : 모델 성능 평가

``` r
library(gmodels)

sms_test_pred <- predict(sms_classifier, sms_test)

CrossTable(sms_test_pred, sms_test_labels,
           prop.chisq=FALSE, prop.c=FALSE,
           prop.r=FALSE, dnn=c("predicted", "actual"))
```

    ## 
    ##  
    ##    Cell Contents
    ## |-------------------------|
    ## |                       N |
    ## |         N / Table Total |
    ## |-------------------------|
    ## 
    ##  
    ## Total Observations in Table:  1390 
    ## 
    ##  
    ##              | actual 
    ##    predicted |       ham |      spam | Row Total | 
    ## -------------|-----------|-----------|-----------|
    ##          ham |      1201 |        30 |      1231 | 
    ##              |     0.864 |     0.022 |           | 
    ## -------------|-----------|-----------|-----------|
    ##         spam |         6 |       153 |       159 | 
    ##              |     0.004 |     0.110 |           | 
    ## -------------|-----------|-----------|-----------|
    ## Column Total |      1207 |       183 |      1390 | 
    ## -------------|-----------|-----------|-----------|
    ## 
    ## 

-----

### 5단계 : 모델 성능 개선

이전과 같이 나이브 베이즈 모델을 구축하지만, 이번에는 laplace = 1로 설정한다.

``` r
sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace=1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)

CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq=FALSE, prop.c=FALSE,
           prop.r=FALSE, dnn=c("predicted", "actual"))
```

    ## 
    ##  
    ##    Cell Contents
    ## |-------------------------|
    ## |                       N |
    ## |         N / Table Total |
    ## |-------------------------|
    ## 
    ##  
    ## Total Observations in Table:  1390 
    ## 
    ##  
    ##              | actual 
    ##    predicted |       ham |      spam | Row Total | 
    ## -------------|-----------|-----------|-----------|
    ##          ham |      1202 |        28 |      1230 | 
    ##              |     0.865 |     0.020 |           | 
    ## -------------|-----------|-----------|-----------|
    ##         spam |         5 |       155 |       160 | 
    ##              |     0.004 |     0.112 |           | 
    ## -------------|-----------|-----------|-----------|
    ## Column Total |      1207 |       183 |      1390 | 
    ## -------------|-----------|-----------|-----------|
    ## 
    ##
