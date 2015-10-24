# gettingDataProject
Course project for Getting Data
In order to get the final new independent data set, which calculates the average for all subject IDs with all types of activities, the "run_analysis.R" script does the following:

1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the data with unzip()
3. Read data sets to R: X_train.txt and X_test.txt
4. Combine the two data sets using rbind()
5. Read data variable names: features.txt
6. Give dat column names with varaibles names from features.txt using colnames()
7. Subset only columns with strings of "mean()" and "std()" using grepl()
8. Read in activity labels for train and test data: Y_train.txt and Y_test.txt
9. Combine activity labels for train and test data using rbind()
10. Rename the activity labels as "Activity" using colnames()
11. Use revalue() in plyr package to relabel activities into WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS...
12. Read in subject IDs for train and test data
13. Combine subject IDs for train and test data
14. Rename subject IDs to "ID" with colnames()
15. Combine subject ID, activity type, and actual dataset using cbind()
16. Rename the variables with gsub() by getting rid of punctuations, changing upper case letters to lower cases, changing the first letter "t" to "time", and changing the first letter "f" to "frequency"
17. Correct the typo of "bodybody" in some of the variable names with gsub()
18. Use summarise_each() to summarise the data by group of "id" and "activity"
19. Use write.table() to write the output to a .txt file named "feature_means.txt"