#data importing
data1<-read.csv(file.choose())

data2 <-read.csv(file="")
getwd()                                         #to get directory

data3<-read.csv("")

#exporting data
data<-faithful
write.csv(data, file="D:/prakruti/newfile.csv")


library(xlsx)

#data importing has limit upto 1lakhs 
Age<-c(56,34,67,33,25,28)
Weight<-c(78,67,56,44,56,89)
Height<-c(165,171,167,167,166,181)

BMI_df<-data.frame(Age,Weight,Height)
BMI_df
apply(BMI_df,1,sum)                     #1 is for row, sum of each rows
apply(BMI_df,2,sum)                     #2 is for columns, sum of each columns    
apply(BMI_df,2,mean)

lapply(BMI_df, function(BMI_df)BMI_df/2)  #l is for list, shows data as a list

lapply(BMI_df, mean)                       

sapply(BMI_df,function(BMI_df)BMI_df/2)    #s is to visualize data in column

sapply(BMI_df, mean)

str(mtcars$cyl)

levels(as.factor(mtcars$cyl))
tapply(mtcars$mpg, mtcars$cyl,mean)        

### tapply and sapply is frequently used in data analysis