View(faithful)
attach(faithful)
head(faithful,10)
names(faithful)
summary(faithful)
sapply(faithful, function(x) sum(is.na(x)))
plot(waiting,eruptions)                        #also written as plot(eruptions~waiting)
cor(faithful)                                  #for correlation
input<-faithful                                #to bring file from server to the environment
##Regresion model
eruption.lm = lm(eruptions ~ waiting, data =input)
summary(eruption.lm)
anova(eruption.lm)
#to check mathematically
input<-faithful
Probability<-data.frame(eruption.lm$fitted.values)
Residual<-data.frame(eruption.lm$residuals)
input[,"Probability"]<-Probability$eruption.lm.fitted.values
input[,"Residual"]<-Residual$eruption.lm.residuals
View(input)
sum(input$Residual)
summary(eruption.lm)
plot(eruptions~waiting)
abline(eruption.lm, col="red")                   #abline draws best fit line

#assumtion of reg model
#plot all assumptions in 2*2 format
par(mfrow=c(2,2))                                #plot 4 plots in one page
plot(eruption.lm)

library(lmtest)
dwtest(eruption.lm)

#linearity
plot(eruptions~waiting)
#prediction
#predict for 80 minutes
summary(eruption.lm)
y=-1.874016 +0.075628*80
y
y=0.160143+0.002219*80
y




#Multiple regression
input<-mtcars[,c("mpg","disp","hp","wt")]
names(input)
cor(input)
attach(input)
plot(hp,mpg)
model<- lm(mpg~disp+hp+wt, data=input)            #"~" is for dependency
model                                             #accuracy =80.83%
summary(model)
model2<-lm(mpg~hp+wt, data=input)
model2                                            #accuracy =81.48%
summary(model2)
par(mfrow=c(2,2))
plot(model)
#predict for hp=110 & wt=3.435
y=37.22727-0.03177*110-3.435*3.87783 
y
boxplot(input)                                   #to identify outliers:boxplot