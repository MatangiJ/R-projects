#To check if there is a difference in mean survival time wrt type of poison used
#Time: Survival time of the animal
#poison: Type of poison used: factor level: 1,2 and 3
#treat: Type of treatment used: factor level: 1,2 and 3

#H0: There is no difference in mean survival time 
#H1: There is a difference in mean survival time

poisons<-read.csv("D:/Others/Downloads/poisons.csv")
View(poisons)
attach(poisons)
names(poisons)
poisons$X<-NULL                               #to remove a column
names(poisons)
summary(poisons)
boxplot(time ~ poison, data=poisons, ylab="time", xlab="poison", outline=FALSE)                        #also written as plot(eruptions~waiting)
#poisons$out                                  #to find outliers
#1 way anova
anova_one_way <- aov(time~poison, data = poisons)
summary(anova_one_way)

##Regresion model
poisons.lm = lm(time ~ poison, data =poisons)
summary(poisons.lm)
anova(poisons.lm)
par(mfrow=c(2,2))                                #plot 4 plots in one page
plot(poisons.lm)
library(lmtest)
dwtest(poisons.lm)


#2 way anova
#anova_two_way <- aov(time~poison+treat, data=poisons)
anova_two_way <- aov(time~., data=poisons)
summary(anova_two_way)

##Regresion model
poisons2.lm = lm(time ~., data =poisons)
summary(poisons2.lm)
anova(poisons2.lm)

par(mfrow=c(2,2))                                #plot 4 plots in one page
plot(poisons2.lm)
library(lmtest)
dwtest(poisons2.lm)
#summary.aov(poisons2.lm)
