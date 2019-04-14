#variable assignment
x=1
x
#'=' & '<-' means the same, assigning
#
#function and c is combining values into a vector or list
c(1,2,3)
m<-c(1,2,3)
#
#Comment
1+1
#this is a comment

#to understand what is c function
help(c)

#if not sure about the name of the func you're looking for you can perform a fuzzy search with the apropos func
apropos("nova")


#type of data in R
#Numeric, Integer, Complex, Logical, Character

##numeric
x=10.5
x
#to check the class of x
class(x)

k=1
k
#print the value of k
class(k)
##to confirm whether an integer or not
is.integer(k)
#is k an integer?
is.numeric(k)

##Integer
#in order to create an integer variable in R, we invoke the as.integer func, we can be assured that y is indeed an integer
y=as.integer(3)
y
class(y)
is.integer(y)
#is y an integer?
#incidentally we can convert a numeric value into an integer with the same as.integer func
as.integer(3.14)
#coerce a numeric value
is.integer(y)

##Complex Value
z=1+2i
z
class(z)

##Logical Value
#Created via comparison b/w variables
x=1; y=2
#sample values
z=x>y
#is x larger than y?
z
class(z)
#Now suppose 
x=3
y=2
z=x>y
#is x larger than y?
z
class(z)

##Standard logical oprations are &, |(or), !(negation)
u=TRUE; v=FALSE
u & v
u | v
!u

##Character
#object used to represent string values in R
#we convert objects into character values using as.character
x=as.character(3.14)
x
class(x)

#two character values can be concatenated with the past
fname="Joe"; lname="Smith"
paste(fname,lname)

#to extract a substring, we apply substr func
#ex:
#3rd & 12th positions in a string
substr("Mary haa a little lamb.", start=3, stop=12)

#and to replace the first occurence of the word "little"
#another word "big" in the string, we apply the sub function
sub("little","big","Mary had a little lamb.")

#Paste: to paste two character
#substr: to take subset of a data
#sub: replacement in the data

#Vector Arithmetics
#arith operatuions of vectors are performed member-by-member, ex:
a=c(1,3,5,7)
b=c(1,2,4,9)
a+b
a-b
a*b
a/b
a>b
a<b
a==b
a<=b
a>=b
#'=':assigning; '==':equal to
#then if we multiply a by 5, we would get a vector with each of its members multiplied by 5
5*a

#Recycling Rule:if 2 vectors are of unequal lengths, the shorter one will be recycled to match the longer vector
u=c(10,20,30)
v=c(1,2,3,4,5,6,7,8,9)
u+v

#[]: Index, [R,C], advantage is that we can take subset; ():combine
#Vector Index:we retrieve values in a vector by declaring an index inside a single square bracket operator
s=c("aa","bb","cc","dd","ee")
s[3]

#Negative Index:removing the value at that position
s[-3]
#3rd row gets deleted

#out-of-range index: if an index is out of range, a missing value will be reported
s[10]

#Numeric vector index
s=c("aa","bb","cc","dd","ee")
s[c(2,3)]

#duplicate
s[c(2,3,3)]

#out of order indexes
s[c(2,1,3)]

#range index
s[2:4]


#Example using 'mtcars' dataset
data()
mtcars<-mtcars
names(mtcars)
attach(mtcars)
View(mtcars)
head(mtcars)
head(mtcars,10)
#shows the first 10 observation
tail(mtcars)
#to see how the data look like
summary(mtcars)
boxplot(mtcars)
boxplot(mtcars$hp)
#$: to fix the dataset (dataset$col_name)
summary(mtcars$mpg)

#sort by mpg
newdata<-mtcars[order(mpg),]

#sort by mpg & cyl
newdata<-mtcars[order(mpg,-cyl),]
#order: sort; orde(-): descending

#sort by mpg(ascending) &cyl(descending)
newdata<-mtcars[order(mpg,cyl),]

detach(mtcars)

#subsetting the data
myvars<-c("mpg","cyl","disp")
dim(mtcars)
#dimension of the data
newdata<-mtcars[myvars]
newdata
newdata<-mtcars[c(1,5:10)]

#dropping variable
#exc (dropping) variable
#delete one variable
newdata$mpg<-NULL
#exc 3rd & 5th variable
newdata<-newdata[c(-3,-5)]
#'-': delete
#using subset function
newdata_2<-subset(mtcars, mpg>=20|wt<10, select=c(gear,qsec))


#Joins
df1<-data.frame(CustomerId=c(1:6), Product=c(rep("Toaster",3),rep("Radio",3)))
df2<-data.frame(CustomerId=c(2,4,6), State=c(rep("Alabama",2),rep("Ohio",1)))
names(df1)
names(df2)

#inner join or merge
merge(df1,df2,by="CustomerId")

#outer join
merge(x=df1, y=df2,by="CustomerId", all=TRUE)

#left join
merge(x=df1, y=df2,by="CustomerId", all.x=TRUE)

#right join
merge(x=df1, y=df2,by="CustomerId", all.y=TRUE)

#Merging
product<-data.frame(loan_account_no=c(234,235,236,237,238), interest=c(11,22,33,44,55), data=1:5)
demo<-data.frame(loan_account_no=c(234,235,236,237,238), income=c(66,77,88,99,99), data=1:5)
merge(product,demo,by="loan_account_no")

newdata<-mtcars
newdata
newdata_1<-mtcars[c(1,2,3)]
newdata_2<-newdata_1[!duplicated(newdata_1$cyl),]
#to remove duplicates

#merge two data frames ID
total<-merge(newdata,newdata_1,by="mpg")

#create vector objects
city<-c("Tampa","Seattle","Hartford","Denver")
state<-c("FL","WA","CT","CO")
zipcode<-c(33602,98104,061061,80294)

#Combine the above 3 vectors in one data frame
addresses1=data.frame(city,state,zipcode)
print(addresses1)

#create another data frame using same columns
city=c("Lowry","Charlotte")
state=c("co","FL")
zipcode=c(80230,33498)

new.addresses<-data.frame(city,state,zipcode)
print(new.addresses)

#rbind:append rows
#rbind:combines data from both data frames

#same columns: primary need
all.addresses<-rbind(addresses1,new.addresses)
print(all.addresses)
names(all.addresses)

#renaming the col name
my_data<-iris
names(my_data)[names(my_data)=="Sepal.Length"]<-"sepal_length"
names(my_data)[names(my_data)=="Sepal.Width"]<-"s_width"
names(my_data)
names(iris)

#missing values
y<-c(1,2,3,NA)
is.na(y)

x<-c(1,2,NA,3)
mean(x)

#to remove the missing values
mean(x,na.rm=TRUE)

#to remove all missing value records
newdata<-na.omit(x)
newdata

#replace missing values
x<-c(1,2,3,NA,6,7,8,NA,NA)
library(gtools)
na.replace(x,999)

#to replace MV by mean
math<-c(88,95,85,NA,67,98,NA,67)
mean(math)
median(math)
math[is.na(math)]
#to check MVs

math[!is.na(math)]
#to check not MVs

mean(math, na.rm=TRUE)
mean(math[!is.na(math)])
median(math[!is.na(math)])
math[is.na(math)]<-mean(math[!is.na(math)])
math

