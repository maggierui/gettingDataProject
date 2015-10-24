##download dataset zip file
file.URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file.URL,destfile="mobile.zip",method="auto")
##unzip file
unzip("mobile.zip",exdir="./")

##read X_train.txt
dat_train<-read.table("UCI HAR Dataset/train/X_train.txt")
##read X_test.txt
dat_test<-read.table("UCI HAR Dataset/test/X_test.txt")

##merge train and test data and store it in new data frame "dat". Now dat has 561 variables with variable names of "V1, V2, ..."
dat<-rbind(dat_train,dat_test)

## read in features.txt as variable names 
dat_names<-read.table("./data/UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

## give dat column names with features.txt, which is the second variable "V2" in dat_names
colnames(dat)<-dat_names$V2

## subset only columns with strings of "mean()" and "std()" in it. Using "\\b" to mark the beginning and end of strings.
dat<-dat[,grepl("\\bmean()\\b|\\bstd()\\b",colnames(dat))]

## read in activity labels for train and test data
dat_train_label<-read.table("./data/UCI HAR Dataset/train/Y_train.txt")
dat_test_label<-read.table("./data/UCI HAR Dataset/test/Y_test.txt")

##combine activity labels for train and test data
dat_label<-rbind(dat_train_label,dat_test_label)
colnames(dat_label)<-"Activity"
dat_label[,1]<-as.character(dat_label[,1])

##use revalue in plyr package to relabel activities
library(plyr)
dat_label[,1]<-revalue(dat_label$Activity,c("1"="WALKING","2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"="LAYING"))

## read in subject IDs for train and test data
dat_train_subject<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
dat_test_subject<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##combine activity labels for train and test data
dat_subject<-rbind(dat_train_subject,dat_test_subject)
colnames(dat_subject)<-"ID"

##combine subject ID, activity type, and actual data
dat<-cbind(dat_subject,dat_label,dat)

##Note: there are many threads on the discussion forum about "to what level is descriptive". 
##      I choose to follow the "all lower case" and "no special character" rules.
##      Meanwhile, I decide not to replace every arrievated words to their full versions, for the sake of readability.

##1. Get rid of all dashes and brackets (punctuations)
colnames(dat)<-gsub ("[[:punct:]]", "", colnames(dat))

##2. Change the first letter to their full words. "t" -> "time"; "f"->"frequency"
colnames(dat)<-gsub("^[t]+","time",colnames(dat))
colnames(dat)<-gsub("^[f]+","frequency",colnames(dat))

##3. Change all capital letters to lower cases
colnames(dat)<-tolower(colnames(dat))
cn<-colnames(dat)

##4. correct the typo of "bodybody" to "body"
colnames(dat)<-gsub("bodybody","body",colnames(dat))

## Next: calculate mean for each variable, grouped by id and activity.
columns<-c("id","activity")
dat %>%
  group_by_(.dots = columns) %>%
  summarise(timebodyaccstdx = mean(timebodyaccstdx))
