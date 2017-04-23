# Decision trees
# trees -> pruning -> cross validation

library(tree)
library(ISLR)
attach(Carseats)
High=ifelse(Sales <=8,"No","Yes")
Carseats =data.frame(Carseats ,High)
tree.carseats =tree(High~.-Sales ,Carseats )
summary(tree.carseats)
plot(tree.carseats)
text(tree.carseats ,pretty =0)

tree.carseats

set.seed (2)
train=sample(1:nrow(Carseats), 200)
Carseats.test=Carseats [-train ,]
High.test=High[-train]
tree.carseats=tree(High~.-Sales,Carseats,subset=train)
tree.pred=predict(tree.carseats,Carseats.test,type="class")
table(tree.pred ,High.test)

set.seed (3)
cv.carseats =cv.tree(tree.carseats ,FUN=prune.misclass )
names(cv.carseats )
cv.carseats

par(mfrow=c(1,2))
plot(cv.carseats$size ,cv.carseats$dev ,type="b")
plot(cv.carseats$k ,cv.carseats$dev ,type="b")


prune.carseats=prune.misclass(tree.carseats,best=9)
plot(prune.carseats )
text(prune.carseats,pretty=0)
# pretty = 0 means to show the name of classification rather than 1,0

tree.pred=predict(prune.carseats,Carseats.test,type="class")
table(tree.pred ,High.test)



# fitting regression trees

library(MASS)
set.seed (1)
train = sample(1:nrow(Boston), nrow(Boston)/2)
tree.boston=tree(medv~.,Boston ,subset=train)
summary(tree.boston)

plot(tree.boston)
text(tree.boston ,pretty=0)

# using cross validation to check if pruning the tree will help

cv.boston=cv.tree(tree.boston)
plot(cv.boston$size ,cv.boston$dev ,type='b')
cv.boston
prune.boston=prune.tree(tree.boston ,best=5)
plot(prune.boston)
text(prune.boston ,pretty=0)


yhat=predict(tree.boston ,newdata=Boston[-train ,])
boston.test=Boston[-train ,"medv"]
plot(yhat,boston.test)
abline (0 ,1)
mean((yhat-boston.test)^2)


# bagging

library(randomForest)
set.seed (1)
bag.boston=randomForest(medv~.,data=Boston,subset=train,
                          mtry=13,importance =TRUE)
# mtry = 13 means all predictors should be used for each split of tree that means we are doing bootstrapping

bag.boston

yhat.bag = predict(bag.boston ,newdata=Boston[-train ,])
plot(yhat.bag, boston.test)
abline (0 ,1)
mean((yhat.bag-boston.test)^2)

# lets change the number of trees specified 
bag.boston=randomForest(medv~.,data=Boston,subset=train, mtry=13,ntree=25)
yhat.bag = predict(bag.boston ,newdata=Boston[-train ,])
mean((yhat.bag-boston.test)^2)

# by default randomforest uses p/3 variables for predicting regression trees
# and p^1/2 variables when building a random forest of classification trees

set.seed (1)
rf.boston=randomForest(medv~.,data=Boston,subset=train,
                         mtry=6,importance =TRUE)
yhat.rf = predict(rf.boston ,newdata=Boston[-train ,])
mean((yhat.rf-boston.test)^2)
# using importance() function we can view importance of each variable
importance(rf.boston)
# rm and lstat are two important variables
varImpPlot (rf.boston)

# boosting

# in gbm we use distribution = "gaussian" for regression problem and 
# distribution = "bernoulli" for classification problems
# interaction.depth limits the depth of each tree


library(gbm)
set.seed (1)
boost.boston=gbm(medv~.,data=Boston[train,],distribution=
                     "gaussian",n.trees=5000, interaction.depth=4)
summary(boost.boston)

par(mfrow=c(1,2)) 
plot(boost.boston ,i="rm") 
plot(boost.boston ,i="lstat")

yhat.boost=predict(boost.boston,newdata=Boston[-train,], n.trees=5000)
mean((yhat.boost -boston.test)^2)
# the default shrinkage parameter for boosting is 0.001
# lets try shrinkage of 0.2


boost.boston=gbm(medv~.,data=Boston[train,],distribution= "gaussian",n.trees=5000, 
                 interaction.depth=4,shrinkage =0.2, verbose =F)
yhat.boost=predict(boost.boston,newdata=Boston[-train,], n.trees=5000)
mean((yhat.boost -boston.test)^2)

# to do excercise 

