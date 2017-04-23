setwd("~/Desktop/MSBAPM/R/R files")
# logistic regression, K nearest neighbours and linear discriminant analysis

# LOGISTIC REGRESSION

# we model probabilities as its range is within [0,1]
# p(X) = b0 + b1*X, if we follow the linear regression here, we might predict neagtive probs and
# probs more than 1., so we cannot use this approach
# so to avoid this problem we use logistic function, p(X) = exp(b0+b1*X)/1+exp(b0+b1*X)
# to fit the method we use maximum likelihood function
# after some manipualtion we get p(X)/1-p(X) = exp(b0+b1*X)
# p(X)/1-p(X)  is called odds i.e prob of success/prob of failure
# taking log on both sides log(p(X)/1-p(X)) = b0+b1*X
# log odds is linear in X

# Estimating Regression coefficients
# Likelihood function is product of all probabilities

# For multiple class classification
# LINEAR DISCRIMINANT ANALYSIS
# so first we model distribution of model X spearately for each response classes
# and then use bayes theorem to flip these around into estimates. When these distributions 
# are assumed to be normal, the model is very similar to that of logistoc regression.

# WHY DO WE NEED OTHER METHOD THAN LOGISTIC REGRESSION
# 1) When the classes are well-separated, the parameter estimates for the logistic regression model 
#   are surprisingly unstable. Linear discrimi- nant analysis does not suffer from this problem.
# 2) If n is small and the distribution of the predictors X is approximately normal in each of the classes, 
#   the linear discriminant model is again more stable than the logistic regression model.
# 3) linear discriminant analysis is popular when we have more than two response classes.

# Using Baye's theorem for classification
# Suppose that we wish to classify an observation into one of K classes, where K ??? 2.
# Let ??k represent the overall or prior prior probability that a randomly chosen observation comes 
# from the kth class
# Let fk(X) ??? Pr(X = x|Y = k) denote the density function of X for an observation that comes from the kth class.
# now the bayes theorem states that 
# Pr(Y = k|X = x) =  ??kfk(x)/sum(??lfl(x))

library(ISLR)
names(Smarket)
dim(Smarket)
summary(Smarket)
cor(Smarket)# since direction variable is qualittatuve it gives error
cor(Smarket[,-9])
attach(Smarket)
plot(Year,Volume)


# Lets fit logistic regression
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume , data=Smarket ,family=binomial)
summary(glm.fit)
coef(glm.fit)
glm.probs=predict(glm.fit,type="response")
glm.probs[1:10]
contrasts (Direction )
#glm.probs=predict(glm.fit)
#glm.probs[1:10]
glm.pred=rep("Down",1250)
glm.pred[glm.probs >.5]="Up"
table(glm.pred,Direction)
(507+145) /1250 # .5216
# The mean() function can be used to compute the fraction of days for which the prediction was correct
mean(glm.pred==Direction) # .5216

train =(Year <2005)
# held out data
Smarket.2005= Smarket[!train ,]
dim(Smarket.2005)
Direction.2005=Direction[!train]

glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume , data=Smarket ,family=binomial,subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs >.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005) 
mean(glm.pred!=Direction.2005)

# Now trying with lag1 and lag2 as they had highest predictive power
glm.fit=glm(Direction~Lag1+Lag2,data=Smarket ,family=binomial, subset=train)
glm.probs=predict(glm.fit,Smarket.2005,type="response")
glm.pred=rep("Down",252)
glm.pred[glm.probs >.5]="Up"
table(glm.pred,Direction.2005)
mean(glm.pred==Direction.2005)
106/(106+76)
# on days when it predicts an increase in the market, it has a 58 % accuracy rate.
# predicting for particular values
predict(glm.fit,newdata=data.frame(Lag1=c(1.2,1.5), Lag2=c(1.1,-0.8)),type="response")

# LDA code
library(MASS)
lda.fit=lda(Direction~Lag1+Lag2,data=Smarket ,subset=train)
lda.fit
# ??ˆ1 = 0.492 and ??ˆ2 = 0.508
lda.pred=predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class=lda.pred$class
table(lda.class ,Direction.2005)
mean(lda.class==Direction.2005)
sum(lda.pred$posterior[,1]>=.5)
sum(lda.pred$posterior[,1]<.5)

lda.pred$posterior[1:20,1]
lda.class[1:20]

sum(lda.pred$posterior[,1]>.9)

# Quadratic Discriminant Analysis
qda.fit=qda(Direction~Lag1+Lag2,data=Smarket ,subset=train)
qda.fit
qda.class=predict(qda.fit,Smarket.2005)$class
table(qda.class ,Direction.2005)
mean(qda.class==Direction.2005)


# K Nearest Neighbours
library(class)
train.X=cbind(Lag1 ,Lag2)[train ,]
test.X=cbind(Lag1,Lag2)[!train,]
train.Direction =Direction [train]

set.seed (1)
knn.pred=knn(train.X,test.X,train.Direction ,k=1)
summary(knn.pred)
table(knn.pred,Direction.2005)
mean(knn.pred==Direction.2005)


# for k = 3
set.seed (1)
knn.pred=knn(train.X,test.X,train.Direction ,k=3)
summary(knn.pred)
table(knn.pred,Direction.2005)
mean(knn.pred==Direction.2005)


# For caravan dataset
dim(Caravan)
attach(Caravan)
summary(Purchase)
348/5822
standardized.X=scale(Caravan [,-86])
var ( Caravan [ ,1])
var ( Caravan [ ,2])
var(standardized.X[,1])
var(standardized.X[,2])


test =1:1000
train.X=standardized.X[-test ,]
test.X=standardized.X[test ,]
train.Y=Purchase [-test]
test.Y=Purchase [test]
set.seed (1)
knn.pred=knn(train.X,test.X,train.Y,k=1)
mean(test.Y!=knn.pred) [1] 
mean(test.Y!="No")
table(knn.pred,test.Y)
9/(68+9)

knn.pred=knn(train.X,test.X,train.Y,k=3)
table(knn.pred,test.Y)
5/26
knn.pred=knn(train.X,test.X,train.Y,k=5)
table(knn.pred,test.Y)
4/15


# try logistic
glm.fit=glm(Purchase~.,data=Caravan ,family=binomial, subset=-test)
glm.probs=predict(glm.fit,Caravan[test,],type="response")
glm.pred=rep("No",1000)
glm.pred[glm.probs >.5]="Yes"
table(glm.pred,test.Y)

glm.pred=rep("No",1000)
glm.pred[glm.probs >.25]=" Yes"
table(glm.pred,test.Y)
11/(22+11)





