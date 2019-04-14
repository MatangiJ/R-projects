library(tree)
sales_data<-read.csv("D:/Others/Downloads/Sales data.csv")
View(sales_data)
summary(sales_data$Sales)
sales_data$High=as.factor(ifelse(sales_data$Sales<=8,0,1))
sales_data$Sales<-NULL
data<-sales_data
rm(sales_data)
sapply(data,function(x)sum(is.na(x)))
#data partition
library(caret)
split<-createDataPartition(y=data$High, p=0.7, list=FALSE)
train<-data[split,]
test<-data[-split,]
#building model
tree.data=tree(High~., data=train)
plot(tree.data)
text(tree.data, pretty=0)
tree.data
tree.pred=predict(tree.data, test, type="class")
table(tree.pred, test$High)
library(caret)
confusionMatrix(tree.pred, test$High)
#function cv.tree() performs cross validation in order to determine the optimal level of complexity

cv.data=cv.tree(tree.data, FUN=prune.misclass)
names(cv.data)
plot(cv.data$size, cv.data$dev, type="b")
prune.data=prune.misclass(tree.data, best=11)
plot(prune.data)
text(prune.data, pretty=0)
tree.pred=predict(prune.data, test, type="class")
table(tree.pred, test$High)
confusionMatrix(tree.pred, test$High)
#changing cost function and check the performance
prune.data1=prune.misclass(tree.data, best=10)
plot(prune.data1)
text(prune.data1, pretty=0)
tree.pred1=predict(prune.data1, test, type="class")
confusionMatrix(tree.pred1, test$High)
