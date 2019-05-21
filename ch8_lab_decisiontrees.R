### Decision Trees

#Classification tree
library(tree)
library(ISLR)
attach(Carseats)

High = ifelse(Sales<=8, 'No', 'Yes')

#use data.frame() function to merge High with rest of dataframe
Carseats = data.frame(Carseats, High)
names(Carseats)

#fitting a decision tree is similar to lm()
tree.carseats=tree(High~.-Sales, Carseats)
##creates treee to predict High but drops Sales

summary(tree.carseats)
##lists the variables actually used by the tree,
##the number of terminal nodes (leaves), & training error rate
##NOTE: the residual mean deviance is the deviance divided
##by n - |To| = 400 - 27 (ie sub the number of leaves)
##RECALL: Deviance is an indicator of fit so a small 
##deviance indicates that the tree is a good fit to the 
##training data

#plot the tree visualization
plot(tree.carseats)
text(tree.carseats, pretty=0)

##we see that the top split is based on location on the shelf
##therefore, shelf location seems to be the most important variable 
#in sales

tree.carseats
##this prints output corresponding to each branch of the tree
##displays split criterion (e.g. Price < 92.5), the number of obs
##in that branch (46), the deviance (56.530), the overall prediction for the branch (Yes or No),
##and fraction of observations that take on values of Yes and No


#create train/test sets
set.seed(2)

train = sample(1:nrow(Carseats), 200)
Carseats.test = Carseats[-train,]
High.test = High[-train]
#build tree
tree.carseats = tree(High~.-Sales, Carseats, subset=train)
#predict with tree
tree.pred = predict(tree.carseats, Carseats.test, type='class')
##the type='class' tells R to return the actual class prediction

#create confusion matrix
dc_confmat = table(High.test, tree.pred)
dc_acc = (dc_confmat[1,1] + dc_confmat[2,2])/sum(dc_confmat)
dc_acc



#Pruning and Cross-Validation
# use function cv.tree()
#   FUN=prune.misclass indicates that we want the classification error rate
#   to guide the cv and pruning process rather than the default for 
#   cv.tree() which is deviance
set.seed(3)

cv.carseats = cv.tree(tree.carseats, FUN=prune.misclass)

names(cv.carseats)
##size (# of terminal nodes), dev, k (cost-complexity parameter
##which corresponds to alpha in 8.4 (gets mult by size of tree as 
##a means of regularization)), and method

cv.carseats
##dev actually reports the cv error in this case
##the tree with 9 terminal nodes has lowest value

#plots
plot(cv.carseats$size, cv.carseats$dev, type='b')
plot(cv.carseats$k, cv.carseats$dev, type='b')

#now to prune the tree use prune.misclass() function
prune.carseats=prune.misclass(tree.carseats, best=9)
##best is an alternative to using the cost-complexity hyperparam k (alpha)
prune.carseats
##shows each branch of pruned tree

plot(prune.carseats)
text(prune.carseats, pretty=0)
##notice how shelveloc gets used more than once as well as price

#test data
tree.pred = predict(prune.carseats, Carseats.test, type='class')
table(High.test, tree.pred)
##this tree has a better test acc of 0.77
##thus we get a more interpretable tree along with improved accuracy




