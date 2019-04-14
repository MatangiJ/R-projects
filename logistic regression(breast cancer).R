###LOGISTIC REGRESSION ON BREAST CANCER
data1<-read.csv(file.choose())
str(data1)
summary(data1)

##checking for missing values 
sapply(data1,function(x) sum(is.na(x))) 


##data1=subset(data,select = c(2,3,4,5,7,8,10))
boxplot(data1)
data1$age<-as.numeric(data1$age)
data1$tumorsz<-as.numeric(data1$tumorsz)
data1$invnodes<-as.numeric(data1$invnodes)
data1$irradiate<-as.factor(ifelse(data1$irradiate=="no",0,1))

#treatment of outlier for age
boxplot(data1$age)
summary(data1$age)
upper<-4+1.5*IQR(data1$age);upper
data1$age[data1$age>upper]<-upper
lower<-3-1.5*IQR(data1$age);lower
data1$age[data1$age<lower]<-lower
boxplot(data1$age)
summary(data1$age)


#treatment of outlier for tumor size
boxplot(data1$tumorsz)
summary(data1$tumorsz)
upper<-7+1.5*IQR(data1$tumorsz);upper
data1$tumorsz[data1$tumorsz>upper]<-upper
lower<-5-1.5*IQR(data1$tumorsz);lower
data1$tumorsz[data1$tumorsz<lower]<-lower
boxplot(data1$tumorsz)
summary(data1$tumorsz)

#treatment of outlier for invnodes
boxplot(data1$invnodes)
summary(data1$invnodes)
upper<-2+1.5*IQR(data1$invnodes);upper
data1$invnodes[data1$invnodes>upper]<-upper
boxplot(data1$invnodes)
summary(data1$invnodes)



data1$breastquad<-NULL

boxplot(data1)


##data partition
library(caret)
train<-createDataPartition(data1$irradiate,p=0.7,list=FALSE)
#list=false because we data column wise not row wise
training<-data1[train,]
testing<-data1[-train,]


##fitting logistic regression to the training set
model<-step(glm(irradiate~.,family='binomial',data = training),direction = "both")
summary(model)
Acc(model)
##80.39% accuracy

##odds ratio
exp(coef(model))

##prediction
testing$probs<-predict(model,testing,type='response')
testing$Predict<-as.factor(ifelse(testing$probs>0.70,1,0))
table(testing$irradiate,testing$Predict)
library(caret)
confusionMatrix(testing$irradiate,testing$Predict)
##77.11% accuracy

library(ROCR)

#make predictions on test set
predictTrain=predict(model,testing,type="response")
#prediction function
ROCRpred=prediction(predictTrain,testing$irradiate)
##performance function is used to fetch the output from ROCRpred and show the sensitivity and specificity
ROCRperf=performance(ROCRpred,"tpr","fpr")
#plot ROC curve
plot(ROCRperf)
##how many data you are able to fetch under the curve is called area under the curve


