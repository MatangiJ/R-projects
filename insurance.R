data$region<-NULL
names(data)
str(data)
data$age<-as.numeric(data$age)
data$children<-as.numeric(data$children)
table(data$smoker)
table(data$sex)
data$smoker_flag<-ifelse(data$smoker=='yes',1,2)
data$sex_flag<-ifelse(data$sex=='male',2,1)
data$smoker_flag<-as.numeric(data$smoker_flag)
data$sex_flag<-as.numeric(data$sex_flag)
data$Month<-as.numeric(data$Month)
str(data)
#to check outlier
boxplot(data$age)
boxplot(data$bmi)
boxplot(data$children)
boxplot(data$charges)
boxplot(data$Month)
#treatment for outlier for bmi
summary(data$bmi)
upper<-34.69+1.5*IQR(data$bmi);upper
data$bmi[data$bmi>upper]<-upper
boxplot(data$bmi)
summary(data$bmi)
#treatment of outlier for charges
summary(data$charges)
upper<-16640+1.5*IQR(data$charges);upper
data$charges[data$charges>upper]<-upper
boxplot(data$charges)
summary(data$charges)
abc<-data[,-c(2,5)]
#data partition
library(caret)
Train<-createDataPartition(abc$charges,p=0.70,list=FALSE)
training<-abc[Train, ]
testing<-abc[-Train, ]

cor(training)
model<-lm(charges~.,data=abc)   #changed training to abc
summary(model)
library(car)
vif(model)
par(mfrow=c(2,2))
plot(model)

#model2
hist(abc$charges)
hist(1/abc$charges)
hist(log(abc$charges))
model2<-step(lm(log(charges)~.,data=abc),direction="backward")
summary(model2)
#multi collinearity
vif(model2)
#assumption
par(mfrow=c(2,2))
plot(model2)
library(lmtest)
dwtest(model2)
library(car)
ncvTest(model2)
#prediction
testing$fitted<-predict(model2,testing)
testing$original<-exp(testing$fitted)