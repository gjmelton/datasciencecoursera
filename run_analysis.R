## install requied libraries

library(reshape2)
library(dplyr)

## clear out variables in the environment
rm(list = ls())

zip_filename <- "samsung.zip"
data_directory <- "UCI HAR Dataset"

## Download dataset if not already done:
if (!file.exists(zip_filename)) {
	fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileURL, filename, method="curl")  ## written to run on iMac
}  
## unzip dataset contents if not already done:
if (!file.exists(data_directory)) { unzip(filename) }
	
## load the activity column names and label type descriptors data
activity_type <- read.table(paste0(data_directory,"/","activity_labels.txt"))
feature_set <- read.table(paste0(data_directory,"/","features.txt"))

## prep data to insure the text is character class 
## prior to using in grep expresions
activity_type[, 2] <- as.character(activity_type[, 2])
feature_set[, 2] <- as.character(feature_set[, 2])

## extract only those column names containing mean or std
features_extr <- grep(".*mean.*|.*std.*", feature_set[, 2])
## use lowercase column names in accordance
## with "tidy" variable naming conventions
features_desired <- tolower(feature_set[features_extr, 2])
## change case on Mean and Std so It's easier to see later
features_desired <- gsub("-mean", "Mean", features_desired)
features_desired <- gsub("-std", "Std", features_desired)
## strip out everything extraneous between parentheses
features_desired <- gsub("[-()]", "", features_desired)
	
## load the test data sets collecting data, activity and subject identifiers
test_dir <- "test"
## only extract those columns in the features_extr table
testDf <- read.table(paste0(data_directory,"/",test_dir,"/","X_test.txt"))[features_extr]
testActivityDf <- read.table(paste0(data_directory,"/",test_dir,"/","y_test.txt"))
testSubjectDf <- read.table(paste0(data_directory,"/",test_dir,"/","subject_test.txt"))
## combine the activity, subjects and test data 
testDf <- cbind(testActivityDf, testSubjectDf, testDf)

## perform similar opeartion on all the training data as well
train_dir = "train"
trainDf <- read.table(paste0(data_directory,"/",train_dir,"/","X_train.txt"))[features_extr]
trainActivityDf <- read.table(paste0(data_directory,"/",train_dir,"/","y_train.txt"))
trainSubjectDf <- read.table(paste0(data_directory,"/",train_dir,"/","subject_train.txt"))
## combine the activity, subjects and train data 
trainDf <- cbind(trainActivityDf, trainSubjectDf, trainDf)
	
## merge training and test data sets
completeDf <- rbind(trainDf, testDf)

## apply column names 
colnames(completeDf) <- c("activity", "subject", features_desired)

## insure columns to melt are factors
completeDf$activity <- factor(completeDf$activity, levels = activity_type[, 1], labels = activity_type[, 2])
completeDf$subject <- as.factor(completeDf$subject)
## melt all columns except activity and subject and create a very "long" dataset
completeDf_melted <- melt(completeDf, id = c("activity", "subject"))
## calculate the mean of all the "variable" data and extract back to original model format
completeDf_mean <- dcast(completeDf_melted, activity + subject ~ variable, mean)

## generate the tidy dataset grouped by the appropriate columns	
tidyDf <- completeDf_mean %>% arrange(activity, subject) %>% group_by(activity, subject)

