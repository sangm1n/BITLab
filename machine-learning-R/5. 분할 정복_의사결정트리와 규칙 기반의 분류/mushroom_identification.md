규칙 학습자를 이용한 독버섯 식별
================
*이상민*

-----

## 규칙 학습자를 이용한 독버섯 식별

야생 버섯이 독이 있는지 식용인지를 식별하기 위한 명확한 규칙이 없다. 설상가상으로 “독버섯은 밝은 색을 띤다”와 같이 여러
전통적인 규칙은 위험하거나 오해의 소지가 있는 정보를 제공한다. 독버섯을 식별하고자 간단하고, 명황하고, 일관된 규칙이
있다면 채취자의 생명을 구할 수 있을 것이다.

-----

### 1단계 : 데이터 수집

<http://archive.ics.uci.edu/ml>에 있는 데이터셋을 활용한다. 이 데이터셋은 오듀본 협회 북미 버섯 필드
가이드에 목록화된 주름진 버섯 23종, 8,124개의 버섯 샘플에 대한 정보를 포함한다.

-----

### 2단계 : 데이터 탐색과 준비

22개의 특징과 타깃 클래스가 모두 명목이기 때문에 StringsAsFactors=TRUE를 설정하고, 자동화된 팩터 변환을
이용한다.  
veil\_type 데이터의 모든 예시는 partial로 분류됐다. 부정확하게 코드화된 것 같으니 분석에서 제외한다.

``` r
mushrooms <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)
str(mushrooms)
```

    ## 'data.frame':    8124 obs. of  23 variables:
    ##  $ type                    : Factor w/ 2 levels "edible","poisonous": 2 1 1 2 1 1 1 1 2 1 ...
    ##  $ cap_shape               : Factor w/ 6 levels "bell","conical",..: 3 3 1 3 3 3 1 1 3 1 ...
    ##  $ cap_surface             : Factor w/ 4 levels "fibrous","grooves",..: 4 4 4 3 4 3 4 3 3 4 ...
    ##  $ cap_color               : Factor w/ 10 levels "brown","buff",..: 1 10 9 9 4 10 9 9 9 10 ...
    ##  $ bruises                 : Factor w/ 2 levels "no","yes": 2 2 2 2 1 2 2 2 2 2 ...
    ##  $ odor                    : Factor w/ 9 levels "almond","anise",..: 8 1 2 8 7 1 1 2 8 1 ...
    ##  $ gill_attachment         : Factor w/ 2 levels "attached","free": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ gill_spacing            : Factor w/ 2 levels "close","crowded": 1 1 1 1 2 1 1 1 1 1 ...
    ##  $ gill_size               : Factor w/ 2 levels "broad","narrow": 2 1 1 2 1 1 1 1 2 1 ...
    ##  $ gill_color              : Factor w/ 12 levels "black","brown",..: 1 1 2 2 1 2 5 2 8 5 ...
    ##  $ stalk_shape             : Factor w/ 2 levels "enlarging","tapering": 1 1 1 1 2 1 1 1 1 1 ...
    ##  $ stalk_root              : Factor w/ 5 levels "bulbous","club",..: 3 2 2 3 3 2 2 2 3 2 ...
    ##  $ stalk_surface_above_ring: Factor w/ 4 levels "fibrous","scaly",..: 4 4 4 4 4 4 4 4 4 4 ...
    ##  $ stalk_surface_below_ring: Factor w/ 4 levels "fibrous","scaly",..: 4 4 4 4 4 4 4 4 4 4 ...
    ##  $ stalk_color_above_ring  : Factor w/ 9 levels "brown","buff",..: 8 8 8 8 8 8 8 8 8 8 ...
    ##  $ stalk_color_below_ring  : Factor w/ 9 levels "brown","buff",..: 8 8 8 8 8 8 8 8 8 8 ...
    ##  $ veil_type               : Factor w/ 1 level "partial": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ veil_color              : Factor w/ 4 levels "brown","orange",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ ring_number             : Factor w/ 3 levels "none","one","two": 2 2 2 2 2 2 2 2 2 2 ...
    ##  $ ring_type               : Factor w/ 5 levels "evanescent","flaring",..: 5 5 5 5 1 5 5 5 5 5 ...
    ##  $ spore_print_color       : Factor w/ 9 levels "black","brown",..: 1 2 2 1 2 1 1 2 1 1 ...
    ##  $ population              : Factor w/ 6 levels "abundant","clustered",..: 4 3 3 4 1 3 3 4 5 4 ...
    ##  $ habitat                 : Factor w/ 7 levels "grasses","leaves",..: 5 1 3 5 1 1 3 3 1 3 ...

