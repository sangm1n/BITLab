k-NN 알고리즘으로 유방암 진단
================
*이상민*

-----

## k-NN 알고리즘으로 유방암 진단

비정상 유방 종양이 포함된 여성의 조직 검사 세포 측정치에 k-NN 알고리즘을 적용해 머신러닝이 암을 발견하는 데 얼마나 유용한지
살펴본다.

-----

### 1단계 : 데이터 수집

<http://archive.ics.uci.edu/ml>에 있는 위스콘신 유방암 진단 데이터셋을 활용한다.  
유방암 데이터에는 569개의 암 조직 검사 예기다 들어있으며, 각 예시는 32개의 특징을 갖는다. 32개의 특징은 식별 번호와 암
진단, 30개의 수치 측정치로 이루어져 있다. 진단은 악성을 나타내는 ’M’이나 양성을 나타내는 ’B’로 코드화되어 있다.

-----

### 2단계 : 데이터 탐색과 준비

``` r
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)
```

    ## 'data.frame':    569 obs. of  32 variables:
    ##  $ id               : int  87139402 8910251 905520 868871 9012568 906539 925291 87880 862989 89827 ...
    ##  $ diagnosis        : chr  "B" "B" "B" "B" ...
    ##  $ radius_mean      : num  12.3 10.6 11 11.3 15.2 ...
    ##  $ texture_mean     : num  12.4 18.9 16.8 13.4 13.2 ...
    ##  $ perimeter_mean   : num  78.8 69.3 70.9 73 97.7 ...
    ##  $ area_mean        : num  464 346 373 385 712 ...
    ##  $ smoothness_mean  : num  0.1028 0.0969 0.1077 0.1164 0.0796 ...
    ##  $ compactness_mean : num  0.0698 0.1147 0.078 0.1136 0.0693 ...
    ##  $ concavity_mean   : num  0.0399 0.0639 0.0305 0.0464 0.0339 ...
    ##  $ points_mean      : num  0.037 0.0264 0.0248 0.048 0.0266 ...
    ##  $ symmetry_mean    : num  0.196 0.192 0.171 0.177 0.172 ...
    ##  $ dimension_mean   : num  0.0595 0.0649 0.0634 0.0607 0.0554 ...
    ##  $ radius_se        : num  0.236 0.451 0.197 0.338 0.178 ...
    ##  $ texture_se       : num  0.666 1.197 1.387 1.343 0.412 ...
    ##  $ perimeter_se     : num  1.67 3.43 1.34 1.85 1.34 ...
    ##  $ area_se          : num  17.4 27.1 13.5 26.3 17.7 ...
    ##  $ smoothness_se    : num  0.00805 0.00747 0.00516 0.01127 0.00501 ...
    ##  $ compactness_se   : num  0.0118 0.03581 0.00936 0.03498 0.01485 ...
    ##  $ concavity_se     : num  0.0168 0.0335 0.0106 0.0219 0.0155 ...
    ##  $ points_se        : num  0.01241 0.01365 0.00748 0.01965 0.00915 ...
    ##  $ symmetry_se      : num  0.0192 0.035 0.0172 0.0158 0.0165 ...
    ##  $ dimension_se     : num  0.00225 0.00332 0.0022 0.00344 0.00177 ...
    ##  $ radius_worst     : num  13.5 11.9 12.4 11.9 16.2 ...
    ##  $ texture_worst    : num  15.6 22.9 26.4 15.8 15.7 ...
    ##  $ perimeter_worst  : num  87 78.3 79.9 76.5 104.5 ...
    ##  $ area_worst       : num  549 425 471 434 819 ...
    ##  $ smoothness_worst : num  0.139 0.121 0.137 0.137 0.113 ...
    ##  $ compactness_worst: num  0.127 0.252 0.148 0.182 0.174 ...
    ##  $ concavity_worst  : num  0.1242 0.1916 0.1067 0.0867 0.1362 ...
    ##  $ points_worst     : num  0.0939 0.0793 0.0743 0.0861 0.0818 ...
    ##  $ symmetry_worst   : num  0.283 0.294 0.3 0.21 0.249 ...
    ##  $ dimension_worst  : num  0.0677 0.0759 0.0788 0.0678 0.0677 ...

