C5.0 의사 결정 트리를 이용한 위험 은행 대출 식별
================
*이상민*

-----

## C5.0 의사 결정 트리를 이용한 위험 은행 대출 식별

의사 결정 트리는 높은 정확성과 통계 모델을 표현하는 능력 때문에 은행 업계에서 널리 사용되고 있다. 자동화된 신용 평가 모델을
이용해 신용카드 발송이나 실시간 온라인 승인 절차를 구현할 수도 있다. 또한 기관의 재정적 손실을 야기하는 오류를 최소화하고자
모델의 결과가 어떻게 조정될 수 있는지 살펴본다.

-----

### 1단계 : 데이터 수집

과거 은행 대출에 대한 대량 데이터, 대출의 채무 불이행 여부, 신청자에 대한 정보를 입수해야 한다.
<http://archive.ics.uci.edu/ml>에 있는 데이터셋에는 독일의 한 신용기관에서 얻은 대출 정보가 들어있다.
신용 데이터셋은 1,000개의 대출 예시 및 대출과 대출 신청자의 특성을 나타내는 일련의 수치 특징과 명목 특징을 포함하고
있다. 클래스 변수는 대출이 채무 불이행으로 갔는지 여부를 나타낸다.

-----

### 2단계 : 데이터 탐색과 준비

``` r
credit <- read.csv("credit.csv")
str(credit)
```

    ## 'data.frame':    1000 obs. of  17 variables:
    ##  $ checking_balance    : Factor w/ 4 levels "< 0 DM","> 200 DM",..: 1 3 4 1 1 4 4 3 4 3 ...
    ##  $ months_loan_duration: int  6 48 12 42 24 36 24 36 12 30 ...
    ##  $ credit_history      : Factor w/ 5 levels "critical","good",..: 1 2 1 2 4 2 2 2 2 1 ...
    ##  $ purpose             : Factor w/ 6 levels "business","car",..: 5 5 4 5 2 4 5 2 5 2 ...
    ##  $ amount              : int  1169 5951 2096 7882 4870 9055 2835 6948 3059 5234 ...
    ##  $ savings_balance     : Factor w/ 5 levels "< 100 DM","> 1000 DM",..: 5 1 1 1 1 5 4 1 2 1 ...
    ##  $ employment_duration : Factor w/ 5 levels "< 1 year","> 7 years",..: 2 3 4 4 3 3 2 3 4 5 ...
    ##  $ percent_of_income   : int  4 2 2 2 3 2 3 2 2 4 ...
    ##  $ years_at_residence  : int  4 2 3 4 4 4 4 2 4 2 ...
    ##  $ age                 : int  67 22 49 45 53 35 53 35 61 28 ...
    ##  $ other_credit        : Factor w/ 3 levels "bank","none",..: 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ housing             : Factor w/ 3 levels "other","own",..: 2 2 2 1 1 1 2 3 2 2 ...
    ##  $ existing_loans_count: int  2 1 1 1 2 1 1 1 1 2 ...
    ##  $ job                 : Factor w/ 4 levels "management","skilled",..: 2 2 4 2 2 4 2 1 4 1 ...
    ##  $ dependents          : int  1 1 2 2 2 2 1 1 1 1 ...
    ##  $ phone               : Factor w/ 2 levels "no","yes": 2 1 1 1 1 2 1 2 1 1 ...
    ##  $ default             : Factor w/ 2 levels "no","yes": 1 2 1 1 2 1 1 1 1 2 ...

수표 계좌 잔고와 저축 계좌 잔고는 대출 채무 불이행 상태의 중요한 예측 변수가 될 수 있다. 대출 데이터가 독일에서 입수됐기
때문에 통화는 DM(독일 마르크)이다.

``` r
table(credit$checking_balance)
```

    ## 
    ##     < 0 DM   > 200 DM 1 - 200 DM    unknown 
    ##        274         63        269        394

