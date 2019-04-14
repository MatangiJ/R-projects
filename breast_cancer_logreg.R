#Logistic regression on breast cancer data

cancer<-read.csv("C:/Users/Prakruti Joshi/Desktop/cancer2.txt")
View(cancer)
str(cancer)

cancer$tumor.size<-as.numeric(cancer$tumor.size)
cancer$inv.nodes<-as.numeric(cancer$inv.nodes)
cancer$node.caps<-as.factor(cancer$node.caps)
cancer$deg.malig<-as.numeric(cancer$deg.malig)
cancer$age<-as.numeric(cancer$age)
sapply(cancer,function(x) sum(is.na(x)))
str(cancer)
summary(cancer)
boxplot(cancer)
#table(cancer$class)

#age outliers
upper<-4+1.5*IQR(cancer$age);upper
cancer$age[cancer$age>upper]<-upper
lower<-3-1.5*IQR(cancer$age);lower
cancer$age[cancer$age<lower]<-lower
#boxplot(cancer$age)

#tumor size outliers
upper<-6+1.5*IQR(cancer$tumor.size);upper
cancer$tumor.size[cancer$tumor.size>upper]<-upper

#inv.nodes outliers
upper<-2+1.5*IQR(cancer$inv.nodes);upper
cancer$inv.nodes[cancer$inv.nodes>upper]<-upper

boxplot(cancer)
#node caps outliers
#upper<-2+1.5*IQR(cancer$node.caps);upper
#cancer$node.caps[cancer$node.caps>upper]<-upper
#lower<-2-1.5*IQR(cancer$node.caps);lower
#cancer$node.caps[cancer$node.caps<lower]<-lower

#breast quad outliers
#upper<-4+1.5*IQR(cancer$breast_quad);upper
#cancer$breast_quad[cancer$breast_quad>upper]<-upper
#lower<-3-1.5*IQR(cancer$breast_quad);lower
#cancer$breast_quad[cancer$breast_quad<lower]<-lower

#irrad outliers
#upper<-1+1.5*IQR(cancer$irradiat);upper
#cancer$irradiat[cancer$irradiat>upper]<-upper

library(caret)

Train<-createDataPartition(cancer$class,p=0.7,list=FALSE)
training<-cancer[Train,]
testing<-cancer[-Train,]
#table(training$class)

#up sampling
#set.seed(100)
#up_train <- upSample(x = training[, colnames(training) %ni% "class"],
                     #y = training$class)

#table(up_train$Class)

logit <- glm(class ~., family = "binomial", data=training);logit
summary(logit)
#pred <- predict(logitmod, newdata = testData, type = "response")

Acc(logit)
#y=-11.62+0.00583*817.18041+0.6946*0
#y
#a<-exp(-y)
#b<-1+a
#c<-1/b
#c

reg.model=step(glm(class~.,family=binomial, data=training), direction="forward")
summary(reg.model)
anova(reg.model, test='Chisq')
Acc(reg.model)

#to get odds ratio
library(oddsratio)
library(vcd)
exp(coef(reg.model))

#prediction
testing$probs <-predict(reg.model,testing,type='response')
testing$predict<-as.factor(ifelse(testing$probs>0.70,1,0))
table(testing$predict, testing$class)
library(e1071)
confusionMatrix(testing$class,testing$predict)

#ROC Curve
library(ROCR)
#make predictions on training set
predictTrain=predict(logit, testing, type="response")
#predict function
ROCRpred=prediction(predictTrain,testing$class)
#performance function
ROCRperf=performance(ROCRpred,"tpr","fpr")
#plot ROC Curve
plot(ROCRperf)
library(ROCR)
pred=prediction(testing$probs, testing$class)       #prediction is used to generate tpr,fpr,type1&2 error
as.numeric(performance(pred, "auc")@y.values)           #to find area under curve

