#to predict survival of passengers

train<-read.csv("D:/Others/Downloads/train.csv")
test<-read.csv("D:/Others/Downloads/test.csv")
test_1<-read.csv("D:/Others/Downloads/test_1.csv")
test=merge(test, test_1, by="PassengerId")
names(train)
str(train)

train$Pclass=as.factor(train$Pclass)
test$Pclass=as.factor(test$Pclass)
train$Survived=as.factor(train$Survived)
test$Survived=as.factor(test$Survived)

str(train)
summary(train)
summary(train$Age)
sapply(train,function(x) sum(is.na(x)))
sapply(test,function(x) sum(is.na(x)))

train$Age[is.na(train$Age)]=mean(train$Age, na.rm=TRUE)
test$Age[is.na(test$Age)]=mean(test$Age, na.rm=TRUE)         #replace missing values with mean
names(train)

#age that are less than 1
train[which(train$Age < 1), 'Age']
test[which(train$Age < 1), 'Age']
sapply(train,function(x) sum(is.na(x)))
sapply(test,function(x) sum(is.na(x)))

test=test[!is.na(test$Fare),]

train1=subset(train, select=c(2,3,5,6,7,8,10))
test1=subset(test, select=c(2,4,5,6,7,9,11))

#treatment of outlier for fare
boxplot(train1$Fare)
summary(train1$Fare)
upper<-31+1.5*IQR(train$Fare);upper
train1$Fare[train1$Fare>upper]<-upper
boxplot(train1$Fare)
summary(train1$Fare)

#treatment of outlier for Age and business logic
boxplot(train1$Age)
summary(train1$Age)
upper<-35+1.5*IQR(train$Age);upper
train1$Age[train1$Age>upper]<-upper
lower<-22.00-1.5*IQR(train$Age);lower
train1$Age[train1$Age<lower]<-lower
boxplot(train1$Age)
summary(train1$Age)

#model building
model=glm(Survived~., family=binomial, data=train1)
summary(model)

reg.model=step(glm(Survived~.,family=binomial, data=train), direction="both")
summary(reg.model)
anova(reg.model, test='Chisq')

#way of giving own reference
table(train1$Pclass)
table(train1$Sex)

#model building
reg.model1=step(glm(Survived~relevel(Pclass,ref=2)+relevel(Sex,ref='female')+Age+Fare+SibSp+Parch, family='binomial', data=train1), direction="both")
summary(reg.model1)
anova(reg.model1, test='Chisq')
Acc(reg.model1)
#to check multi collinearity
library(car)
vif(reg.model1)                #checks collinearity
#to get odds ratio
library(oddsratio)
library(vcd)
exp(coef(reg.model1))

#prediction
test1$probs<-predict(reg.model1, test1, type='response')
test1$predict<-as.factor(ifelse(test1$probs>0.70,1,0))
table(test1$Survived, test1$predict)
library(caret)
confusionMatrix(test1$Survived, test1$predict)

library(ROCR)
#make predictions on test set
predictTrain= predict(reg.model1, test1, type="response")     #response gives probability
#prediction function
ROCRpred=prediction(predictTrain, test1$Survived)
#performance function
ROCRperf=performance(ROCRpred, "tpr","fpr")
#plotting ROC curve
plot(ROCRperf)
