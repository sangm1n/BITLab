HOMEWORK \#3
================
이상민
*April 16, 2020*

## Question

위의 데이터셋을 이용하여 xgboost의 accuracy를 구하시오.

  - 10-fold cross validation으로 accuracy를 비교하시오 (seed=1234)

  - 각 classifier의 parameter 값은 default 값으로 한다

  - 각 모델의 민감도와 특이도를 보이시오

## Answer

``` r
library(caret)
library(cvTools)
library(xgboost)

data("segmentationData")
dt <- segmentationData
```

``` r
k <- 10
set.seed(1234)

folds <- cvFolds(nrow(dt), K=k)
acc <- c()
sens <- c()
spec <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- dt[-ts.idx, ]
    ds.ts <- dt[ts.idx, ]
    lab.tr <- as.numeric(ds.tr$Class) - 1
    lab.ts <- as.numeric(ds.ts$Class) - 1
    
    mat.tr <- as.matrix(ds.tr[, -c(2, 3)])
    mat.ts <- as.matrix(ds.ts[, -c(2, 3)])
    
    model <- xgboost(mat.tr, label = lab.tr, max_depth = 6,
                     eta = 0.3, nround = 3, objective = "binary:logistic")
    pred <- predict(model, mat.ts)
    pred <- ifelse(pred > 0.5, 1, 0)
    pred <- as.factor(pred)
    lab.ts <- as.factor(lab.ts)
    
    res <- confusionMatrix(pred, lab.ts)
    acc[i] <- res$overall["Accuracy"]
    sens[i] <- res$byClass["Sensitivity"]
    spec[i] <- res$byClass["Specificity"]
}
```

    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684 
    ## [1]  train-error:0.122398 
    ## [2]  train-error:0.101090 
    ## [3]  train-error:0.090684

``` r
res
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction   0   1
    ##          0 119  16
    ##          1   9  57
    ##                                           
    ##                Accuracy : 0.8756          
    ##                  95% CI : (0.8219, 0.9179)
    ##     No Information Rate : 0.6368          
    ##     P-Value [Acc > NIR] : 2.209e-14       
    ##                                           
    ##                   Kappa : 0.7255          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.2301          
    ##                                           
    ##             Sensitivity : 0.9297          
    ##             Specificity : 0.7808          
    ##          Pos Pred Value : 0.8815          
    ##          Neg Pred Value : 0.8636          
    ##              Prevalence : 0.6368          
    ##          Detection Rate : 0.5920          
    ##    Detection Prevalence : 0.6716          
    ##       Balanced Accuracy : 0.8553          
    ##                                           
    ##        'Positive' Class : 0               
    ## 

``` r
tot_df <- data.frame(acc, sens, spec)
colnames(tot_df) <- c("Accuracy", "Sensitivity", "Specificity")
tot_df
```

    ##     Accuracy Sensitivity Specificity
    ## 1  0.9059406   0.9312977   0.8591549
    ## 2  0.9306931   0.9489051   0.8923077
    ## 3  0.8762376   0.8968254   0.8421053
    ## 4  0.9356436   0.9333333   0.9402985
    ## 5  0.8910891   0.9040000   0.8701299
    ## 6  0.9158416   0.9333333   0.8805970
    ## 7  0.9207921   0.9206349   0.9210526
    ## 8  0.9207921   0.9248120   0.9130435
    ## 9  0.9207921   0.9193548   0.9230769
    ## 10 0.8756219   0.9296875   0.7808219

``` r
mean_df <- data.frame(mean(acc), mean(sens), mean(spec))
colnames(mean_df) <- c("Accuracy", "Sensitivity", "Specificity")
mean_df
```

    ##    Accuracy Sensitivity Specificity
    ## 1 0.9093444   0.9242184   0.8822588

## Question

위의 데이터셋을 이용하여 knn, svm의 accuracy를 비교하되 caret 패키지를 이용하시오.

  - 10-fold cross validation으로 accuracy를 비교하시오 (seed=1234)

  - 각 classifier의 parameter 값은 default 값으로 한다

  - 각 모델의 민감도와 특이도를 보이시오

## Answer

### SVM

``` r
k <- 10
set.seed(1234)

folds <- cvFolds(nrow(dt), K=k)
acc <- c()
sens <- c()
spec <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- dt[-ts.idx, ]
    ds.ts <- dt[ts.idx, ]
    
    model <- train(Class~., ds.tr, method = "svmRadial")
    pred <- predict(model, ds.ts)
    
    res <- confusionMatrix(pred, ds.ts$Class)
    acc[i] <- res$overall["Accuracy"]
    sens[i] <- res$byClass["Sensitivity"]
    spec[i] <- res$byClass["Specificity"]
}

