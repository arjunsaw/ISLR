# SVM is a generalization of simple and intuitive classifier "maximal marginal classifier"
# Hyperplane
#The generalization of the maximal margin classifier to the non-separable 
# case is known as the support vector classifier.

# use kernel = "linear" with svm() to fit a support vector classifier
# lets create observations that belong to different classification
set.seed (1)
x=matrix(rnorm(20*2), ncol=2)
y=c(rep(-1,10), rep(1,10))
x[y==1,]=x[y==1,] + 1

plot(x, col=(3-y))

dat=data.frame(x=x, y=as.factor(y))
library(e1071)
svmfit=svm(y~., data=dat, kernel="linear", cost=10,
             scale=FALSE)
#scale=FALSE tells the svm() function not to scale each feature to have mean zero or standard deviation one
plot(svmfit , dat)
# support vectors
svmfit$index
summary(svmfit)


# lets use a small cost parameter
svmfit=svm(y~., data=dat, kernel="linear", cost=0.1, scale=FALSE)
plot(svmfit , dat)
svmfit$index

# for cross validation , function tune() is used, by default 10 fold cross validation
set.seed (1)
tune.out=tune(svm,y~.,data=dat,kernel="linear",
                ranges=list(cost=c(0.001, 0.01, 0.1, 1,5,10,100)))
summary(tune.out)
bestmod=tune.out$best.model
summary(bestmod)

# after cross validation we predict

xtest=matrix(rnorm(20*2), ncol=2)
ytest=sample(c(-1,1), 20, rep=TRUE)
xtest [ ytest ==1 ,]= xtest [ ytest ==1 ,] + 1
testdat=data.frame(x=xtest, y=as.factor(ytest))

ypred=predict(bestmod ,testdat)
table(predict=ypred, truth=testdat$y)

# now if two classes are linearly separable

x[y==1,]=x[y==1,]+0.5
plot(x, col=(y+5)/2, pch=19)
dat=data.frame(x=x,y=as.factor(y))
svmfit=svm(y~., data=dat, kernel="linear", cost=1e5)
summary(svmfit)

svmfit=svm(y~., data=dat, kernel="linear", cost=1)
summary(svmfit)
plot(svmfit ,dat)


# Support Vector Machine
# To fit an SVM with a polynomial kernel we use kernel="polynomial"
# to fit an SVM with a radial kernel we use kernel="radial"

# generating data with non linear class boundary

set.seed (1)
x=matrix(rnorm(200*2), ncol=2)
x[1:100,]=x[1:100,]+2
x[101:150,]=x[101:150,]-2
y=c(rep(1,150),rep(2,50))
dat=data.frame(x=x,y=as.factor(y))

plot(x, col=y)

train=sample(200,100)
svmfit=svm(y~., data=dat[train,], kernel="radial", gamma=1,
             cost =1)
plot(svmfit , dat[train ,])
summary(svmfit)


# since there can be seen fiarly amount of errors, lets increase the value of cost
svmfit=svm(y~., data=dat[train,], kernel="radial",gamma=1, cost=1e5)
plot(svmfit ,dat[train ,])

# now we can perform cross validation using tune() parameter
set.seed (1)
tune.out=tune(svm, y~., data=dat[train,], kernel="radial",
                ranges=list(cost=c(0.1,1,10,100,1000),
                            gamma=c(0.5,1,2,3,4) ))
summary(tune.out)

table(true=dat[-train,"y"], pred=predict(tune.out$best.model, newx=dat[-train ,]))

# ROC Curves

library(ROCR) 
rocplot=function(pred, truth, ...)
{
  predob = prediction (pred, truth)
  perf = performance (predob , "tpr", "fpr") 
  plot(perf ,...)
}
#In order to obtain the fitted values for a given SVM model fit, we use decision.values=TRUE when fitting svm()
svmfit.opt=svm(y~., data=dat[train,], kernel="radial", gamma=2, cost=1,decision.values=T)
fitted=attributes(predict(svmfit.opt,dat[train,],decision.values=TRUE))$decision.values
par(mfrow=c(1,2))
rocplot(fitted ,dat[train ,"y"],main="Training Data")
# by increasing gamma we can produce more flexible fit
svmfit.flex=svm(y~., data=dat[train,], kernel="radial", gamma=50, cost=1, decision.values=T)
fitted=attributes(predict(svmfit.flex,dat[train,],decision.values=T))$decision.values
rocplot(fitted ,dat[train ,"y"],add=T,col="red")

# with test data
fitted=attributes(predict(svmfit.opt,dat[-train,],decision.values=T))$decision.values
rocplot(fitted,dat[-train,"y"],main="Test Data")
fitted=attributes(predict(svmfit.flex,dat[-train,],decision.values=T))$decision.values
rocplot(fitted,dat[-train,"y"],add=T,col="red")

# SVM with multiple classes
set.seed (1)
x=rbind(x, matrix(rnorm(50*2), ncol=2))
y=c(y, rep(0,50))
x[y==0,2]=x[y==0,2]+2
dat=data.frame(x=x, y=as.factor(y))
par(mfrow=c(1,1))
plot(x,col=(y+1))

svmfit=svm(y~., data=dat, kernel="radial", cost=10, gamma=1) 
plot(svmfit , dat)


# Gene expression data set

library(ISLR)
?Khan
names(Khan)
dim(Khan$xtrain )
dim(Khan$xtest )
length(Khan$ytrain )
length(Khan$ytest )
table(Khan$ytrain )
table(Khan$ytest )
dat=data.frame(x=Khan$xtrain , y=as.factor(Khan$ytrain ))
out=svm(y~., data=dat, kernel="linear",cost=10)
summary(out)

table(out$fitted , dat$y)


dat.te=data.frame(x=Khan$xtest , y=as.factor(Khan$ytest ))
pred.te=predict(out, newdata=dat.te)
table(pred.te, dat.te$y)









