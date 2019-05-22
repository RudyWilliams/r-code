## Notes on Bagging and Random Forest Implementation

The randomForest() function is used out of the randomForest package. The mtry=13 tells R to consider every predictor at each split; this amounts to bagging. This bagged model returns an MSE of 14.8 on the same data used on the single regression tree. This is a significant improvement.