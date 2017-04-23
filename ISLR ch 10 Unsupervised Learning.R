setwd("~/Desktop/MSBAPM/R/R files")

# Unsupervised Learning

# supervised learning methods such as regression and classification

# we are not interested in prediction in unsupervised learning
# principal componenet analysis and clustering
# Unsupervised learning is often performed as part of an exploratory data analysis

# PRINCIPAL COMPONENT ANALYSIS

#To perform principal components regression, we simply use principal components as
# predictors in a regression model in place of the original larger set of variables.
# The first principal component of a set of features X1, X2, . . . , Xp is the 
# normalized linear combination of the features
# Z1 = ??11X1 +??21X2 +...+??p1Xp
# ??11, ..... are known as loadings of the principal components
# together, the loadings make up the principal component loading vector, ??1 = (??11 ??21 ... ??p1)T
# We constrain the loadings so that their sum of squares is equal to one
# here z1 is the score of the principal component
# these z's are the linear combination of x,....xp that has maximum variance 
# out of all linear combinations that are uncorrelated with Z1
# since we are working with the variances, we have to scale the variables before performing PCA
# so scale to sd=1 for all variables
# We typically decide on the number of principal components required to visualize the data by examining 
# a scree plot. Check for the elbow in the curve

# CLUSTERING METHODS

# PCA looks to find a low-dimensional representation of the observations 
# that explain a good fraction of the variance
# Clustering looks to find homogeneous subgroups among the observations
# K-means clustering and hierarchical clustering

# K-means clustering

# 1) Randomly assign a number, from 1 to K, to each of the observations.
# These serve as initial cluster assignments for the observations.
# 2) Iterate until the cluster assignments stop changing:
# a) For each of the K clusters, compute the cluster centroid. 
# The kth cluster centroid is the vector of the p feature means for the observations in the kth cluster.
# (b) Assign each observation to the cluster whose centroid is closest (where closest is defined using Euclidean distance).
# One potential disadvantage of K-means clustering is that it requires us to pre-specify the number of clusters K

# Hierarchical Clustering

# 1) Begin with n observations and a measure (such as Euclidean distance) of all the  nC2  = n(n ??? 1)/2 pairwise 
# dissimilarities. Treat each observation as its own cluster
# 2) Fori=n,n???1,...,2:
# a) Examine all pairwise inter-cluster dissimilarities among the i clusters and identify the pair of clusters 
# that are least dissimilar (that is, most similar). Fuse these two clusters. The dissimilarity between 
# these two clusters indicates the height in the dendrogram at which the fusion should be placed.
# b) Compute the new pairwise inter-cluster dissimilarities among the i???1 remaining clusters.

# linkage defines the dissimilarity between two groups of observations
# The four most common types of linkage—complete, average, single, and centroid
# 1) Complete - Maximal intercluster dissimilarity. Compute all pairwise dissimilarities between the 
# observations in cluster A and the observations in cluster B, and record the largest of these dissimilarities.
# 2) Single - Minimal intercluster dissimilarity. Compute all pairwise dissimilarities between the observations 
# in cluster A and the observations in cluster B, and record the smallest of these dissimilarities. 
# Single linkage can result in extended, trailing clusters in which single observations are fused one-at-a-time.
# 3) Average - Mean intercluster dissimilarity. Compute all pairwise dissimilarities between the observations 
# in cluster A and the observations in cluster B, and record the average of these dissimilarities
# 4) Centroid - Dissimilarity between the centroid for cluster A (a mean vector of length p) and the centroid  
# for cluster B. Centroid linkage can result in undesirable inversions.


# Practical Issues in Clustering

# 1) Should the observations or features first be standardized in some way? For instance, maybe the 
# variables should be centered to have mean zero and scaled to have standard deviation one.
# 2)  In the case of hierarchical clustering,
# – What dissimilarity measure should be used?
# – What type of linkage should be used?
# – Where should we cut the dendrogram in order to obtain clusters?
# 3) In the case of K-means clustering, how many clusters should we look for in the data?

# PCA coding

states = row.names(USArrests)
states
names(USArrests)
colnames(USArrests)
apply(USArrests,2,mean)
sapply(USArrests,mean)
apply(USArrests,2,var)

# we need to standardize as assault has most variance and pca will be driven by assault
# By default, the prcomp() function centers the variables to have mean zero. By using the 
# option scale=TRUE, we scale the variables to have standard deviation one.
pr.out=prcomp(USArrests, scale=TRUE)
# The output from prcomp() contains a number of useful quan- tities.
names(pr.out)
# "sdev"     "rotation" "center"   "scale"    "x" 
# The center and scale components correspond to the means and standard deviations of the variables 
# that were used for scaling prior to implementing PCA.
pr.out$center
pr.out$scale
# The rotation matrix provides the principal component loadings
pr.out$rotation
# matrix x has as its columns the principal component score vectors.
dim(pr.out$x)
# plotting first two principal components
biplot(pr.out, scale=0)
# to get the mirror image
pr.out$rotation=-pr.out$rotation
pr.out$x=-pr.out$x
biplot(pr.out, scale=0)

pr.out$sdev
# variance
pr.var=pr.out$sdev ^2
pr.var
# proportion of variance by each princ component
pve=pr.var/sum(pr.var)
pve
plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained ", ylim=c(0,1),type='b')
plot(cumsum(pve), xlab="Principal Component ", ylab=" Cumulative Proportion of Variance Explained ", 
     ylim=c(0,1), type='b')
# cumsum() computes the cumulative sum of the elements of a numeric vector.