``` r
wbcd <- wbcd[-1]

table(wbcd$diagnosis)
```

    ## 
    ##   B   M 
    ## 357 212

머신러닝 분류기는 목표 특징이 팩터로 코딩되어야 한다. 따라서 dianosis 변수를 다시 코드화한다.

``` r
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)
```

    ## 
    ##    Benign Malignant 
    ##      62.7      37.3

``` r
summary(wbcd$area_mean)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   143.5   420.3   551.1   654.9   782.7  2501.0

#### 변환 : 수치 데이터 정규화

``` r
normalize <- function(x) {
    return ((x-min(x)) / (max(x)-min(x)))
}

normalize(c(1,2,3,4,5))
```

    ## [1] 0.00 0.25 0.50 0.75 1.00

``` r
normalize(c(10,20,30,40,50))
```

    ## [1] 0.00 0.25 0.50 0.75 1.00

normalize() 함수를 데이터 프레임에 있는 수치 특징에 적용한다. 30개의 수치 변수를 개별적으로 정규화하는 것이 아니라
자동화하는 함수를 사용한다.

``` r
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  0.0000  0.1174  0.1729  0.2169  0.2711  1.0000

#### 데이터 준비 : 훈련 및 테스트 데이터셋 생성

총 569개의 레코드 중 훈련 데이터셋을 위해 처음 469개의 레코드를 사용하고, 새로운 환자를 시뮬레이션하고자 나머지 100개를
사용한다. dianosis 팩터를 가져와 레이블 벡터를 생성한다.

``` r
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]
```

-----

### 3단계 : 데이터로 모델 훈련

class 패키지의 knn() 함수는 테스트 데이터의 각 인스턴스별로 유클리드 거리를 이용해 최근접 이웃을 식별한다. 테스트
인스턴스는 k-최근접 이웃의 투표를 얻어 분류된다.  
훈련 데이터가 469개이므로 469의 제곱근과 동일한 홀수인 k=21로 시도한다. 홀수를 사용하는 이유는 2-범주 결과이므로 동점
표로 끝날 가능성을 제거하기 위해서이다.

``` r
library(class)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)
```

-----

### 4단계 : 모델 성능 평가

wbcd\_test\_pred 벡터에 있는 예측된 클래스가 wbcd\_test\_labels 벡터에 있는 실제 값과 얼마나 잘
일치하는지 평가하기 위해 CrossTable() 함수를 이용한다.

``` r
library(gmodels)

CrossTable(x=wbcd_test_labels, y=wbcd_test_pred, prop.chisq = FALSE)
```

    ## 
    ##  
    ##    Cell Contents
    ## |-------------------------|
    ## |                       N |
    ## |           N / Row Total |
    ## |           N / Col Total |
    ## |         N / Table Total |
    ## |-------------------------|
    ## 
    ##  
    ## Total Observations in Table:  100 
    ## 
    ##  
    ##                  | wbcd_test_pred 
    ## wbcd_test_labels |    Benign | Malignant | Row Total | 
    ## -----------------|-----------|-----------|-----------|
    ##           Benign |        61 |         0 |        61 | 
    ##                  |     1.000 |     0.000 |     0.610 | 
    ##                  |     0.968 |     0.000 |           | 
    ##                  |     0.610 |     0.000 |           | 
    ## -----------------|-----------|-----------|-----------|
    ##        Malignant |         2 |        37 |        39 | 
    ##                  |     0.051 |     0.949 |     0.390 | 
    ##                  |     0.032 |     1.000 |           | 
    ##                  |     0.020 |     0.370 |           | 
    ## -----------------|-----------|-----------|-----------|
    ##     Column Total |        63 |        37 |       100 | 
    ##                  |     0.630 |     0.370 |           | 
    ## -----------------|-----------|-----------|-----------|
    ## 
    ## 

