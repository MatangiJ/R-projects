#create 2 hp level
mtcars<-mtcars
mtcars$hpcat <- as.factor(ifelse(mtcars$hp >70, c("older"),c("younger")))     #factor is for categorical variables
levels(mtcars$hpcat)
rm(mtcars)

mtcars<-mtcars
attach(mtcars)                           #fix 
mtcars$hpcat[hp>75]<-"elder"
mtcars$hpcat[hp>60 & hp<=75]<-"Middle hpd"
mtcars$hpcat[hp<=60]<-"young"
str(mtcars)                              #str is to check data type
mtcars$hpcat<-as.factor(mtcars$hpcat)
str(mtcars$hpcat)
levels(mtcars$hpcat)
rm(mtcars)



