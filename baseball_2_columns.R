Baseball<-read.csv("D:/Others/Downloads/Baseball.csv")
hist(Baseball$Salary)
Baseball$Salary<-log(Baseball$Salary)
hist(Baseball$Salary)
library(caret)
split<-createDataPartition(y=Baseball$Salary, p=0.7, list=FALSE)
train<-Baseball[split,]
test<-Baseball[-split,]

trees<-tree(Salary~Hits+Years, train)
plot(trees)
text(trees,pretty=0)
yhat<-predict(trees, test)
Hit1<-data.frame(test, yhat)
mean((Hit1$Salary-Hit1$yhat)^2)                #mean(y-yhat)^2 :error

cv.trees<-cv.tree(trees)
plot(cv.trees$size, cv.trees$dev, type="b")
prune.trees<-prune.tree(trees, best=5)
plot(prune.trees)
text(prune.trees,pretty=0)
#prediction
yhat<-predict(prune.trees,test)
Hit2<-data.frame(test, yhat)
mean((Hit2$Salary-Hit2$yhat)^2)
