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
## HAVE IT PREPARED TO SEARCH DINAMICALY FOR THIS FILE
featureNames <- read.table(fileList[2])
featureNames <- as.vector(featureNames$V2)

# Setp 2 - Fetching Data and Activity Labels for both test and training sets
testSample <- read.table(fileList[15], col.names=featureNames)
testLabel <- read.table(fileList[16], col.name="ActivityLabel")
testSubject <- read.table(fileList[14], col.name="SubjectID")
testData <- cbind(testSample, testLabel, testSubject)

trainSample <- read.table(fileList[27], col.names=featureNames)
trainLabel <- read.table(fileList[28], col.names="ActivityLabel")
trainSubject <- read.table(fileList[26], col.name="SubjectID")
trainData <- cbind(trainSample, trainLabel, trainSubject)

# Step 3 - Merge both DataSets
mergedDataSet <- merge(testData, trainData, all=TRUE)

#Step 3.1 - Convert the Data Frame to Matrix
completeDataSet <- as.matrix(mergedDataSet)

# Step 4 - Extract Only the Mean and StdDev for each Measure
## tBodyAcc-mean        -> 1:3      # tBodyAcc-StdDev       -> 4:6
## tGravityAcc-mean     -> 41:43    # tGravity-StdDev       -> 44:46
## tBodyAccJerk-mean    -> 81:83    # tBodyAccJerk-StdDev   -> 84:86
## tBodyGyro-mean       -> 121:123  # tBodyGyro-StdDev      -> 124:126
## tBodyGyroJerk-mean   -> 161:163  # tBodyGyroJerk-StdDev  -> 164:166
## tBodyAccMag-Mean     -> 201      # tBodyAccMag-StdDev    -> 202
## tGravityAccMag-Mean  -> 214      # tGravityAccMag-StdDev -> 215
## tBodyAccJerkMag-Mean -> 227      # tBodyAccJerkMag-Mean  -> 228
## tBodyGyroMag-Mean    -> 240      # tBodyGyroMag-Mean     -> 241
## tBodyGyroJerkMag-Mea -> 253      # tBodyGyroJerkMag-Mea  -> 254
## fBodyAcc-Mean        -> 266:268  # fBodyAcc-StdDev       -> 269:271
## fBodyAccJerk-Mean    -> 345:347  # fBodyAccJerk-StdDev   -> 348:350
## fBodyGyro-Mean       -> 424:426  # fBodyGyro-StdDev      -> 427:429
## fBodyAccMag-Mean     -> 503      # fBodyAccMag-StdDev    -> 504
## fBodyAccJerkMag-Mean -> 516      # fBodyAccJerkMag-StDev -> 517
## fBodyGyroMag-Mean    -> 529      # fBodyGyroMag-StdDev   -> 530
## fBodyGyroJerkMag-Mean-> 542      # fBodyGyroJerkMag-StdDev->543
columnsOfInterest <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 
                       266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543, 562, 563)
interestDataSet <- completeDataSet[ ,columnsOfInterest]

# Step 5 - Using Descriptive Activity Labels
activityDescription <- as.matrix(read.table(fileList[1], col.names=c("ActivityId", "ActivityDescription")))
activityIds <- as.numeric(activityDescription[,1])

for (i in activityIds){
    interestDataSet[,"ActivityLabel"] <- gsub(i,activityDescription[i,2], interestDataSet[,"ActivityLabel"])
    ##testGsub[,"ActivityLabel"] <- gsub(i,activityDescription[i,2], testGsub[,"ActivityLabel"])
}

# Step 6 - Using Descriptive Column Names
colnames(interestDataSet) <- sub("t", "time", colnames(interestDataSet))
colnames(interestDataSet) <- sub("f", "frequency", colnames(interestDataSet))
colnames(interestDataSet) <- sub("Acc", "Accelerometer", colnames(interestDataSet))
colnames(interestDataSet) <- sub("Gyro", "Gyroscope", colnames(interestDataSet))
colnames(interestDataSet) <- sub("Mag", "Magnitude", colnames(interestDataSet))

# Step 7 - Write tidy data to a file
write.csv(interestDataSet, file="./cleaning_project_assignment_tidydataset.csv.txt")

## Part II
# Step 7 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(plyr)
lybrary(reshape2)

