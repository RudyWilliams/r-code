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

#### Boosting
The gbm() function out of the gmb package is used to perform boosting on the regression tree model. The summary of the gbm object plots the relative influence and shows a table of each predictor's value.

![rel infl plot](https://github.com/RudyWilliams/r-code/blob/master/plots/rel_influ_plot.png)
![rel infl table](https://github.com/RudyWilliams/r-code/blob/master/plots/rel_influ_table.png)

We again see that rm and lstat are the most important predictors in the model. The dis predictor is the third most important but it is a distant third.

We could visualize the affect that variables have on the response with other variables removed in *partial dependece plots*. 

![partial dep plot rm](https://github.com/RudyWilliams/r-code/blob/master/plots/pdepPlot_rm.png)
![partial dep plot lstat](https://github.com/RudyWilliams/r-code/blob/master/plots/pdepPlot_lstat.png)

The more rooms the more expensive we would expect the houses to be. So some sort of direct relationship is expected for the first plot and that is what we get; as the number of rooms increases so does the medv. With the lstat predictor we would expect an indirect relationship. The plot reaffirms the intuition.

The boosted model is vulnerable to overfitting based on the number of trees used. We can plot the test MSE as the boosted model grows.

![boost MSE](https://github.com/RudyWilliams/r-code/blob/master/plots/boostMSE.png)
![zoomed boost MSE](https://github.com/RudyWilliams/r-code/blob/master/plots/zoomed_boostMSE.png)

The lowest value occurs at n.trees=100.