#SVM model
#AIC value is the value how much info i m losing

data<-read.csv("D:/Others/Downloads/diabetes.csv")
data$Outcome<-as.factor(data$Outcome)
#data partition
library(caret)
train<-createDataPartition(data$Outcome, p=0.7, list=FALSE)
training<-data[train,]
testing<-data[-train,]
#model
library(e1071)
svm_model1<-svm(Outcome~.,data=training)
summary(svm_model1)
training$fitted<-svm_model1$fitted
#table(ypred, training$outcome)
confusionMatrix(svm_model1$fitted, training$Outcome)
#accuracy on testing data set 7783
ypred1=predict(svm_model1, testing)
#table(ypred1, testing$Outcome)
confusionMatrix(ypred1, testing$Outcome)


#2nd model
svm_model2<-svm(Outcome~.,data=training, kernal="linear")
summary(svm_model2)
confusionMatrix(svm_model2$fitted, training$Outcome)
ypred1=predict(svm_model2, testing)
confusionMatrix(ypred1, testing$Outcome)