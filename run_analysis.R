
## Getting data from the url

# Original Data source link
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Dataset.zip", method = "curl")
# Unzip the Dataset
unzip("Dataset.zip")

## Part 1: Merge the training and the test sets to create one data set.

# Read in test data from test directory
# use read.table() function 
subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

XTest<-read.table("./UCI HAR Dataset/test/X_test.txt" )

YTest<-read.table("./UCI HAR Dataset/test/y_test.txt" )

# Read in train data from train directory
subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
XTrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("./UCI HAR Dataset/train/y_train.txt")

activityLabels<- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityLabels)<- c("code", "activity")
# Features are column names to X train and test
features<-  read.table("./UCI HAR Dataset/features.txt")
# Extract the column names
testNames<-features$V2
trainNames<-features$V2

# supply names to the dataset
names(XTest)<-testNames
names(XTrain)<- trainNames

# combine the Test Data- add the subject and activity columns
subjectActivityTest<-cbind(subjectTest,YTest)
names(subjectActivityTest)<- c("Subject", "Activity")
head(subjectActivityTest)
testData<-cbind(subjectActivityTest, XTest)

# combine Train Data
subjectActivityTrain<- cbind(subjectTrain, YTrain)
names(subjectActivityTrain)<- c("Subject", "Activity")
trainData<-cbind(subjectActivityTrain, XTrain)

# Combine Test and Train Data by rows
# Merge the training and the test sets to create one data set.
myData<- rbind(trainData, testData)

# arrange the data by subject then Activity
library(plyr)

myData<- arrange(myData, Subject, Activity)


## Part 2: Extract only the measurements on the mean and standard deviation
# for each measurement.

# pattern to extract variables with mean and standard deviation measurements
pattern<- ("mean\\(\\)|std\\(\\)")

# subset myData based on those with mean | std in the column names
myData<- myData[,c("Subject", "Activity",grep(pattern = pattern, names(myData), value = TRUE))]


# Part 3: Use descriptive activity names to name the activities in the data set
library(dplyr)
activityLabels
myData<-myData %>% mutate(Activity = 
                                  factor(Activity,levels = activityLabels$code, 
                                         labels = activityLabels$activity ) )


# part 4: Appropriately label the data set with descriptive variable names.
# Use mgsub() which is a wrapper for gsub(); accepts multiple patterns
# and replacements at once
library(mgsub)
View(myData)
# a vector of patterns
patternN<- c("^t","^f", "Acc","Mag", "Gyro", "BodyBody")
# vector of replacements
replacement<- c("time", "frequency", "Accelerometer","Magnitude","Gyroscope", 
                "Body")
names(myData)<- mgsub(names(myData), pattern = patternN,
                      replacement = replacement)

names(myData)



# part 5: From the data set in step 4, create a second, independent tidy 
# data set with the average of each variable for each activity and each subject.

# take advantage of the dplyr package to group and summarise the variables

tidyData<- myData %>% group_by(Subject, Activity) %>% summarise_all(list(mean))

# Output the data by writing to a .txt file

write.table(tidyData, file = "tidyData.txt", row.names = FALSE)










