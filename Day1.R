##variable assignment
x=1                     # "="or "<-" is for assigning
x                       # ctrl+enter to execute the function
###Function and C is combining values into a vector or list
c(1,2,3)                # c is a function which combines values
a=c(1,2,3)              # assigning 
a
1+1                     #this is a comment


## to understand what is C function
help(c)


##If you are not sure about the name of the function you are looking for, 
#you can perform a fuzzy search with the apropos function.
apropos("nova")


#Numeric
x=10.5
x

class(x)     #class is used to identify whether the variable is categorical or numerical

k=1
k

class(k)

is.integer(k)             #is k an integer? "is." is used to check

#Integer
y=as.integer(3)           #"as." is used to convert
y                         #print the value of y

class(y)                  #print the class name of y
is.integer(y)             #is y an integer?
as.integer(3.14)          #coerce a complex variable

z=1+2i
z
class(z)

#Logical Value
x=3; y=2
z=x>y                    #is x greater than y?
z
class(z)
u=TRUE; v=FALSE
u&v                      #u and v
u|v                      #u or v
!u                       #negation u

#character
#A character object is used to represent string values in R.
x=as.character(3.14)     # convert object into character values
x
class(x)

fname="Joe"; lname="Smith"
paste(fname,lname)      #concatenation

substr("Mary has a little lamb.", start=3, stop =12)  #extract substring

sub("little","big","Mary has a little lamb.")         #"sub" is used to replace first occurence

# Vector Arithmetics
 a=c(1,3,5,7)               # vector string 1
 b=c(1,2,4,8)               # vector string 2
 a+b
 a-b
 a*b
 a/b
 a<b
 a>b
 a==b
 a<=b
 a>=b
 
 5 * a                   #multiply vector a by 5
 
 u= c(10,20,30)
 v= c(1,2,3,4,5,6,7,8,9)
 u+v

 s= c("aa","bb","cc","dd","ee")
 s[3]
 s[-3]                   #Negative index
 s[10]                   #Out-of-Range Index
 
 #Numeric Index Vector
 s=c("aa","bb","cc","dd","ee")
 s[c(2,3)]
 
 #duplicate
 s[c(2,3)]
 
 #Out of order indexes
 s[c(2,3,3)]
 
 #Range index
 s[2:4]
 
 
 # sorting examples using the mtcares dataset
 data()
 mtcars<-mtcars           #assigning name to mtcars dataset
 
 names(mtcars)            #header name of dataset
 attach(mtcars)           #fix dataset
 View(mtcars)             #view dataset
 head(mtcars,10)          #fetches top 6(default) rows of dataset, here 10
 tail(mtcars)             #fetches bottom 6 rows(default) of dataset
 summary(mtcars)          #calc mean,median,quartiles 
 boxplot(mtcars)          #boxplots all data
 boxplot(mtcars$hp)       #before $ -> dataset name, after $ -> fix the column 
 summary(mtcars$mpg)
 #sorting by mpg
 newdata <- mtcars[order(mpg),]    #order means sort he data in ascending order
 #sort by mpg and cyl
 newdata <- mtcars[order(mpg,cyl),]
 #sort by mpg(ascending and cyl(descending; since minus sign))
 newdata <- mtcars[order(mpg,-cyl),]
 detach(mtcars)
 
 #subsetting data
 myvars <- c("mpg","cyl","disp")
 dim(mtcars)                         #dimension of data
 newdata <- mtcars[myvars]
 newdata <- mtcars[c(1,5:10)]        #extract columns 
 
 #Dropping variable
 newdata$mpg <- NULL  
 #exclude 3rd & 5th variable
 newdata1 <- newdata[c(-3,-5)]       #delete column 3 & 5
 #using subset function
 newdata2 <- subset(mtcars, mpg>=20|wt<10, select=c(gear,qsec)) #subset, combination of rows and columns
 
 
 #Joins
 df1 = data.frame(customerid= c(1:6), product= c(rep("toaster",3),rep("radio",3)))
 df2 = data.frame(customerid= c(2,4,6),state= c(rep("alabama",2),rep("ohio",1)))
 #data.frame function combines 2 columns into one frame 
 
 names(df1)                          #names: to find name of the column/data
 names(df2)
 
 #innerjoin or merge
 merge(df1, df2, by ="customerid")
 
 #outerjoin
 merge(df1, df2, by ="customerid",all=TRUE)
 
 #left order
 merge(x=df1, y= df2, by="customerid", all.x=TRUE)
 
 #right order
 merge(x=df1, y= df2, by="customerid", all.y=TRUE)
 
 #merging
 product <- data.frame(loan_acc_no= c(234,235,236,237,238), interest= c(11,22,33,44,55), data=1:5)
 
 demo <- data.frame(loan_acc_no= c(234,235,236,5,4), interest= c(66,77,88,99,99), data=1:5)
 merge(product, demo, by = "loan_acc_no")  
 
 newdata <- mtcars
 newdata1 <- mtcars[c(1,2,3)]
 newdata2 <- newdata1[!duplicated(newdata1$cyl),]
 
 total <- merge(newdata,newdata1,by="mpg")
 
 #merge 2 data frames 
 total <- merge(newdata, newdata1, by=c("mpg","cyl"))
 
 #create vector objects
 
 city <- c("tampa","seattle","hartford","denver")
 state <- c("fl","wa","ct","co")
 zipcode <- c(33602, 98104, 061061, 80294)
 
 #combine above 3 vectors in 1 data frame
 addresses = data.frame(city, state, zipcode)
 View(addresses)
 
 #cbind: append column; same as data.frame 
 #using cbind (stores in vector format)
 addresses1 = cbind(city, state, zipcode)
 print(addresses1)
 
 #create another data frame using same columns
 city = c("lowry","charlotte")
 state = c("co","fl")
 zipcode =c(80230,33498)
 
 new.addresses <- data.frame(city, state, zipcode)
 print(new.addresses)
 
 #rbind: append rows , combines or appends rows from both data frames
 #same columns: primary ned
 
 all.addresses <- rbind(addresses, new.addresses)
 print(all.addresses)
 names(all.addresses)
 
 
 #renaming column name
 my_data <- iris
 names(my_data)[names(my_data)== "Sepal.Length"] <- "s_length"
 names(my_data)[names(my_data)== "Sepal.Width"] <- "spl_width"
 names(my_data)
 names(iris)
 
 #missing value
 y<- c(1,2,3,NA)              
 is.na(y)                       #na is missing value (not available)
 
 x<- c(1,2,NA,3)
 mean(x)
 
 #to remove missing values
 mean(x, na.rm=TRUE)            # rm is for removing, here, remove na
 #to remove all missing values records
 newdata <- na.omit(x)
 newdata
 #replace missing value
 x<- c(1,2,3,NA,6,7,8,NA,NA)
 library(gtools)
 na.replace(x, 999)                 #replacing na value with 999 
 
 
 #to replce mv by mean
 
math<- c(88,95,85, NA, 67, 98, NA, 67)
mean(math)
median(math)
math[is.na(math)]       #to check mvs
math[!is.na(math)]       #to check not mv
mean(math, na.rm=TRUE)
mean(math[!is.na(math)])
median(math[!is.na(math)])
math[is.na(math)] <- mean(math[!is.na(math)])
math



