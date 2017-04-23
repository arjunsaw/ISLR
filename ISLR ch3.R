setwd("~/Desktop/MSBAPM/R/R files")

Advertising = read.csv("~/Desktop/MSBAPM/R/R files/ISLR Data/Advertising.csv")

fit = lm(Sales ~ TV, data = Advertising)
summary(fit)

plot(Advertising$TV, Advertising$Sales)

fit = lm(Sales ~ Radio, data = Advertising)
summary(fit)

fit = lm(Sales ~ Newspaper, data = Advertising)
summary(fit)

fit = lm(Sales ~ ., data = Advertising)
summary(fit)

cor(Advertising)
