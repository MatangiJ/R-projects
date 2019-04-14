data2<-subset(data, fgood ==1)
data3<-data[1:500,]
data4<-rbind(data2,data3)
###Multiple Logistic Regression
library(caret)
Train <- createDataPartition(data4$fgood, p=0.7, list=FALSE)
training <- data4[ Train, ]
testing <- data4[ -Train, ]
# Fitting Logistic Regression to the Training set
classifier =glm(fgood ~ .-period,family = binomial,data = training)
summary(classifier)
Acc(classifier)
## odds ratios only
exp(coef(classifier))
## Prediction
testing$probs <-predict(classifier, testing, type='response')
testing$Predict<-as.factor(ifelse(testing$probs>0.70,'1','0'))
table(testing$Predict, testing$fgood)
library(caret)
library(e1071)
confusionMatrix(testing$Predict, testing$fgood)
library(ROCR)
# Make predictions on test set
predictTrain = predict(classifier,testing ,type="response")
# Prediction functions
ROCRpred = prediction(predictTrain, testing$fgood)
# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
##ploting Roc Curve
plot(ROCRperf)
# Add colors
plot(ROCRperf, colorize=TRUE)

