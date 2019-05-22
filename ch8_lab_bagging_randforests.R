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