## Notes on Bagging, Random Forest, & Boosting Implementation

#### Bagging 

The randomForest() function is used out of the randomForest package. The mtry=13 tells R to consider every predictor at each split; this amounts to bagging. This bagged model returns an MSE of 14.8 on the same data used on the single regression tree. This is a significant improvement. The default number of trees grown is 500. This can be changed with the ntrees parameter. Remember, increasing the ntrees will *not* put the model at risk of overfitting.

#### Random Forest
Simple change in the code by adjusting mtry to be less than 13 leads to a random forest. Again, the number of trees does not lead to overfitting. The random forest model leads to a test MSE of 12.585; the best so far.

The importance() function shows us how valuable each predictor is. This is the output of the importance() function on the random forest:
![importance output](https://github.com/RudyWilliams/r-code/blob/master/plots/importance_rf.png)

The first column shows the average increase over all the trees for OOB error when a given predictor is excluded from the model. Column two is the average increase in a node's purity resulting from splits on that predictor.

These can also be plotted by passing the random forest object to varImpPlot(), which produces,

![importance plot](https://github.com/RudyWilliams/r-code/blob/master/plots/varImpPlot.png)

We see that rm, lstat, and dis are the three most important predictors.