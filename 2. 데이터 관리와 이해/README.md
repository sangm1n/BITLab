R 데이터 구조
================
*이상민*

#### 벡터 (vector)

벡터는 기본적인 R 데이터 구조로 항목이라고 하는 값의 순서 집합을 저장한다. 벡터 타입에는 integer, double,
character, logical이 있다. 또한 두 개의 특별한 값으로 NULL과 NA가 있다. NA는 어떤 값을 가질 수 있는
저장소이므로 길이가 1이고, NULL은 진짜 비어 있다는 의미로 길이가 0이다.

``` r
subject_name <- c("John Doe", "Jane Doe", "Steve Graves")
temperature <- c(98.1, 98.6, 101.4)
flu_status <- c(FALSE, FALSE, TRUE)
```

  - 저장된 값 접근

<!-- end list -->

``` r
temperature[2]
```

    ## [1] 98.6

  - 데이터 추출

<!-- end list -->

``` r
temperature[2:3]
```

    ## [1]  98.6 101.4

  - 값 제외

<!-- end list -->

``` r
temperature[-2]
```

    ## [1]  98.1 101.4

-----

#### 팩터 (factor)

팩터는 오직 범주 변수나 서열 변수만을 나타내고자 사용되는 특별한 종류의 벡터이다. 팩터의 장점 중 하나는 범주 레이블이 한 번만
저장된다는 것이다. MALE, MALE, FEMALE로 저장하는 대신 1, 1, 2를 저장해 동일한 정보를 저장하는 데 필요한
메모리 크기를 줄여준다.

  - 팩터 생성

<!-- end list -->

``` r
gender <- factor(c("MALE", "FEMALE", "MALE"))
gender
```

    ## [1] MALE   FEMALE MALE  
    ## Levels: FEMALE MALE

``` r
blood <- factor(c("O", "AB", "A"),
                levels = c("A", "B", "AB", "O"))
blood
```

    ## [1] O  AB A 
    ## Levels: A B AB O

  - 서열 데이터 저장

<!-- end list -->

``` r
symptoms <- factor(c("SEVERE", "MILD", "MODERATE"),
                   levels = c("MILD", "MODERATE", "SEVERE"),
                   ordered = TRUE)
symptoms
```

    ## [1] SEVERE   MILD     MODERATE
    ## Levels: MILD < MODERATE < SEVERE

``` r
symptoms > "MODERATE"
```

    ## [1]  TRUE FALSE FALSE

-----

#### 리스트 (list)

리스트는 항목의 순서 집합을 저장하는 데 사용된다는 점에서 벡터와 매우 유사하다. 하지만 벡터는 모든 항목이 같은 타입이어햐 하는
반면 리스트는 수집될 항목이 다른 데이터 타입이어도 된다. 리스트를 구성할 때에는 열의 각 구성 요소에 이름을 주어야 한다.
필수는 아니지만, 이를 통해 나중에 리스트 값에 접근할 때 이름으로 접근할 수 있다.

  - 리스트 생성

<!-- end list -->

``` r
subject1 <- list(fullname = subject_name[1],
                 temperature = temperature[1],
                 flu_status = flu_status[1],
                 gender = gender[1],
                 blood = blood[1],
                 symptoms = symptoms[1])
subject1
```

    ## $fullname
    ## [1] "John Doe"
    ## 
    ## $temperature
    ## [1] 98.1
    ## 
    ## $flu_status
    ## [1] FALSE
    ## 
    ## $gender
    ## [1] MALE
    ## Levels: FEMALE MALE
    ## 
    ## $blood
    ## [1] O
    ## Levels: A B AB O
    ## 
    ## $symptoms
    ## [1] SEVERE
    ## Levels: MILD < MODERATE < SEVERE

``` r
subject1[2]
```

    ## $temperature
    ## [1] 98.1

``` r
subject1[[2]]
```

    ## [1] 98.1

  - 구성요소 접근

<!-- end list -->

``` r
subject1$temperature
```

    ## [1] 98.1

  - 여러 항목 얻기

<!-- end list -->

``` r
subject1[c("temperature", "flu_status")]
```

    ## $temperature
    ## [1] 98.1
    ## 
    ## $flu_status
    ## [1] FALSE

-----

#### 데이터 프레임

데이터 프레임은 데이터의 행과 열을 갖고 있기 때문에 스프레드시트나 데이터베이스와 유사한 구조이다. 정확히 동일한 개수의 값을
갖는 벡터나 팩터의 리스트다. 열은 특징이나 속성이고, 행은 예시이다.

  - 데이터 프레임 생성

<!-- end list -->

``` r
pt_data <- data.frame(subject_name, temperature,
                      flu_status, gender, blood, symptoms,
                      stringAsFactors = FALSE)

pt_data
```

    ##   subject_name temperature flu_status gender blood symptoms stringAsFactors
    ## 1     John Doe        98.1      FALSE   MALE     O   SEVERE           FALSE
    ## 2     Jane Doe        98.6      FALSE FEMALE    AB     MILD           FALSE
    ## 3 Steve Graves       101.4       TRUE   MALE     A MODERATE           FALSE

  - 열 추출

<!-- end list -->

``` r
pt_data$subject_name
```

    ## [1] John Doe     Jane Doe     Steve Graves
    ## Levels: Jane Doe John Doe Steve Graves

``` r
pt_data[c("temperature", "flu_status")]
```

    ##   temperature flu_status
    ## 1        98.1      FALSE
    ## 2        98.6      FALSE
    ## 3       101.4       TRUE

-----

#### 행렬 (matrix)

행렬은 데이터의 행과 열을 갖는 2차원 표를 나타내는 데이터 구조이다. 벡터처럼 동일한 형식의 데이터만 가질 수 있으며,
일반적으로 수치 데이터만 저장한다. 행렬을 생성하려면 행의 개수 또는 열의 개수를 명시하는 파라미터와 함께
제공한다.

  - 행렬 생성

<!-- end list -->

``` r
m <- matrix(c(1,2,3,4), nrow = 2)
m
```

    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

``` r
m <- matrix(c(1,2,3,4,5,6), ncol = 2)
m
```

    ##      [,1] [,2]
    ## [1,]    1    4
    ## [2,]    2    5
    ## [3,]    3    6
