library(MASS)
library(randomForest)

set.seed(1)
bag.boston=randomForest(medv~.,data=Boston, subset=boston.train, mtry=13, importance=T)
bag.boston

#send test data through model
bag.pred = predict(bag.boston, newdata=boston.test)
plot(boston.test.y, bag.pred)
bag.mse = mean((boston.test.y - bag.pred)^2)
bag.mse #14.8

#build random forest model
set.seed(1)
rf.boston = randomForest(medv~., data=Boston, subset=boston.train, mtry=6, importance=T)
##by default mtry = p/3 for regression trees
rf.pred = predict(rf.boston, newdata=boston.test)
rf.mse = mean((boston.test.y - rf.pred)^2)
rf.mse
importance(rf.boston)
