View(gapC)
attach(gapC)
head(gapC)
names(gapC)
input<-gapC[,c("breastcancer","alcconsumption","lifeexpectancy","incomeperperson")]
newdata <- na.omit(input)
newdata
cor(newdata)
plot(breastcancer,lifeexpectancy)
#plot(newdata)
gapC.lm = lm(lifeexpectancy ~ breastcancer, data =input)
abline(gapC.lm,col="red")
model<- lm(lifeexpectancy~breastcancer+continent+alcconsumption, data=input)            #"~" is for dependency
model                                             #accuracy 68.68%
summary(model)

#model2<-lm(lifeexpectancy~breastcancer+suicideper100th, data=input)
#model2                                            #accuracy 
#summary(model2)
par(mfrow=c(2,2))
plot(model)
anova(model)
boxplot(gapC$breastcancer ~ gapC$lifeexpectancy)
upper_af<-172.7+1.5*IQR(my_data$na_out);upper
lower<-135.0-1.5*IQR(my_data$na_out);lower
my_data$na_out[my_data$na_out>upper]<-upper
my_data$na_out[my_data$na_out<lower]<-lower
boxplot(my_data$na_out)
