HOMEWORK \#2
================
이상민
*April 9, 2020*

## Question

데이터셋을 이용하여 C5.0, randomForest의 accuracy를 비교하시오.

  - 10-fold cross validation으로 accuracy를 비교하시오 (seed=1234)

  - 각 classifier의 parameter 값은 default 값으로 한다

  - 각 모델의 민감도와 특이도를 보이시오

## Answer

``` r
library(caret)
library(C50)
library(randomForest)
library(cvTools)
library(ROCR)

data("segmentationData")
dt <- segmentationData
```

### C5.0

``` r
k <- 10
set.seed(1234)

folds <- cvFolds(nrow(dt), K=k)
acc <- c()
for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- dt[-ts.idx, ]
    ds.ts <- dt[ts.idx, ]
    
    model <- C5.0(ds.tr[, -3], ds.tr$Class, trials=1, costs=NULL)
    pred <- predict(model, ds.ts, type="class")
    acc[i] <- mean(pred==ds.ts$Class)
}

acc_c5 <- mean(acc)
acc_c5
```

    ## [1] 0.8915324

``` r
confusionMatrix(pred, ds.ts$Class)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  PS  WS
    ##         PS 119  12
    ##         WS   9  61
    ##                                           
    ##                Accuracy : 0.8955          
    ##                  95% CI : (0.8447, 0.9342)
    ##     No Information Rate : 0.6368          
    ##     P-Value [Acc > NIR] : <2e-16          
    ##                                           
    ##                   Kappa : 0.7721          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.6625          
    ##                                           
    ##             Sensitivity : 0.9297          
    ##             Specificity : 0.8356          
    ##          Pos Pred Value : 0.9084          
    ##          Neg Pred Value : 0.8714          
    ##              Prevalence : 0.6368          
    ##          Detection Rate : 0.5920          
    ##    Detection Prevalence : 0.6517          
    ##       Balanced Accuracy : 0.8827          
    ##                                           
    ##        'Positive' Class : PS              
    ## 

### Random Forest

``` r
k <- 10
set.seed(1234)

folds <- cvFolds(nrow(dt), K=k)
acc <- c()
for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- dt[-ts.idx, ]
    ds.ts <- dt[ts.idx, ]
    
    model <- randomForest(Class~., data=ds.tr, na.action=na.omit)
    pred <- predict(model, ds.ts, type="class")
    acc[i] <- mean(pred==ds.ts$Class)
}

acc_rf <- mean(acc)
acc_rf
```

    ## [1] 1

``` r
confusionMatrix(pred, ds.ts$Class)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  PS  WS
    ##         PS 128   0
    ##         WS   0  73
    ##                                      
    ##                Accuracy : 1          
    ##                  95% CI : (0.9818, 1)
    ##     No Information Rate : 0.6368     
    ##     P-Value [Acc > NIR] : < 2.2e-16  
    ##                                      
    ##                   Kappa : 1          
    ##                                      
    ##  Mcnemar's Test P-Value : NA         
    ##                                      
    ##             Sensitivity : 1.0000     
    ##             Specificity : 1.0000     
    ##          Pos Pred Value : 1.0000     
    ##          Neg Pred Value : 1.0000     
    ##              Prevalence : 0.6368     
    ##          Detection Rate : 0.6368     
    ##    Detection Prevalence : 0.6368     
    ##       Balanced Accuracy : 1.0000     
    ##                                      
    ##        'Positive' Class : PS         
    ##
