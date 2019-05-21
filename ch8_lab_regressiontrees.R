#section 8.3.2: Fitting Regression Trees
#using Boston dataset from MASS
library(MASS)
library(tree)

set.seed(1)
brows = nrow(Boston)
train = sample(1:brows, brows/2)
##creates a list of indicies and samples half of them

tree.boston = tree(medv~., data=Boston, subset=train)

summary(tree.boston)
plot(tree.boston)
text(tree.boston, pretty=0)

tree.pred = predict(tree.boston, Boston[-train,])
tree.mse = mean((Boston[-train,'medv'] - tree.pred)^2)
tree.mse
#cv and pruning the tree
cv.boston = cv.tree(tree.boston)
plot(cv.boston$size, cv.boston$dev, type='b')


