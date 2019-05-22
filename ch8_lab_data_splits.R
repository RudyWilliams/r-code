#using Boston dataset from MASS
library(MASS)
library(tree)

#for regression trees on medv as response
set.seed(1)
boston.nrows = nrow(Boston)
boston.train = sample(1:boston.nrows, boston.nrows * 0.8) #just indices
boston.test = Boston[-boston.train,]
boston.test.y = boston.test[,'medv']

