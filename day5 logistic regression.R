#Predict which customers will default

Credit<-read.csv("D:/Others/Downloads/Credit_Card.csv")
View(Credit)
str(Credit)
names(Credit)

library(ggplot2)
library(gridExtra)
attach(Credit)
Credit$target_30<-as.factor(ifelse(Credit$DPD>30,1,0))
Credit$target_60<-as.factor(ifelse(Credit$DPD>60,1,0))
Credit$target_90<-as.factor(ifelse(Credit$DPD>90,1,0))
table(Credit$target_30)
4922/10000
table(Credit$target_60)
333/10000
table(Credit$target_90)
162/10000

Credit<-Credit[-c(4,5,7)]
#simple logistic regression
logit<-glm(target_60~balance,data=Credit,
           family=binomial(link="logit"))
summary(logit)
anova(logit,test='Chisq')
#prediction try with 2000
testing<-data.frame(balance=2000)
testing.probs<-predict(logit,testing,type='response')      #response will give the probability
testing.probs



#simple logistics regresion
library(caret)
Train<-createDataPartition(Credit$target_60,p=0.7, list=FALSE)
training<-Credit[Train,]
testing<-Credit[-Train,]
logit<-glm(target_60~balance, data=training, family='binomial')
summary(logit)
Acc(logit)

##prediction
testing$probs<-predict(logit, testing, type='response')
testing$Predict<-as.factor(ifelse(testing$probs>0.70,1,0))
table(testing$Predict, testing$target_60)
library(e1071)
confusionMatrix(testing$Predict, testing$target_60)

#ROC Curve
library(ROCR)
#make predictions on training set
predictTrain=predict(logit, testing, type="response")
#predict function
ROCRpred=prediction(predictTrain,testing$target_60)
#performance function
ROCRperf=performance(ROCRpred,"tpr","fpr")
#plot ROC Curve
plot(ROCRperf)
library(ROCR)
pred=prediction(testing$probs, testing$target_60)
as.numeric(performance(pred, "auc")@y.values)









Credit<-read.csv("D:/Others/Downloads/Credit_Card.csv")
Credit$target_60<-as.factor(ifelse(Credit$DPD>60,1,0))
Credit$Dummy<-as.factor(ifelse(Credit$Gender=='M',1,0))
Credit$DPD<-NULL
Credit$Gender<-NULL

#Multiple Log reg
library(caret)
Train<-createDataPartition(Credit$target_60,p=0.7,list=FALSE)
training<-Credit[Train,]
testing<-Credit[-Train,]
logit<-glm(target_60~income+balance+Dummy, family='binomial',data=training); logit
summary(logit)
Acc(logit)
logit2<-step(glm(target_60~income+balance+Dummy, family='binomial',data=training), direction='both')
summary(logit2)
Acc(logit2)
y=-11.62+0.00583*817.18041+0.6946*0
y
a<-exp(-y)
b<-1+a
c<-1/b
c

testing$probs <-predict(logit,testing,type='response')
testing$predict<-as.factor(ifelse(testing$probs>0.70,1,0))
table(testing$predict, testing$target_60)
library(e1071)
confusionMatrix(testing$target_60,testing$predict)

testing$probs<-predict(logit, testing, type='response')
testing$Predict<-as.factor(ifelse(testing$probs>0.70,1,0))
table(testing$Predict, testing$target_60)
confusionMatrix(testing$Predict, testing$target_60)

#ROC Curve
library(ROCR)
#make predictions on training set
predictTrain=predict(logit, testing, type="response")
#predict function
ROCRpred=prediction(predictTrain,testing$target_60)
#performance function
ROCRperf=performance(ROCRpred,"tpr","fpr")
#plot ROC Curve
plot(ROCRperf)
library(ROCR)
pred=prediction(testing$probs, testing$target_60)       #prediction is used to generate tpr,fpr,type1&2 error
as.numeric(performance(pred, "auc")@y.values)           #to find area under curve











#new Example 2  
data<-read.csv("D:/Others/Downloads/Application.csv")
table(data$fgood)
names(data)
str(data)
#data conversion as per model requirement
data$cbs1<-as.numeric(data$cbs1)
data$cbinq<-as.numeric(data$cbinq)
data$cbline<-as.numeric(data$cbline)
data$cbterm<-as.numeric(data$cbterm)
data$cblineut<-as.numeric(data$cblineut)
data$cbtob<-as.numeric(data$cbtob)

data$fgood<-as.factor(data$fgood)
data$pmt<-as.factor(data$pmt)
data$cbdpd<-as.factor(data$cbdpd)
data$home<-as.factor(data$home)
data$online<-as.factor(data$online)
data$cbnew<-as.factor(data$cbnew)

str(data)
boxplot(data$cblineut)
summary(data$cblineut)
upper<-54.089+1.5*IQR(data$cblineut);upper
data$cblineut[data$cblineut>upper]<-upper
lower<-37.734-1.5*IQR(data$cblineut);lower
data$cblineut[data$cblineut>lower]<-lower
boxplot(data$cblineut)
summary(data$cblineut)

sapply(data,function(x) sum(is.na(x)))
data$cbs1[is.na(data$cbs1)]<-1
sapply(data,function(x) sum(is.na(x)))

library(caret)
Train<-createDataPartition(data$fgood,p=0.7,list=FALSE)
training<-data[Train, ]
testing<-data[-Train, ]
classifier=step(glm(fgood~.-period, family='binomial',data=training))
summary(classifier)
Acc(classifier)
#odds ratio only
exp(coef(classifier))                       #find odds ratio
#prediction
testing$probs<-predict(classifier,testing,type='response')
testing$Predict<-as.factor(ifelse(testing$probs>0.70,'1','0'))
table(testing$Predict,testing$fgood)
library(caret)
library(e1071)
confusionMatrix(testing$Predict,testing$fgood)
library(ROCR)

predictTrain=predict(classifier,testing,type="response")
ROCRpred=prediction(predictTrain, testing$good)
ROCRperf=performance(ROCRpred,"tpr","fpr")
plot(ROCRperf)


#Example 3

data2<-subset(data,fgood==1)
data3<-data[1:500,]
data4<-rbind(data2,data3)
library(caret)
Train<-createDataPartition(data$fgood,p=0.7,list=FALSE)
training<-data[Train, ]
testing<-data[-Train, ]