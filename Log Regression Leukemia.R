#to predict whether the patient responded to the treatment or not.

leukemia<-read.csv("D:/Others/Downloads/Leukemia.csv")
names(leukemia)
str(leukemia)

leukemia$Resp=as.factor(leukemia$Resp)
leukemia$Resp=as.factor(leukemia$Resp)
#test$Pclass=as.factor(test$Pclass)
#train$Survived=as.factor(train$Survived)
#test$Survived=as.factor(test$Survived)

summary(leukemia)
summary(leukemia$Blasts)
sapply(leukemia,function(x) sum(is.na(x)))


#age that are less than 1
#train[which(train$Age < 1), 'Age']
#test[which(train$Age < 1), 'Age']
#sapply(train,function(x) sum(is.na(x)))
#sapply(test,function(x) sum(is.na(x)))

#test=test[!is.na(test$Fare),]

train1=subset(leukemia, select=c(2,3,4,5,6,8))
#test1=subset(test, select=c(2,4,5,6,7,9,11))
boxplot(train1)
#treatment of outlier for fare
boxplot(train1$Blasts)
summary(train1$Blasts)
upper<-9.950+1.5*IQR(train1$Blasts);upper
train1$Blasts[train1$Blasts>upper]<-upper
boxplot(train1$Blasts)
summary(train1$Blasts)

#model building
model=glm(Resp~., family=binomial, data=train1)
summary(model)

reg.model=step(glm(Resp~.,family=binomial, data=train1), direction="both")
summary(reg.model)
anova(reg.model, test='Chisq')

#way of giving own reference
#table(train1$Pclass)
#table(train1$Sex)

#model building
#reg.model1=step(glm(Survived~relevel(Pclass,ref=2)+relevel(Sex,ref='female')+Age+Fare+SibSp+Parch, family='binomial', data=train1), direction="both")
#summary(reg.model1)
#anova(reg.model1, test='Chisq')
Acc(reg.model)
#to check multi collinearity
library(car)
vif(reg.model)                #checks collinearity
#to get odds ratio
library(oddsratio)
library(vcd)
exp(coef(reg.model))

#prediction
train1$probs<-predict(reg.model, train1, type='response')
train1$predict<-as.factor(ifelse(train1$probs>0.5,1,0))
table(train1$Resp, train1$predict)
library(caret)
confusionMatrix(train1$Resp, train1$predict)

library(ROCR)
#make predictions on test set
predictTrain= predict(reg.model, train1, type="response")     #response gives probability
#prediction function
ROCRpred=prediction(predictTrain, train1$Resp)
#performance function
ROCRperf=performance(ROCRpred, "tpr","fpr")
#plotting ROC curve
plot(ROCRperf)