# CLUSTERING CODE
set.seed (2)
x=matrix(rnorm(50*2), ncol=2)
x[1:25,1]=x[1:25,1]+3
x[1:25,2]=x[1:25,2]-4
km.out=kmeans(x = x,centers = 2,nstart=20)
km.out$cluster
plot(x, col=(km.out$cluster +1), main="K-Means Clustering Results with K=2", xlab="", ylab="", pch=20, cex=2)


# lets try for k=3
set.seed (4)
km.out=kmeans(x,3,nstart=20)
km.out
km.out$cluster
plot(x, col=(km.out$cluster +1), main="K-Means Clustering Results with K=3", xlab="", ylab="", pch=20, cex=2)
# nstart is for step 1 of clustering
# randomly assigning initial cluster

set.seed (3)
km.out=kmeans(x,3,nstart=1)
km.out$tot.withinss
# 61.23
km.out=kmeans(x,3,nstart=20) 
km.out$tot.withinss
# 57.67
# km.out$tot.withinss is the total within-cluster sum of squares,
# which we seek to minimize by performing K-means clustering
# The individual within-cluster sum-of-squares are contained in the vector km.out$withinss
km.out$withinss


# Hierarchical Clustering code

#  hclust requires us to provide the data in the form of a distance matrix. We can do this by using dist.
hc.complete=hclust(dist(x), method="complete")
hc.average=hclust(dist(x), method="average")
hc.single=hclust(dist(x), method="single")
# but we will use complete

# now lets plot the dendrogram
par(mfrow=c(1,3))
plot(hc.complete,main="Complete Linkage", xlab="", sub="",cex =.9)
plot(hc.average , main="Average Linkage", xlab="", sub="",cex =.9)
plot(hc.single , main="Single Linkage", xlab="", sub="",cex =.9)

# To determine the cluster labels for each observation associated with a given cut of the dendrogram,
# we can use the cutree()
cutree(hc.complete, 2)
cutree(hc.average,2)
cutree(hc.single,2)

cutree(hc.single , 4)
#To scale the variables before performing hierarchical clustering of the observations, we use the scale()
xsc=scale(x)
plot(hclust(dist(xsc), method="complete"), main="Hierarchical Clustering with Scaled Features ")

# Correlation-based distance can be computed using the as.dist()
x=matrix(rnorm(30*3), ncol=3)
dd=as.dist(1-cor(t(x)))
plot(hclust(dd, method="complete"), main="Complete Linkage with Correlation -Based Distance", xlab="", sub="")

# NCI60 Data Example
library(ISLR)
nci.labs=NCI60$labs 
nci.data=NCI60$data
View(NCI60)
dim(nci.data)
nci.labs[1:4]
table(nci.labs)

# PCA with scaling
pr.out=prcomp(nci.data, scale=TRUE)

# function to plot different cancer types in different color
Cols=function(vec)
  {
  #rainbow() function takes as its argument a positive integer, and returns a 
  # vector containing that number of distinct colors
  cols=rainbow(length(unique(vec)))
  return(cols[as.numeric(as.factor(vec))]) 
  }

a=c(1,1,1,2,2,3,33,4,5,5,6)
Cols(a)
par(mfrow=c(1,2))
plot(pr.out$x[,1:2], col=Cols(nci.labs), pch=19,xlab="Z1",ylab="Z2")
plot(pr.out$x[,c(1,3)], col=Cols(nci.labs), pch=19,xlab="Z1",ylab="Z3")
summary(pr.out)
# we can also plot the variance explained by the first few principal components
plot(pr.out)
# Note that the height of each bar in the bar plot is given by squaring the corresponding element of pr.out$sdev

# scree plot and pve
pve=100*pr.out$sdev^2/sum(pr.out$sdev^2)
par(mfrow=c(1,2))
plot(pve, type="o", ylab="PVE", xlab="Principal Component",col =" blue ")
plot(cumsum(pve), type="o", ylab="Cumulative PVE", xlab="Principal Component ", col =" brown3 ")

# elements of pve
summary(pr.out)$importance[2,]
# elements of cumcum pve
summary(pr.out)$importance[3,]

# Clustering the Observations of the NCI60 Data
sd.data=scale(nci.data)
par(mfrow=c(1,3))
data.dist=dist(sd.data)
plot(hclust(data.dist), labels=nci.labs, main="Complete Linkage", xlab="", sub="",ylab="")
plot(hclust(data.dist, method="average"), labels=nci.labs,main="Average Linkage", xlab="", sub="",ylab="")
plot(hclust(data.dist, method="single"), labels=nci.labs,main="Single Linkage", xlab="", sub="",ylab="")

# lets cut the dendrogram

hc.out=hclust(dist(sd.data))
hc.clusters=cutree(hc.out,4)
table(hc.clusters,nci.labs)

# plotting the cut

par(mfrow=c(1,1))
plot(hc.out, labels=nci.labs) 
abline(h=139, col="red")
hc.out

# comparing hierarchical with k-means

set.seed (2)
km.out=kmeans(sd.data, 4, nstart=20)
km.clusters=km.out$cluster
table(km.clusters ,hc.clusters )

# Rather than performing hierarchical clustering on the entire data matrix, we can 
# simply perform hierarchical clustering on the first few principal component score vectors, as follows:
hc.out=hclust(dist(pr.out$x[,1:5]))
plot(hc.out, labels=nci.labs, main="Hier. Clust. on First Five Score Vectors ")
table(cutree(hc.out,4), nci.labs)
