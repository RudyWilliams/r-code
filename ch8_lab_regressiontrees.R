#section 8.3.2: Fitting Regression Trees
#using Boston dataset from MASS split in the splits script

tree.boston = tree(medv~., data=Boston, subset=boston.train)

summary(tree.boston)
plot(tree.boston)
text(tree.boston, pretty=0)

tree.pred = predict(tree.boston, boston.test)
tree.mse = mean((boston.test.y - tree.pred)^2)
tree.mse

#cv and pruning the tree
cv.boston = cv.tree(tree.boston)
plot(cv.boston$size, cv.boston$dev, type='b')

#this just builds same tree as before the cv process
#decreasing best would lead to more pruning but the cv results suggest we stay with 7
prune.tree.boston = prune.tree(tree.boston, best=7)
prune.tree.pred = predict(prune.tree.boston, boston.test)
prune.tree.mse = mean((prune.tree.pred - boston.test.y)^2)
prune.tree.mse


