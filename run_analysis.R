# R script created by David Alexander, June 26, 2016
# Data cleanup project required during week 4 of the Coursera / Johns Hopkins
# Getting and Cleaning Data Course

# Key script outputs:
# ActivityData = Mean and Std variables organized with descriptive column names, 
#                descriptive activity labels, and subject identifier
# ActivityMeans = Mean calculated for variables in the ActivityData set
#               grouped by activity and subject

# Information about the original data set:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Original data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# License recognition:
#  Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#    Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
#    International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
#

library(dplyr)

# Download and unzip data if needed
if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/UCI HAR Dataset"))
{
    if(!file.exists("./data/UCI HAR Dataset.zip"))
    {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip")
        rm(fileUrl)
    }
    unzip("./data/UCI HAR Dataset.zip", overwrite = TRUE, exdir = "./data")
}

# Read the test data set and the training data set
# Merge the two (no need to maintain history of which record came from which set)
# Keep the combination as the test set and clear memory for the training set
# Add column names as the feature recorded for each column
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test <- rbind(X_test,X_train)
rm(X_train)
features <- read.table("./data/UCI HAR Dataset/features.txt")
colnames(X_test) <- features[,2]
rm(features)

# Read the test data activity label IDs and the training set label IDs
# Merge the two (no need to maintain history of which record came from which set)
# Keep the combination as the test label and clear memory for the training set
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- rbind(y_test,y_train)
rm(y_train)

# Load the descriptive names for the activity labels and attach them to the data set
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
y_test <- left_join(x = y_test, y = activity_labels, 
                    by = setNames(names(y_test[1]), names(activity_labels[1])))
X_test <- cbind(y_test[,2],X_test)
colnames(X_test)[1] <- "Activity"
rm(activity_labels)
rm(y_test)

# Load subject designators and attach to the data set
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- rbind(subject_test,subject_train)
rm(subject_train)
X_test <- cbind(subject_test[,1],X_test)
colnames(X_test)[1] <- "Subject"
rm(subject_test)

# A bit more cleanup of objects no longer needed, and eliminating data not
# showing mean or standard deviation for each measurement
ActivityData <- X_test
rm(X_test)

colKeep <- grepl("mean[:(:][:):]|std[:(:][:):]", names(ActivityData))
colKeep[1:2] = TRUE
ActivityData <- ActivityData[,colKeep]
rm(colKeep)

# Create summary with the average of each variable for each activity and each subject
ActivityMeans <- ActivityData %>% group_by(Subject, Activity) %>%
  summarize_each(funs(mean))