``` r
table(credit$savings_balance)
```

    ## 
    ##      < 100 DM     > 1000 DM  100 - 500 DM 500 - 1000 DM       unknown 
    ##           603            48           103            63           183

대출금은 4개월에서 72개월의 기한에 걸쳐 250DM에서 18,420DM까지의 범위에 있다.

``` r
summary(credit$months_loan_duration)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     4.0    12.0    18.0    20.9    24.0    72.0

``` r
summary(credit$amount)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     250    1366    2320    3271    3972   18424

default 벡터는 대출 신청자가 합의된 금액을 상환했는지 아니면 채무 불이행이 됐는지를 나타낸다. 이 데이터셋에서 대출의 전체
30%는 채무 불이행으로 갔다.

``` r
table(credit$default)
```

    ## 
    ##  no yes 
    ## 700 300

#### 데이터 준비 : 랜덤한 훈련 및 테스트 데이터셋 생성

훈련을 위해 데이터의 90%를 사용하고 테스트를 위해 10%를 사용한다. 여기서는 랜덤 샘플을 통해 레코드의 부분집합을 무작위로
선택하여 실행한다.

``` r
set.seed(1234)
train_sample <- sample(1000, 900)

credit_train <- credit[train_sample, ]
credit_test <- credit[-train_sample, ]
```

랜덤화 과정이 잘 됐다면 각 데이터셋은 약 30%의 채무 불이행 대출을 가진다.

``` r
prop.table(table(credit_train$default))
```

    ## 
    ##        no       yes 
    ## 0.6922222 0.3077778

``` r
prop.table(table(credit_test$default))
```

    ## 
    ##   no  yes 
    ## 0.77 0.23

-----

### 3단계 : 데이터로 모델 훈련

``` r
library(C50)

credit_model <- C5.0(credit_train[-17], credit_train$default)
```

-----

### 4단계 : 모델 성능 평가

테스트 집합의 100개 대출 신청 레코드 중에서 64개는 채무 불이행되지 않았고 8개는 채무 불이행됐음을 모델이 정확하게 예측해서
정확도는 72%이고 오류율은 28%이다. 모델이 테스트 데이텅에서 실제 23개의 대출 채무 불이행 중 단지 8개만 정확하게
예측했다는 점을 주목하면, 이런 유형의 오류는 각각의 채무 불이행에 대해 은행이 손해를 보기 때문에 잠재적으로
비용이 매우 많이 드는 실수다.

``` r
library(gmodels)

credit_pred <- predict(credit_model, credit_test)
CrossTable(credit_test$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))
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
    ## Total Observations in Table:  100 
    ## 
    ##  
    ##                | predicted default 
    ## actual default |        no |       yes | Row Total | 
    ## ---------------|-----------|-----------|-----------|
    ##             no |        64 |        13 |        77 | 
    ##                |     0.640 |     0.130 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##            yes |        15 |         8 |        23 | 
    ##                |     0.150 |     0.080 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##   Column Total |        79 |        21 |       100 | 
    ## ---------------|-----------|-----------|-----------|
    ## 
    ## 

-----

### 5단계 : 모델 성능 개선

#### 의사 결정 트리의 정확도 향상

C5.0 알고리즘이 C4.5 알고리즘을 개선한 방법 중 하나는 적응형 부스팅을 추가한 것이다. 부스팅은 성능이 약한 여러 학습자를
결합함으로써 어느 하나의 학습자 혼자보다 훨씬 강한 팀을 만들 수 있다는 생각에 뿌리를 두고 있다.  
trials 파라미터를 이용해 부스팅을 추가한다. trials 파라미터는 상한성을 설정하는데, 추가 시행이 정확도를 향상시키지
못할 것으로 보이면 알고리즘은 더 이상 트리를 추가하지 않는다.

``` r
credit_boost10 <- C5.0(credit_train[-17], credit_train$default, trials=10)
credit_boost10
```

    ## 
    ## Call:
    ## C5.0.default(x = credit_train[-17], y = credit_train$default, trials = 10)
    ## 
    ## Classification Tree
    ## Number of samples: 900 
    ## Number of predictors: 16 
    ## 
    ## Number of boosting iterations: 10 
    ## Average tree size: 48.2 
    ## 
    ## Non-standard options: attempt to group attributes

전체 오류율이 부스팅 이전 27%에서 부스팅 모델의 22%로 줄었다. 한편 실제 23개의 대출 채무 불이행 중 단지
11개(48%)만 정확하게 예측했다는 점에 주목해야 한다.

``` r
credit_boost_pred10 <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))
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
    ## Total Observations in Table:  100 
    ## 
    ##  
    ##                | predicted default 
    ## actual default |        no |       yes | Row Total | 
    ## ---------------|-----------|-----------|-----------|
    ##             no |        67 |        10 |        77 | 
    ##                |     0.670 |     0.100 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##            yes |        12 |        11 |        23 | 
    ##                |     0.120 |     0.110 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##   Column Total |        79 |        21 |       100 | 
    ## ---------------|-----------|-----------|-----------|
    ## 
    ## 

