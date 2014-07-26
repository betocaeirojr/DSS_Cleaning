# Wearable Description - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Data Source - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 

# Downloading and Reading Data Source
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./uci_har_dataset.zip", method="curl")
zipFile <- "./uci_har_dataset.zip"
fileList <- unzip(zipFile)

## Part I
# Step 1 - Reading the Feature Names from "features.txt"
featureNames <- read.table(fileList[2])

# Setp 2 - Fetching Data, Activity Labels and Subject IDs for both test and training sets
# Values
testSample <- read.table(fileList[15])
trainSample <- read.table(fileList[27])
valuesSamples <- rbind(testSample, trainSample)
#Activities
testActivityLabel <- read.table(fileList[16], col.name="ActivityLabel")
trainActivityLabel <- read.table(fileList[28], col.names="ActivityLabel")
valuesActivityLabel <- rbind(testActivityLabel, trainActivityLabel)
#Subject IDs
testSubjectID <- read.table(fileList[14], col.name="SubjectID")
trainSubjectID <- read.table(fileList[26], col.name="SubjectID")
valuesSubjectID <- rbind(testSubjectID, trainSubjectID)


# Step 3 - Filtering only the desired features - mean and standard deviation
filtered_features <- grep("-mean\\(\\)|-std\\(\\)", featureNames[, 2])
valuesSamples <- valuesSamples[,filtered_features]

# Step 4 - Labeling the values
names(valuesSamples) <- featureNames[filtered_features, 2]

# Step 5 - Merging all values
completeDataSet <- cbind(valuesSubjectID, valuesActivityLabel, valuesSamples)

# Step 5.1 - Using Descriptive Activity Labels
activityDescription <- read.table(fileList[1], col.names=c("ActivityId", "ActivityDescription"))
activityIds <- activityDescription[,1]

for (i in activityIds){
    completeDataSet[,2] <- gsub(i,activityDescription[i,2], completeDataSet[,2])
}

# Step 6 - Using Descriptive/Long Column Names
names(completeDataSet) <- sub("^t", "time", names(completeDataSet))
names(completeDataSet) <- sub("^f", "frequency", names(completeDataSet))
names(completeDataSet) <- sub("Acc", "Accelerometer", names(completeDataSet))
names(completeDataSet) <- sub("Gyro", "Gyroscope", names(completeDataSet))
names(completeDataSet) <- sub("Mag", "Magnitude", names(completeDataSet))

# Step 7 - Write tidy data to a file
write.csv(completeDataSet, file="./cleaning_project_assignment_tidydataset.csv.txt")

## Part II
# Step 7 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
byValue <- list(SubjectID = completeDataSet$SubjectID, ActivityLabel = completeDataSet$ActivityLabel)
aggregatedDataSet <- aggregate(completeDataSet, by=byValue, FUN=mean, na.rm=TRUE)

# Step 8 - Removing the SubjectID and ActivityLabel once they are already being used in aggregation
aggregatedDataSet <- aggregatedDataSet[,-(3:4)]
write.csv(aggregatedDataSet, file="./cleaning_project_assignment_aggregated_tidydataset.csv.txt")
