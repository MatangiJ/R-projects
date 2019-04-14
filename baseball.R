library(knitr)
library(tree)
Baseball<-read.csv("D:/Others/Downloads/Baseball.csv")
summary(Baseball)
sapply(Baseball,function(x)sum(is.na(x)))
#model building
tree.fit<-tree(Salary~Hits+Years, data=Baseball)
summary(tree.fit)
plot(tree.fit)
text(tree.fit)
text(tree.fit, pretty=0)
tree.fit
#prediction
yhat<-predict(tree.fit, Baseball)
Hit<-data.frame(Baseball, yhat)
mean((Hit$Salary-Hit$yhat)^2)                #checks the accuracy of predicted and actual (error)
Hit$residual<-Hit$Salary-Hit$yhat
Hit$residual1<-(Hit$residual)^2              #SSE
sum(Hit$residual1)/263
mean(Hit$Salary-Hit$yhat)^2


Baseball<-read.csv("D:/Others/Downloads/Baseball.csv")
hist(Baseball$Salary)
Baseball$Salary<-log(Baseball$Salary)
hist(Baseball$Salary)
tree.fit<-tree(Salary~Hits+Years, data=Baseball)
summary(tree.fit)
plot(tree.fit)
text(tree.fit)
text(tree.fit, pretty=0)
tree.fit
#prediction
yhat<-predict(tree.fit, Baseball)
Hit1<-data.frame(Baseball, yhat)
mean((Hit1$Salary-Hit1$yhat)^2)


Baseball<-read.csv("D:/Others/Downloads/Baseball.csv")
hist(Baseball$Salary)
Baseball$Salary<-log(Baseball$Salary)
hist(Baseball$Salary)
library(caret)
split<-createDataPartition(y=Baseball$Salary, p=0.7, list=FALSE)
train<-Baseball[split,]
test<-Baseball[-split,]

trees<-tree(Salary~., train)
plot(trees)
text(trees,pretty=0)
yhat<-predict(trees, test)
Hit1<-data.frame(test, yhat)
mean((Hit1$Salary-Hit1$yhat)^2)                #mean(y-yhat)^2 :error

cv.trees<-cv.tree(trees)                       #cross validation(cv)
plot(cv.trees$size, cv.trees$dev, type="b")
prune.trees<-prune.tree(trees, best=6)
plot(prune.trees)
text(prune.trees,pretty=0)
#prediction
yhat<-predict(prune.trees,test)
Hit2<-data.frame(test, yhat)
mean((Hit2$Salary-Hit2$yhat)^2)