#### 다른 것보다 더 비싼 실수

C5.0 알고리즘은 트리가 좀 더 비용이 많이 드는 실수를 하지 못하게 여러 오류 유형에 페널티를 줄 수 있다. 페널티는 비용
행렬에 지정되며, 각 오류가 다른 예측에 비해 몇 배나 비용이 많이 드는지를 명시한다.

``` r
matrix_dimensions <- list(c("no", "yes"), c("no", "yes"))
names(matrix_dimensions) <- c("predicted", "actual")

matrix_dimensions
```

    ## $predicted
    ## [1] "no"  "yes"
    ## 
    ## $actual
    ## [1] "no"  "yes"

그 후 다양한 오류 유형에 페널티를 주고자 네 개의 값을 제공해 행렬을 채운다. R은 행렬을 채울 때 열 단위로 채우기 때문에
특정 순서대로 값을 제공해야 한다.

1.  predicted no, actual no
2.  predicted no, actual yes
3.  predicted yes, actual no
4.  predicted yes, actual yes

은행은 대출의 채무 불이행으로 놓친 기회의 4배만큼 비용이 드는 것으로 생각한다고 가정한다면, 페널티 값은 다음과 같이 정의될 수
있다. 알고리즘 분류기가 no나 yes를 정확히 분류할 때에는 비용이 할당되지 않지만, 거짓 부정(FN)은 거짓 긍정(FP)의
비용 1에 대해 비용 4를 갖는다.

``` r
error_cost <- matrix(c(0, 1, 4, 0), nrow=2, dimnames=matrix_dimensions)
error_cost
```

    ##          actual
    ## predicted no yes
    ##       no   0   4
    ##       yes  1   0

``` r
credit_cost <- C5.0(credit_train[-17], credit_train$default,
                    costs = error_cost)
```

부스팅 모델과 비교하면 비용 행렬의 오류율은 39%로 오히려 더 증가했다. 하지만 실수의 유형이 매우 다르다. 이 모델의 경우
실제 채무 불이행의 18/23=78%가 채무 불이행한 것으로 정확히 예측했다. 거짓 긍정을 증가시킨 대가로 거짓 부정을
줄인 이 거래는 비용 추정이 정확하다면 수용 가능하다.

``` r
credit_cost_pred <- predict(credit_cost, credit_test)
CrossTable(credit_test$default, credit_cost_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c("actual default", "predicted default"))
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
    ## Total Observations in Table:  100 
    ## 
    ##  
    ##                | predicted default 
    ## actual default |        no |       yes | Row Total | 
    ## ---------------|-----------|-----------|-----------|
    ##             no |        43 |        34 |        77 | 
    ##                |     0.430 |     0.340 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##            yes |         5 |        18 |        23 | 
    ##                |     0.050 |     0.180 |           | 
    ## ---------------|-----------|-----------|-----------|
    ##   Column Total |        48 |        52 |       100 | 
    ## ---------------|-----------|-----------|-----------|
    ## 
    ##
