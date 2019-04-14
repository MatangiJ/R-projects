#SVM model for heart data

library(caret)
library(e1071)

heart_df<- read.csv("D:/Others/Downloads/heart.csv")

heart_df$target<-as.factor(heart_df$target)
heart_df$Sex<-as.factor(heart_df$Sex)
heart_df$CP<-as.factor(heart_df$CP)
heart_df$Fbs<-as.factor(heart_df$Fbs)
heart_df$ECG<-as.factor(heart_df$ECG)
heart_df$exang<-as.factor(heart_df$exang)
heart_df$thal<-as.factor(heart_df$thal)
heart_df$Age<-as.numeric(heart_df$Age)
heart_df$Trestbps<-as.numeric(heart_df$Trestbps)
heart_df$Chol<-as.numeric(heart_df$Chol)
heart_df$Thalach<-as.numeric(heart_df$Thalach)
heart_df$oldPeak<-as.numeric(heart_df$oldPeak)
heart_df$slope<-as.numeric(heart_df$slope)
heart_df$ca<-as.numeric(heart_df$ca)

str(heart_df)

intrain<-createDataPartition(heart_df$target, p=0.7, list=FALSE)
training<-heart_df[intrain,]
testing<-heart_df[-intrain,]

summary(training)
sapply(training,function(x) sum(is.na(x)))

svm_model1 <-svm(target~. ,data=training,cost=0.01,scale=FALSE)
summary(svm_model1)
confusionMatrix(svm_model1$fitted,training$target)
testing_pred<-predict(svm_model1,testing)
confusionMatrix(testing_pred,testing$target)

#how to increase accuracy of model =0.1 or 100
tune.out=tune(svm,target~., data=training, kernel="linear", ranges=list(cost=c(0.001, 0.01, 0.1,1,5,10,100)))
summary(tune.out)

#best model
bestmod=tune.out$best.model
summary(bestmod)
#accuracy of model
confusionMatrix(bestmod$fitted, training$target)

#prediction on testing
testing$ypred=predict(bestmod, testing)
table(predict=ypred, truth=testing$target)
#accuracy
confusionMatrix(ypred, testing$target)

