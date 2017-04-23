setwd("~/Desktop/MSBAPM/R/R files")
install.packages("ISLR")
library(ISLR)
library(MASS)

x = c(1,6,2)
x
y = c(1,4,3)
length(x)
length(y)
x+y
# look at the list of the objects
ls()
# remove any function that we don't want
rm(x,y)
ls()
# remove all objects at once
rm(list = ls())
# matrix() function can be used to create a matrix of numbers
?matrix
# creating a matrix'
x = matrix(data = c(1,2,3,4), nrow = 2,ncol = 2)
x
# we could have also created the same matrix by using
x = matrix(c(1,2,3,4),2,2)
x
# byrow =true option can be used to populate the matrix in order of tyhe rows
x = matrix(data = c(1,2,3,4), nrow = 2,ncol = 2,byrow = TRUE)
x
sqrt(x)
x^2
# rnorm creates a vector of random variables
# cor() computes the correlation between two vectors
x = rnorm(50)
y = x + rnorm(50,mean = 50,sd = .1)
cor(x,y)
# by default rnorm creates standard normal variables with a mean of 0 and standard deviation of 1
# we can use set.seed() function to produce the same set of variables next time
set.seed(1303)
rnorm(50)

set.seed(3)
y = rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)

# Graphics
x = rnorm(100)
y = rnorm(100)
plot(x,y,xlab = "This is X axis", ylab = "This is y axis",main = "Plot of X vs Y")
pdf("Figure.pdf")
plot(x,y,col="green")
# dev.off() indicates R that we are done creating a plot
dev.off()
# seq() can be used to create a sequence of numbers
seq(0,1,length =10)
seq(3,11)
seq(3:11)
x = seq(-pi,pi,length = 50)
x
# contour plot = to represent 3 dimensional data
#It takes three arguments:
#1. A vector of the x values (the first dimension),
#2. A vector of the y values (the second dimension), and
#3. A matrix whose elements correspond to the z value (the third dimen- sion) for 
#   each pair of (x,y) coordinates.
?contour
y=x
f = outer(x,y,function(x,y)cos(y)/(1+x^2))
contour(x,y,f)
contour(x,y,f,nlevels = 45,add = T)
fa = (f-t(f))/2
contour(x,y,fa,nlevels = 15)
# image() function works same as contour, it depends a color coded plot based on z = heatmap
#  Alternatively, persp() can be used to produce a three-dimensional plot
# The arguments theta and phi control the angles
image(x,y,fa)
persp(x,y,fa)
persp(x,y,fa,theta = 30)
persp(x,y,fa,theta = 30,phi = 20)
persp(x,y,fa,theta = 30,phi = 70)
persp(x,y,fa,theta = 30,phi = 40)


# indexing data
A = matrix(1:16,4,4)
A
A[2,3]
A[c(1,3),c(2,4)] 
A[1:3,2:4]
A[1:2,]
A[,1:2]

# negative sign tells R to keep all rows and columns except the ones mentioned in the index
A[-c(1,3),]
A[-c(1,3),-c(1,3,4)]

# dim() function gives number of rows and number of columns
dim(A)

# Loading Data
Auto = read.table("Auto.data", header = T, na.strings = "?")
# na.strings tells R to treat ? as missing element of data matrix
# header = t tells that first row is to be considered as headings
# fix function helps us to view data in form of spreadsheet 
fix(Auto)
Auto = read.csv("Auto.csv",header = T,na.strings = "?")
dim(Auto)
fix(Auto)
Auto[1:4,]
# na.omit to remove rows with missing values
Auto= na.omit(Auto)
names(Auto)
colnames(Auto)
# Additional graphs and summaries

attach(Auto)
plot(cylinders,mpg)
# as.factor converts quantitative variables into qualitative variables
cylinders = as.factor(cylinders)
plot(cylinders,mpg,col="red",varwidth = T, xlab="cylinders",ylab="MPG")
hist(mpg,col = 2,breaks=15)
# pairs make scatterplot for every pair of variables
pairs(Auto)
# scatterplot of subset of variables
pairs(~mpg + displacement + horsepower,Auto)
plot(horsepower,mpg)
# using on the points on the plot you can identify the attributes of the particular points
# after clicking on points select finish or press esc
identify(horsepower,mpg,name)
summary(Auto)
savehistory()
