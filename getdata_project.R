##download dataset zip file
file.URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file<-(file.URL,destfile="./data/mobile.zip",method="auto")
##unzip file
unzip("./data/mobile.zip",exdir="./data")

##read X_train.txt
dat_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
##read X_test.txt
dat_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")

##merge train and test data and store it in new data frame "dat". Now dat has 561 variables with variable names of "V1, V2, ..."
dat<-rbind(dat_train,dat_test)

## read in features.txt as variable names 
dat_names<-read.table("./data/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

## give dat column names with features.txt, which is the second variable "V2" in dat_names
colnames(dat)<-dat_names$V2

## subset only columns with strings of "mean()" and "std()" in it. 
dat<-dat[,grepl("mean()|std()",colnames(dat))]

## read in activity labels for train and test data
dat_train_label<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")
dat_test_label<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")

##combine activity labels for train and test data
dat_label<-rbind(dat_train_label,dat_test_label)
colnames(dat_label)<-"Activity"
dat_label[,1]<-as.character(dat_label[,1])

##add activity label column to the dataset 
dat_1<-cbind(dat_label,dat)

##use revalue in plyr package to relabel activities
library(plyr)
revalue(dat_1$Activity,c("1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"="LAYING"))

