setwd("~/Desktop/MSBAPM/R/R files")
# q8
College = read.csv("~/Desktop/MSBAPM/R/R files/ISLR Data/College.csv")
dim(College)
rownames(College) = College[,1]
View(College)
College = College[,-1]
fix(College)
summary(College)
pairs(College[1:10])
pairs(College)
plot(College$Private,College$Outstate)
Private = as.factor(College$Private)
boxplot(College$Outstate,College$Private)
Elite = rep("No",nrow(College))
Elite[College$Top10perc>50] = "Yes"
College = data.frame(College,Elite)
summary(College$Elite)
plot(College$Elite,College$Outstate)
#With the par( ) function, you can include the option mfrow=c(nrows, ncols) to 
#create a matrix of nrows x ncols plots that are filled in by row.
#mfcol=c(nrows, ncols) fills in the matrix by columns.
par(mfrow=c(2,2))
hist(College$Outstate)
hist(College$Grad.Rate)
hist(College$Accept)
hist(College$Enroll)
hist(College$PhD)


# q9

Auto = read.csv("~/Desktop/MSBAPM/R/R files/ISLR Data/Auto.csv")
View(Auto)
dim(Auto)
colnames(Auto)
str(Auto)
attach(Auto)
range(list(mpg,cylinders,displacement,weight,acceleration,year,origin))
range(mpg)
range(Auto[,1:3])
mean(mpg)
sd(mpg)

s1 = Auto[c(1:9,86:397),]
View(s1)
range(s1$mpg)
mean(s1$mpg)
sd(s1$mpg)
cylinders = as.factor(cylinders)
plot(cylinders,horsepower)
plot(year,mpg)
cor(mpg,weight)
sapply(Auto[,5:7],range)
library(psych)
corr.test(Auto[1:3])
pairs.panels(Auto[1:7])
q()
detach(Auto)
# q 10
library(MASS)
attach(Boston)
View(Boston)
dim(Boston)
plot(age,indus)
?Boston
pairs(Boston[1:5])
plot(Boston$age, Boston$crim)
# Older homes, more crime
plot(Boston$dis, Boston$crim)
# Closer to work-area, more crime
plot(Boston$rad, Boston$crim)
# Higher index of accessibility to radial highways, more crime
plot(Boston$tax, Boston$crim)
# Higher tax rate, more crime
plot(Boston$ptratio, Boston$crim)
# Higher pupil:teacher ratio, more crime
