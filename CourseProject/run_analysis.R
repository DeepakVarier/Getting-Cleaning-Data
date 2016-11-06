
######### Human Activity Recognition Using Smartphones Data Set ###########


## You should create one R script called run_analysis.R that does the following.

## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names.
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Good luck!

#setwd("C:/Users/Deepak/Documents")
getwd()
directory <- "/John Hopkins Data science/Cleaning Data/Week 4"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- paste(getwd(),directory,sep="/")
if(!dir.exists(path)){dir.create(path)}
print(path)
filename <- "Week4.zip"
fullname <- paste(path,filename,sep="/")
download.file(url,destfile = fullname,method="curl") #curl is to be used only for mac OS
dateDownloaded <- now()

## Unzip the files
unzip(fullname,exdir = path)

## View the files which have been unzipped
files <- list.files(path)
files

## View the folders which have been unzipped
folders <- list.dirs(path,recursive=FALSE)
folders

## Change the working directory
setwd(folders)

## Requirement 1:Merge the training and the test sets to create one data set
trainLabel <- read.table("./train/y_train.txt")
table(trainLabel)
testLabel <- read.table("./test/y_test.txt") 
table(testLabel)

# Read the data files.
trainData <- read.table("./train/X_train.txt")
str(trainData)
dim(trainData) 
## 7352*561
head(trainData)
testData <- read.table("./test/X_test.txt")
dim(testData) 
## 2947*561

## Read the subject files
trainSubject <- read.table("./train/subject_train.txt")
str(trainSubject)
head(trainSubject)
table(trainSubject)
testSubject <- read.table("./test/subject_test.txt")

## Merge the training and the test sets. Concatenate the data tables.
joinData <- rbind(trainData, testData)
dim(joinData) 
## 10299*561
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel) 
## 10299*1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject) 
## 10299*1

## Requirement 2:Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./features.txt")
str(features)
table(grepl("mean\\(\\)",features[,2])) # 33 true
table(grepl("std\\(\\)",features[,2])) # 33 true
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
meanStdIndices
length(meanStdIndices) # length is 66
## create a subset with only columns which have mean or std
joinData <- joinData[, meanStdIndices]
dim(joinData)
## 10299*66
## Add column names to the joinData dataset from features dataset
## using gsub command to tidy the column names
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 
#names(joinData)

## Requirement 3: Uses descriptive activity names to name the activities in the data set 
activity <- read.table("./activity_labels.txt")
str(activity)
table(activity) # All are upper case. Need to change
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))# Remove "_" in column names
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) # walkingUpstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) # walkingDownstairs
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

## Requirement 4: Appropriately labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

## Requirement 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
tidyData <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
tidyData <- as.data.frame(tidyData)
colnames(tidyData) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
      for(j in 1:activityLen) {
            tidyData[row, 1] <- sort(unique(joinSubject)[, 1])[i]
            tidyData[row, 2] <- activity[j, 2]
            bool1 <- i == cleanedData$subject
            bool2 <- activity[j, 2] == cleanedData$activity
            tidyData[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
            row <- row + 1
          }
    }
head(tidyData)
write.table(tidyData, "means_data.txt") # write out the 2nd dataset