``` r
mushrooms$veil_type <- NULL
table(mushrooms$type)
```

    ## 
    ##    edible poisonous 
    ##      4208      3916

-----

### 3단계 : 데이터로 모델 훈련

목표를 달성하고자 타깃 클래스를 가장 잘 예측하는 특징을 하나 식별하고 규칙 집합을 구성하는 데 사용할 1R 분류기를 적용한다.

``` r
library(OneR)

mushroom_1R <- OneR(type~., data=mushrooms)
mushroom_1R
```

    ## 
    ## Call:
    ## OneR.formula(formula = type ~ ., data = mushrooms)
    ## 
    ## Rules:
    ## If odor = almond   then type = edible
    ## If odor = anise    then type = edible
    ## If odor = creosote then type = poisonous
    ## If odor = fishy    then type = poisonous
    ## If odor = foul     then type = poisonous
    ## If odor = musty    then type = poisonous
    ## If odor = none     then type = edible
    ## If odor = pungent  then type = poisonous
    ## If odor = spicy    then type = poisonous
    ## 
    ## Accuracy:
    ## 8004 of 8124 instances classified correctly (98.52%)

-----

### 4단계 : 모델 성능 평가

표의 행은 4,208개의 식용 버섯과 3,916개의 독버섯을 나눈다. 표를 관찰하면 1R 분류기가 식용 버섯을 독이 있는 것으로
분류하지는 않았지만, 120개의 독버섯을 식용으로 분류한 것을 볼 수 있다. 이는 엄청나게 위험한 실수를 한 것으로 판단된다.

``` r
mushroom_1R_pred <- predict(mushroom_1R, mushrooms)
table(actual = mushrooms$type, predicted = mushroom_1R_pred)
```

    ##            predicted
    ## actual      edible poisonous
    ##   edible      4208         0
    ##   poisonous    120      3796

-----

### 5단계 : 모델 성능 개선

조금 더 고도화된 규칙 학습자를 위해 자바 기반의 리퍼 규칙 학습 알고리즘의 구현체인 JRip()을 사용한다.

``` r
library(RWeka)

mushroom_JRip <- JRip(type~., data=mushrooms)
mushroom_JRip
```

    ## JRIP rules:
    ## ===========
    ## 
    ## (odor = foul) => type=poisonous (2160.0/0.0)
    ## (gill_size = narrow) and (gill_color = buff) => type=poisonous (1152.0/0.0)
    ## (gill_size = narrow) and (odor = pungent) => type=poisonous (256.0/0.0)
    ## (odor = creosote) => type=poisonous (192.0/0.0)
    ## (spore_print_color = green) => type=poisonous (72.0/0.0)
    ## (stalk_surface_below_ring = scaly) and (stalk_surface_above_ring = silky) => type=poisonous (68.0/0.0)
    ## (habitat = leaves) and (cap_color = white) => type=poisonous (8.0/0.0)
    ## (stalk_color_above_ring = yellow) => type=poisonous (8.0/0.0)
    ##  => type=edible (4208.0/0.0)
    ## 
    ## Number of Rules : 9

JRip() 분류기는 버섯 데이터에서 전체 8개의 규칙을 학습했다. 처음 세 개의 규칙은 다음과 같이 표현할 수 있다.

  - 냄새가 악취이면 이 버섯 종류는 독이 있다.
  - 주름 크기가 좁고 주름색이 담황색이면 이 버섯 종류는 독이 있다.
  - 주름 크기가 좁고 냄새가 톡 쏘면 이 버섯 종류는 독이 있다.

마지막으로 여덟 번째 규칙은 이전 일곱 가지 규칙에 해당하지 않는 버섯 샘플은 식용이라는 것을 암시한다.  
각 규칙 옆의 숫자는 규칙에 의해 다뤄지는 인스턴스 개수와 오분류된 인스턴스 개수를 나타낸다. 분명 여덟 개의 규칙을 이용해
오분류된 버섯 샘플은 없다. 마지막 규칙에 의해 다뤄지는 인스턴스의 개수는 데이터에 있는 식용 버섯의
개수(4,208)와 정확히 일치한다.

