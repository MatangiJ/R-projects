#multiple regression
library(car)
input<-mtcars
names(input)
cor(input)
model<-lm(mpg~.,data=input)          # . is for selecting all columns
model
summary(model)
vif(model)
par(mfrow=c(2,2))
plot(model)
dwtest(model)
#forward & backward stepwise regression
model<-lm(mpg~.-disp-cyl,data=mtcars) #enter method
summary(model)
vif(model)


#forward & backward stepwise regression
model1<-lm(mpg~.,data=input)
summary(model1)
vif(model1)
#backward method
model2<-step(lm(mpg~.,data=input),direction="backward")
summary(model2)
vif(model2)
par(mfrow=c(2,2))
plot(model2)
library(lmtest)
dwtest(model2)                              #to check model error
ncvTest(model2)                             #to check variance

#stepwise method
model3<-step(lm(mpg~.,data=input),direction="both")
summary(model3)
vif(model3)

#forward method
model4<-step(lm(mpg~.,data=input),direction="forward")
summary(model4)
vif(model4)




