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
varImpPlot(rf.boston)


#perform boosting on the dataset
library(gbm)
set.seed(1)

boost.boston = gbm(medv~., data=Boston[boston.train,], distribution='gaussian',
                   n.trees=5000, interaction.depth=4)
##gbm doesn't have a subset option
##use 'gaussian' (sq loss) for regression & 'bernoulli' if a binary classification problem
summary(boost.boston)


#partial dependence plots
plot(boost.boston, i='rm', main='Partial Dependence Plot: "rm"', ylab='medv')
plot(boost.boston, i='lstat', main='Partial Dependence Plot: "lstat"', ylab='medv')

boost.pred = predict(boost.boston, newdata=boston.test, n.trees=5000)
##n.trees says to use the first n.trees iterations of the boosting sequence
boost.mse = mean((boston.test.y - boost.pred)^2)
boost.mse

mses = c()
x = c(10,25,50,100,200,300,400,500,600,700,800,900,1000)#,1500,3000,5000)
#see the affect of n.trees (overfitting)
for (i in x){
  boost.pred = predict(boost.boston, newdata=boston.test, n.trees=i)
  boost.mse = mean((boston.test.y - boost.pred)^2)
  mses = append(mses, boost.mse)
}
par(mfrow=c(1,1))
plot(x, mses, xlab='Number of Trees', ylab='Test MSE', type='b', col='blue')
abline(v=100)
