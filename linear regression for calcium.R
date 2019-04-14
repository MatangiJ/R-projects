#Howard Grimes from the Botany Department, conducted an experiment for biochemical analysis
#of intracellular storage and transport of calcium across plasma membrane. 
#Cells were suspended in a solution of radioactive calcium for a certain length of time
#and then the amount of radioactive calcium that was absorbed by the cells was measured.
#The experiment was repeated independently with 9 different times of suspension 
#each replicated 3 times.

#H0: There is no relationship b/n time and amount of Ca absorbed
#H1: There is a relationship b/n time and amount of Ca absorbed
#p-value < 0.05, reject null hypothesis

calcium<-read.csv("D:/Others/Downloads/calcium.csv")
View(calcium)
attach(calcium)
names(calcium)
summary(calcium)
ca=subset(calcium, select=c(2,3))
cor(ca$cal, ca$time)                #for correlation:find association b/n 2 or more variables

#input<-calcium                     #to bring file from server to the environment
##Regresion model
calcium.lm = lm(cal ~ time, data =ca)
summary(calcium.lm)
y = 1.02650 + (0.24269*0.45)         #Ca absorbed= intercept + (beta*time)
y
#anova(calcium.lm)
plot(time,cal)                                
abline(calcium.lm, col="blue")
boxplot(ca)
par(mfrow=c(2,2))
plot(calcium.lm)                    # horizontal trend line indicates absence of non linear patterns b/n predictors and response
library(lmtest)
dwtest(calcium.lm)


#Simple linear regression for finding median bp as a function of salt intake


View(simple.regr)
my_data <- simple.regr
names(my_data)[names(my_data)== "na..mean.sodium.excretion."] <- "na_out"  #renaming column name
names(my_data)[names(my_data)== "b..numeric.vector."] <- "num_vector"
attach(my_data)
names(my_data)
summary(my_data)
plot(my_data$bp,my_data$na_out)                                #also written as plot(eruptions~waiting)
abline(my_data, col="blue")
my_data$num_vector<-as.numeric(my_data$num_vector)
my_data$bp<-as.numeric(my_data$bp)
my_data$na_out<-as.numeric(my_data$na_out)
boxplot(my_data)

#View(my_data)
cor(my_data$bp, my_data$na_out)                                  #for correlation:find association b/n 2 or more variables
#H0: There is no relationship b/n time and amount of Ca absorbed

input<-my_data                                #to bring file from server to the environment
##Regresion model
my_data.lm = lm(bp ~ na_out, data =input)
summary(my_data.lm)
anova(my_data.lm)
abline(my_data.lm, col="blue")
boxplot(my_data)

boxplot(my_data)
my_data.lm = lm(time ~ cal, data =input)
summary(my_data.lm)
