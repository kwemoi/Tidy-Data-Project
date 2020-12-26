---
output:
  word_document: default
  html_document: default
  pdf_document: default
---
# Tidy-Data-Project
Peer- graded Assignment

## Getting and cleaning Data Project

The purpose of this project is to demonstrate your ability to collect, 
work with, and clean a data set. Files in the project:
  

1) run_analysis.R which has the source code for the project   
2) Tidy Data *tidyData.tx * . Independent  tidy-- 
data set with the average of each variable for each activity and each   subject  
3)  CodeBook.md . which offers description on the variables.  


**About run_analysis.R Script**
*Part 0*
1) Downloads data from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
to a folder named Dataset.zip
2) Unzips the folder files
3) Reads in the test and train files

*Part 1: Merge training and test data sets*

The various data sets are merged to come up with one data frame
Add column names to the data frame, 
With arrange() function from plyr package, order the dataset by **Subject** and **Activity** just to organize the data in a fancy way.

*Part 2: Measurements of mean and standard deviation*

By defining a pattern for extracting variables with mean() or std(), apply the grep function in subsetting only the columns matching the pattern.


*Part 3: Using descriptive activity names*

Supply the activity names from *activity_labels.txt* making use of mutate() function from dplyr package

*Part 4: Label variables with descriptive names*

Apply the descriptive names of features to variables  
Uses mgsub() function which is a wrapper of gsub() from mgsub package for multiple patterns and multiple replacements.

*Part 5: Create independent tidy data set with the average of each        variable for each activity and each subject*

Takes advantage of the dplyr package to group and summarise all the variables

Then writes the tidy data to a text file named **tidyData.txt**



  