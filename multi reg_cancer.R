#look for relationships between socioeconomic status and cancer 
#by way of combining data from disparate open sources. 
#I hypothesized that poorer regions would have fewer trials, 
#and higher per capita cancer incidence and death rates.


View(cancer_reg)
attach(cancer_reg)
head(cancer_reg)
names(cancer_reg)
is.na(cancer_reg)
newdata <- na.omit(cancer_reg)
newdata
is.na(newdata)
#input<-data.frame("avgdeathsperyear","medincome","medianage","povertypercent","target_deathrate")
#input
names(newdata)
attach(newdata)
plot(medincome,target_deathrate)
names(newdata)
model<- lm(target_deathrate~avgdeathsperyear+medincome+povertypercent+medianagemale+medianagefemale+medianage+pctbachdeg18_24+pctbachdeg25_over+pctemployed16_over+pctotherrace+pctprivatecoverage+pctprivatecoveragealone+pctpubliccoverage+pctpubliccoveragealone+birthrate+pctmarriedhouseholds+pctempprivcoverage+pctasian+pctblack+avganncount+incidencerate+pctemployed16_over+pctunemployed16_over+binnedinc+pctnohs18_24+pcths18_24+pctsomecol18_24+pcths25_over, data=input)            #"~" is for dependency
#model<- lm(target_deathrate~., data=newdata)            #"~" is for dependency
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