이는 다음과 같은 표로 나타낼 수 있다.

| Benign(양성)             | Malignant(악성)          |
| ---------------------- | ---------------------- |
| TN(True Negative) : 61 | FP(False Positive) : 0 |
| FN(False Negative) : 2 | TP(True Positive) : 37 |

  - TN : False인데 False라고 식별한 경우
  - FP : False인데 True라고 식별한 경우
  - FN : True인데 False라고 식별한 경우
  - TP : True인데 True라고 식별한 경우

암을 진단하는 경우 FN의 결과에 주목해야 한다. 실제로는 종양이 음성인데 양성으로 예측한 경우이다. 이 오류는 환자가 암이
없다고 믿게 되지만, 실제 병이 확산될 수 있어 대가가 엄청 클 수 있다. 따라서 종양 100개 중 2개가 k-NN
방법으로 잘못 분류되었음을 알 수 있다.

-----

### 5단계 : 모델 성능 개선

이진 분류기에 다음과 같이 두 가지 변형을 시도한다.

1.  수치 특징을 재조정하고자 다른 방법을 사용한다.  
2.  k에 다른 값을 시도해본다.

#### 변환 : z-점수 표준화

전통적으로 정규화가 k-NN 분류에 사용되어 왔지만, 암 데이터셋에서는 z-점수 표준화가 더 적절한 방법이 될 수 있다. z-점수
표준화 값은 사전에 정의된 최솟값, 최댓값이 없어 극값이 중심 방향으로 축소되지 않는다.  
벡터를 표준화하고자 scale() 함수를 이용해 z-점수 표준화 방식으로 값을 재조정한다. z-점수로 표준화된 변수의 평균은 항상
0이어야 한다.

``` r
wbcd_z <- as.data.frame(scale(wbcd[-1]))
summary(wbcd_z$area_mean)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -1.4532 -0.6666 -0.2949  0.0000  0.3632  5.2459

z-점수 변환 데이터를 훈련 집합과 테스트 집합으로 나눈 후 knn()을 이용해 테스트 인스턴스를 분류한다.

``` r
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
```

    ## 
    ##  
    ##    Cell Contents
    ## |-------------------------|
    ## |                       N |
    ## |           N / Row Total |
    ## |           N / Col Total |
    ## |         N / Table Total |
    ## |-------------------------|
    ## 
    ##  
    ## Total Observations in Table:  100 
    ## 
    ##  
    ##                  | wbcd_test_pred 
    ## wbcd_test_labels |    Benign | Malignant | Row Total | 
    ## -----------------|-----------|-----------|-----------|
    ##           Benign |        61 |         0 |        61 | 
    ##                  |     1.000 |     0.000 |     0.610 | 
    ##                  |     0.924 |     0.000 |           | 
    ##                  |     0.610 |     0.000 |           | 
    ## -----------------|-----------|-----------|-----------|
    ##        Malignant |         5 |        34 |        39 | 
    ##                  |     0.128 |     0.872 |     0.390 | 
    ##                  |     0.076 |     1.000 |           | 
    ##                  |     0.050 |     0.340 |           | 
    ## -----------------|-----------|-----------|-----------|
    ##     Column Total |        66 |        34 |       100 | 
    ##                  |     0.660 |     0.340 |           | 
    ## -----------------|-----------|-----------|-----------|
    ## 
    ## 

이전 예시에서는 98%가 정확히 분류됐지만, 이번에는 95%만 정확히 분류된 것을 볼 수 있다. <br>

#### k의 대체 값 테스트

``` r
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 1)
pred1 <- CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 5)
pred5 <- CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 11)
pred11 <- CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 15)
pred15 <- CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 27)
pred27 <- CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)
```

