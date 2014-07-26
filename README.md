# Data Science Specialization - 
## Getting and Cleaning Data Module

### run_analysis.R

Context
=======

This R Script is intended to full all the requirements from the Module Getting and Cleaning Data, of the 
Data Science Specialization offered by Johns-Hopkins University through Coursera.

The requirements
================
From the data found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
You should create one R script called run_analysis.R that does the following:
* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3. Uses descriptive activity names to name the activities in the data set
* 4. Appropriately labels the data set with descriptive variable names. 
* 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The Solution/Algorithm.
=======================
The script follows the steps described bellow:
* 1. Download, unzip the files to your working directory and reads the data source
* 2. Reads the "Feature Names" from the file "features.txt"
* 3. Fetches Data, Activity IDs and Subject IDs for both test and training sets
* 4. Filters only the desired features - mean and standard deviation - using Reg Exp 
* ---- grep("-mean\\(\\)|-std\\(\\)",...)
* 5. Label the values
* 6. Merging all values (Subject ID, Activity ID, Data)
* 7. Substitute the Activity ID for the Activity Description for enhanced legibility
* 8. Substitute column names for the Long Description ones (using sub/reg.exp)
* ---- sub("^t", "time", ...)
* ---- sub("^f", "frequency",...)
* ---- sub("Acc", "Accelerometer", ...)
* ---- sub("Gyro", "Gyroscope", ...)
* ---- sub("Mag", "Magnitude", names(completeDataSet))
* 9. Writes the first TidyData file, named = cleaning_project_assignment_tidydataset.csv.txt
* 10. Aggregates the info by activity and subject
* 11. Removes the columns not used due to duplication effects of aggregate function
* 12. Writes the second TidyData file, named = cleaning_project_assignment_aggregated_tidydataset.csv.txt

Output
=======
This script produces 2 files:
* - cleaning_project_assignment_tidydataset.csv.txt (the "raw" tidydata file)
* - cleaning_project_assignment_aggregated_tidydataset.csv.txt (the "aggregated" tidydata file)
Both files are saved in the same directory where the script is located.