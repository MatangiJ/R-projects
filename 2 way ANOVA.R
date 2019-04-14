#effect of vit C and dose level on tooth growth

View(ToothGrowth)
attach(ToothGrowth)
head(ToothGrowth)
names(ToothGrowth)
mydata<-ToothGrowth
str(mydata)
table(mydata$supp,mydata$dose)         #generates frequency table; 10 subjects in each cell


#convert dose as a factor & recode the levels as D0.5,D1,D2
mydata$dose<-factor(mydata$dose, levels=c(0.5,1,2), labels=c("D0.5","D1","D2"))
head(mydata)
boxplot(len ~ supp * dose, data=mydata, ylab="Tooth Length", xlab="supplement & dose")
result <- aov(len ~ supp + dose, data = mydata)
summary(result)
par(mfrow=c(2,2))
plot(result)
my_data.lm = lm(len ~ supp*dose, data =mydata)
summary(my_data.lm)
