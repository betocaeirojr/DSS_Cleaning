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
* 3. Fetch data and activity Labels for both test and training sets
* 4. Merges the training set and the test set into a single data set
* 5. Transform the resulting dataframe into a matrix in order to ease the data manipulation
* 6. Subsets from the complete data set the desired variables (mean and standard deviation)
* 7. Adds a column to allow the identification of the activity performed (laying, standing, etc)
* 7.1 Since the info is coded as numbers, we loop through each ID making the proper substitutions (id -> description)
* 8. Enhace column name readability (changing the short names for the long, descriptive ones)
* 9. Writes a CSV file containing the resulting tidy data ("cleaning_project_assignment_tidydataset.csv.txt")
* 10. Using the shape2 library, melt and cast the information to create a second, independent data set fullfilling the 5th requirement.
* 11. Writes a second CSV file containing the second tidy data set ("")

Enhancement Points
==================
Ideally at steps 2 and 3 I could have coded a little bit more dinamically, since my first solution fetches the files directly. (instead of looping from all files searching for the desired one, I accessed it directly through its index)



