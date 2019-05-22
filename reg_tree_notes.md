## Notes on using R for Regression Trees

The data is split in half for training and testing. The tree is grown with the medv column acting as the response. This is a continuous variable, thus perfect for a regression tree. The summary shows that only the lstat, rm, and dis predictors were used to grow the tree and that the tree has 7 leaves (terminal nodes). Further, the deviance is reported which is the sum of sq errors for regression trees.

The plot:
![Reg tree with 7 leaves](https://github.com/RudyWilliams/r-code/blob/master/plots/seven_leaf_regtree.png)

We see that number of rooms seems to be the most important predictor in the model since it determines the initial split on 6.9595. If rm < 6.9595 then we travel left and check the lstat (measure of percentage of individuals in the suburb with low socioeconomic status). If this value is less than 14.405, then we fall left again and check the rm variable again. The fallout from that check leads to a terminal node. This is the mean medv for that 'box' (split on rm, take less than side and split on lstat, take less than side of that and split on rm).


#### Using CV to decide on pruning
The function cv.tree() is used and we plot the results:
![CV results](https://github.com/RudyWilliams/r-code/blob/master/plots/regtree_cv.png)

Therefore, we would choose the most complex tree: the tree that we've already grown with 7 terminal nodes. And I get an MSE of about 29.4 (the book got 25.05 but all my steps seem the same). The sqrt of this is 5.422, which means that the test predictions are within $5,422 of the actual medv.