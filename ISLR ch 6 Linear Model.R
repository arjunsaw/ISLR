setwd("~/Desktop/MSBAPM/R/R files")

# use least squares to fit
# if n>= p, i.e if the total number of observations are greater than the number of variables,
# then least square estimates tend to have low variance and hence will perform on test observations
# If n is not much larger than p , then there can be lot of variability in least squares fit,
# resulting in overfitting and poor predictions 
# if p > n the variance is infinite and we cannot use this method

# Alternatives to use least squares fit
# subset selection - here we run least square on a subset of variables
# Shrinkage - This involves fitting a model using all variables. estimated coefficients are 
# shrunken towards zero relative to least squares estimates.
# Dimension Reduction - This approach involves projecting the p predictors into a M-dimensional 
# subspace, where M < p. This is achieved by computing M different linear combinations, or 
# projections, of the variables. Then these M projections are used as predictors to fit a linear 
# regression model by least squares.

# Subset Selection
# Best Subset selection process # Algorithm
# 1) Let M0 denote the null model, which contains no predictors. This
# model simply predicts the sample mean for each observation.
# 2) For k = 1,2,....p:
#   (a) fit all pCk models that contain exactly k predictors
#   (b) Pick the best among these pCk models and call it Mk. Here best is defined as having the 
#      smallest RSS, or having the equivalently largest R2
# 3) Select a single best model from among M0,....Mp using cross validated prediction error,
# Cp, AIC, BIC, or adjusted R2


# Forward Stepwise Selection
# Forward stepwise selection begins with a model containing no predictors, and then adds predictors  
# to the model,one-at-a-time, until all of the predictors are in the model.
# Algorithm
# 1) Let M0 denote the null model, which contains no predictors.
# 2) For k=0,...,p-1:
#   a) Consider all p-k models that augment the predictors in Mk with one additional predictor.
#   b) Choose the best among these p-k models, and call it Mk+1. Here best is defined as having 
#      smallest RSS or highest R2
# 3) Select a single best model from among M0,....Mp using cross validated prediction error,
# Cp, AIC, BIC, or adjusted R2

# Backward Stepwise Selection
# it begins with the full least squares model containing all p predictors, and then iteratively 
# removes the least useful predictor, one-at-a-time.
# Algorithm
# 1) Let Mp denote the full model, which contains all p predictors.
# 2) For k=p,p-1,...,1:
#   a) Consider all k models that contain all but one of the predictors in Mk, 
#      for a total of k-1 predictors.
#   b) Choose the best among these k models, and call it  Mk-1. Here best is defined as having 
#      smallest RSS or highest R2
# 3) Select a single best model from among M0,....Mp using cross validated prediction error,
# Cp, AIC, BIC, or adjusted R2

# Choosing the optimal model
# In order to select the best model with respect to test error, we need to estimate this test error. 
# There are two common approaches:
# 1. We can indirectly estimate test error by making an adjustment to the training error to account 
#    for the bias due to overfitting.
# 2. We can directly estimate the test error, using either a validation set approach or a 
#    cross-validation approach

# a number of techniques for adjusting the training error for the model size are available. These 
# approaches can be used to select among a set of models with different numbers of variables.
# Cp, Akaike information criterion (AIC), Bayesian information criterion(BIC),and adjustedR2.

# Cp = (RSS + 2*d*sigma^2)/n
# RSS = residual sum of squares or SSE (sum of squared errors)SSE= sum((a-m)^2) 
# d = no of predictors
# sigma = estimate of variance of error associated with each response
# Essentially, the Cp statistic adds a penalty of 2*d*sigma^2 to the training RSS in order to adjust 
# for the fact that the training error tends to underestimate the test error. 
# Cp statistic tends to take on a small value for models with a low test error, so when determining 
# which of a set of models is best, we choose the model with the lowest Cp value.

# AIC = (RSS + 2*d*sigma^2)/n*sigma^2
# The AIC criterion is defined for a large class of models fit by maximum likelihood.

# BIC = (RSS + log(n)*d*sigma^2)/n
# Since log n > 2 for any n > 7, the BIC statistic generally places a heavier penalty on models with 
# many variables, and hence results in the selection of smaller models than Cp.

# Adjusted R2
# For a least squares model with d variables, the adjusted R2 statistic is calculated as
# R2 = 1 - SST/SSE
# Adjusted R2 = 1 - (SST/(n-d-1) / SSE/(n-1))
# Unlike Cp, AIC, and BIC, for which a small value indicates a model with a low test error, a large 
# value of adjusted R2 indicates a model with a small test error.
# so as we keep on adding noisy variables i.e d increases SST/n-d-1 increases and our Adjusted R2
# decreases, so model woth largest Adjusted R2 will have minimal nosiy variables

# Validation and Cross Validation - A better approach to select the model.

# Shrinkage Methods

# As an alternative, we can fit a model containing all p predictors using a technique that 
# constrains or regularizes the coefficient estimates, or equivalently, that shrinks the coefficient 
# estimates towards zero.shrinking the coefficient estimates can significantly reduce their variance. 
# The two best-known techniques for shrinking the regression coefficients towards zero are ridge 
# regression and the lasso.

# RIDGE Regression

































