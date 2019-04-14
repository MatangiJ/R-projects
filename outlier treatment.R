#outlier treatment
d<-1:20
d
library(scales)


d2<-squish(d,round(quantile(d, c(.10, .90))))
d2

#outlier replacement using boxplot and quantile strategy
old<-mtcars
mtcars<-mtcars

summary(mtcars$hp)
boxplot(mtcars$hp)

#after the column it will give assigning variable output
upper<-180+1.5*IQR(mtcars$hp);upper
lower<-96.5-1.5*IQR(mtcars$hp);lower

mtcars$hp[mtcars$hp>upper]<-upper
summary(mtcars$hp)

mtcars$hp[mtcars$hp<lower]<-lower
summary(mtcars$hp)



#outlier treatment with quantile
outputQuantile<- quantile(faithful$waiting, seq(0,1,by=0.05)); outputQuantile
cbind(outputQuantile)

qn = quantile(faithful$waiting, c(0.01, 0.99), na.rm=TRUE)
df=within(faithful, {waiting = ifelse(waiting<qn[1], qn[1], waiting) 
waiting =ifelse(waiting>qn[2],qn[2], waiting)})

summary(faithful)
summary(df)



#if and if else statement
x=7                              
if(x<10)
{x<-x+1
cat("increase")                   #cat is used to print categorical variable
}else{
  x<-x-1
cat("decrease")}

##for loop
for(i in (1:10)-3){
  print(c(i,i*i))
}

#for character vector
car<-c("hyundai","tata","honda")
for(j in car){
  print(paste(j, "-ALLvariats"))
}

#while loop
i<2.999
while(i<4.999){
  i<-i+0.999
  print(c(i,i-2,i*i))
}

a<-1
repeat{
  print(a)
  a<-a+1
  if(a>3)
    break
}

x<-1:10
for(i in x){
  if(i==2){
    break
  }
  print(i)
}


x<-1:4
for(i in x){
  if(i==2){
    next
  }
  print(i)
}

addingpercent<-function(x){percent<-round(x*100,digits=2)         
output<-paste(percent,"%",sep="")
return(output)
}
x<-c(0.678,2.99999,0.7678,0.3343)
addingpercent(x)