res
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  PS  WS
    ##         PS 118  18
    ##         WS  10  55
    ##                                          
    ##                Accuracy : 0.8607         
    ##                  95% CI : (0.805, 0.9054)
    ##     No Information Rate : 0.6368         
    ##     P-Value [Acc > NIR] : 1.169e-12      
    ##                                          
    ##                   Kappa : 0.6916         
    ##                                          
    ##  Mcnemar's Test P-Value : 0.1859         
    ##                                          
    ##             Sensitivity : 0.9219         
    ##             Specificity : 0.7534         
    ##          Pos Pred Value : 0.8676         
    ##          Neg Pred Value : 0.8462         
    ##              Prevalence : 0.6368         
    ##          Detection Rate : 0.5871         
    ##    Detection Prevalence : 0.6766         
    ##       Balanced Accuracy : 0.8376         
    ##                                          
    ##        'Positive' Class : PS             
    ## 

``` r
tot_df <- data.frame(acc, sens, spec)
colnames(tot_df) <- c("Accuracy", "Sensitivity", "Specificity")
tot_df
```

    ##     Accuracy Sensitivity Specificity
    ## 1  0.8564356   0.9083969   0.7605634
    ## 2  0.8910891   0.9270073   0.8153846
    ## 3  0.8564356   0.8968254   0.7894737
    ## 4  0.8514851   0.8740741   0.8059701
    ## 5  0.8712871   0.8800000   0.8571429
    ## 6  0.8415842   0.8740741   0.7761194
    ## 7  0.8762376   0.9126984   0.8157895
    ## 8  0.9009901   0.9248120   0.8550725
    ## 9  0.8910891   0.9274194   0.8333333
    ## 10 0.8606965   0.9218750   0.7534247

``` r
mean_df <- data.frame(mean(acc), mean(sens), mean(spec))
colnames(mean_df) <- c("Accuracy", "Sensitivity", "Specificity")
mean_df
```

    ##   Accuracy Sensitivity Specificity
    ## 1 0.869733   0.9047183   0.8062274

### kNN

``` r
k <- 10
set.seed(1234)

folds <- cvFolds(nrow(dt), K=k)
acc <- c()
sens <- c()
spec <- c()

for (i in 1:k) {
    ts.idx <- folds$which == i
    ds.tr <- dt[-ts.idx, ]
    ds.ts <- dt[ts.idx, ]
    
    model <- train(Class~., ds.tr, method = "knn")
    pred <- predict(model, ds.ts)
    
    res <- confusionMatrix(pred, ds.ts$Class)
    acc[i] <- res$overall["Accuracy"]
    sens[i] <- res$byClass["Sensitivity"]
    spec[i] <- res$byClass["Specificity"]
}

res
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction  PS  WS
    ##         PS 112  19
    ##         WS  16  54
    ##                                           
    ##                Accuracy : 0.8259          
    ##                  95% CI : (0.7662, 0.8756)
    ##     No Information Rate : 0.6368          
    ##     P-Value [Acc > NIR] : 3.136e-09       
    ##                                           
    ##                   Kappa : 0.6202          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.7353          
    ##                                           
    ##             Sensitivity : 0.8750          
    ##             Specificity : 0.7397          
    ##          Pos Pred Value : 0.8550          
    ##          Neg Pred Value : 0.7714          
    ##              Prevalence : 0.6368          
    ##          Detection Rate : 0.5572          
    ##    Detection Prevalence : 0.6517          
    ##       Balanced Accuracy : 0.8074          
    ##                                           
    ##        'Positive' Class : PS              
    ## 

``` r
tot_df <- data.frame(acc, sens, spec)
colnames(tot_df) <- c("Accuracy", "Sensitivity", "Specificity")
tot_df
```

    ##     Accuracy Sensitivity Specificity
    ## 1  0.8762376   0.8854962   0.8591549
    ## 2  0.8415842   0.8467153   0.8307692
    ## 3  0.8118812   0.8492063   0.7500000
    ## 4  0.8366337   0.8592593   0.7910448
    ## 5  0.8564356   0.8480000   0.8701299
    ## 6  0.8613861   0.8962963   0.7910448
    ## 7  0.8514851   0.8571429   0.8421053
    ## 8  0.8366337   0.8872180   0.7391304
    ## 9  0.8217822   0.8467742   0.7820513
    ## 10 0.8258706   0.8750000   0.7397260

``` r
mean_df <- data.frame(mean(acc), mean(sens), mean(spec))
colnames(mean_df) <- c("Accuracy", "Sensitivity", "Specificity")
mean_df
```

    ##   Accuracy Sensitivity Specificity
    ## 1 0.841993   0.8651109   0.7995157
