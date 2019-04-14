
data1<-read.csv(file="C:/Imarticus/Logistics Regression/breast_cancer.csv")
View(data1)
str(data1)
names(data1)
library(ggplot2)
library(gridExtra)
attach(data1)
data1$age<-as.numeric(data1$age)
data1$deg_malig<-as.numeric(data1$deg_malig)
data1$tumor_size<-as.numeric(data1$tumor_size)
data1$inv_nodes<-as.numeric(data1$inv_nodes)
str(data1)
summary(data1)
boxplot(data1)
sapply(data1, function(x) sum(is.na(x))h)

#treatment of outlier for fare
boxplot(data1$age)
summary(data1$age)
upper<-4+1.5*IQR(data1$age);upper
data1$age[data1$age>upper]<-upper
lower<-3-1.5*IQR(data1$age);lower
data1$age[data1$age>lower]<-lower
boxplot(data1$age)
summary(data1$age)

boxplot(data1$tumor_size)
summary(data1$tumor_size)
upper<-7+1.5*IQR(data1$tumor_size);upper
data$tumor_size[data1$tumor_size>upper]<-upper
lower<-5-1.5*IQR(data1$tumor_size);lower
data1$tumor_size[data1$tumor_size>lower]<-lower
boxplot(data1$tumor_size)
summary(data1$tumor_size)

boxplot(data1$inv_nodes)
summary(data1$inv_nodes)
upper<-2+1.5*IQR(data1$inv_nodes);upper
data1$inv_nodes[data1$inv_nodes>upper]<-upper
boxplot(data1$tumor_size)
summary(data1$tumor_size)
boxplot(data1)

#multiple logistic reg
library(caret)
Train<-createDataPartition(data1$irradiat,p=0.7,list=FALSE)
training<-data1[Train,]
testing<-data1[-Train,]

#model building
model=glm(irradiat~., family=binomial, data=training)
summary(model)
Acc(model)

reg.model=step(glm(irradiat~.,family=binomial, data=training), direction="both")
summary(reg.model)
anova(reg.model, test='Chisq')
Acc(reg.model)

#to get odds ratio
library(oddsratio)
library(vcd)
exp(coef(reg.model))

#prediction
testing$probs<-predict(reg.model,testing,type='response')
testing$predict<-as.factor(ifelse(testing$probs>0.70,'1','0'))
table(testing$predict,testing$irradiat)
library(caret)
confusionMatrix(testing$irradiat,testing$Predict)


library(ROCR)
#make prediction on test set
predictTrain=predict(reg.model,testing,type="response")
ROCRpred=prediction(predictTrain,testing$irradiat)
library(caret)
library(e1071)

library(ROCR)

ROCRperf=performance(ROCRpred,"tpr","fpr")
plot(ROCRperf)
