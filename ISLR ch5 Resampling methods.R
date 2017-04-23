# vaidation set approach

library(ISLR)
set.seed (1)
train=sample(392,196)
# we use subset option to apply lm only in training subset
lm.fit=lm(mpg~horsepower ,data=Auto,subset=train)

attach(Auto)
# MSE
mean((mpg-predict(lm.fit,Auto))[-train]^2)
# for polynomial function
lm.fit2=lm(mpg~poly(horsepower ,2),data=Auto,subset=train)
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
# for cubic regression
lm.fit3=lm(mpg~poly(horsepower ,3),data=Auto,subset=train)
mean((mpg-predict(lm.fit3,Auto))[-train]^2)

# Leave one out cross validation
# if we use glm function without specifying any class , it is equivalent to linear regression
glm.fit=glm(mpg~horsepower ,data=Auto)
coef(glm.fit)

lm.fit=lm(mpg~horsepower ,data=Auto) 
coef(lm.fit)

# we are using glm because we can use cv.glm with this
library(boot)
glm.fit=glm(mpg~horsepower ,data=Auto)
cv.err=cv.glm(Auto,glm.fit)
# this shows the cross validation results
cv.err$delta

cv.error=rep(0,5)
for (i in 1:5){
    glm.fit=glm(mpg~poly(horsepower ,i),data=Auto)
    cv.error[i]=cv.glm(Auto,glm.fit)$delta[1] 
    }
cv.error


# K- cross validation 

set.seed(17)
cv.error.10=rep(0,10)
for (i in 1:10){
   glm.fit=glm(mpg~poly(horsepower ,i),data=Auto)
  cv.error.10[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
   }
cv.error.10

# The bootsrap

# the function takes as input the (X,Y) data as well as a vector indicating 
# which observations should be used to estimate ??.
# alpha is choosen to minimze risk or variance
alpha.fn=function(data,index)
  {
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y))) 
  }

alpha.fn(Portfolio ,1:100)
# bootstrap
set.seed (1)
alpha.fn(Portfolio,sample(100,100,replace=T))

# boot() automates this approach
boot(Portfolio ,alpha.fn,R=1000)
# we need a test statistic to give to boot function
# this function returns intercept and slope estimates
boot.fn=function(data,index)
+return(coef(lm(mpg~horsepower ,data=data,subset=index)))

boot.fn(Auto ,1:392)
# with replacement
boot.fn(Auto,sample(392,392,replace=T))
# boot gives us the standard errors of 1000 bootstrap estimates
boot(Auto ,boot.fn ,1000)
summary(lm(mpg~horsepower ,data=Auto))$coef


# for quadratic model
boot.fn=function(data,index)
  + coefficients(lm(mpg~horsepower+I(horsepower^2),data=data,
                    subset=index))
set.seed (1)
boot(Auto ,boot.fn ,1000)
summary(lm(mpg~horsepower+I(horsepower^2),data=Auto))$coef

