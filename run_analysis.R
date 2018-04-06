setwd("C:/Users/sc56603/DataScience/Getting and Cleaning Data/Week4/data")
library(reshape2)
library(data.table)
library(stringr)

## Download and unzip the dataset
filename <- "uci_har_dataset.zip"
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Load activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt"); 
setnames(activities, names(activities), c("activity", "activityName"))
# head(activities)

# Load features
features  <- read.table("./UCI HAR Dataset/features.txt"); 
setnames(features, names(features), c("feature-id", "featureName"))
wantedFeatures <- grepl(".*mean.*|.*std.*", features$featureName, ignore.case = FALSE)
# table(wantedFeatures)
wantedFeatureNames <- gsub("[()]","",features$featureName[wantedFeatures])

wantedFeatureNames<-gsub("^t", "time", wantedFeatureNames)
wantedFeatureNames<-gsub("^f", "frequency", wantedFeatureNames)
wantedFeatureNames<-gsub("Acc", "Accelerometer", wantedFeatureNames)
wantedFeatureNames<-gsub("Gyro", "Gyroscope", wantedFeatureNames)
wantedFeatureNames<-gsub("Mag", "Magnitude", wantedFeatureNames)
wantedFeatureNames<-gsub("BodyBody", "Body", wantedFeatureNames)
wantedFeatureNames<-gsub("mean", "Mean", wantedFeatureNames)
wantedFeatureNames<-gsub("std", "Std", wantedFeatureNames)
wantedFeatureNames<-gsub("-", "", wantedFeatureNames)

# head(wantedFeatureNames)
                         
# Load the test datasets
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
setnames(testSubjects, names(testSubjects), c("subject"))
# head(testSubjects)
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
setnames(testActivities, names(testActivities), c("activity"))
# head(testActivities)
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSubSet <- testSet[wantedFeatures]
setnames(testSubSet, names(testSubSet),wantedFeatureNames)
# head(testSubSet)
testData <- cbind(testSubjects, testActivities, testSubSet)
# head(testData)

# Load the train datasets
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
setnames(trainSubjects, names(trainSubjects), c("subject"))
# head(trainSubjects)
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
setnames(trainActivities, names(trainActivities), c("activity"))
# head(trainActivities)
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainSubSet <- trainSet[wantedFeatures]
setnames(trainSubSet, names(trainSubSet),wantedFeatureNames)
# head(trainSubSet)
trainData <- cbind(trainSubjects, trainActivities, trainSubSet)
# head(trainData)

# merge datasets and add labels
consolidatedData <- rbind(trainData, testData)
# head(consolidatedData)

# turn activities & subjects into factors
consolidatedData$activity <- factor(consolidatedData$activity, levels = activities[,1], labels = activities[,2])
consolidatedData$subject <- as.factor(consolidatedData$subject)

meltedData <- melt(consolidatedData, id = c("subject", "activity"))
meltedDataMean <- dcast(meltedData, subject + activity ~ variable, mean)
# head(meltedDataMean, 1:1)
write.table(meltedDataMean, "tidy.txt", row.names = FALSE, quote = FALSE)

     
