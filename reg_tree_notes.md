## Notes on using R for Regression Trees

The data is split in half for training and testing. The tree is grown with the medv column acting as the response. This is a continuous variable, thus perfect for a regression tree. The summary shows that only the lstat, rm, and dis predictors were used to grow the tree and that the tree has 8 leaves (terminal nodes). Further, the deviance is reported which is the sum of sq errors for regression trees.

The plot:
![Reg Tree with 8 Leaves](https://github.com/RudyWilliams/r-code/blob/master/plots/regtree_boston8.png)