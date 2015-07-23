# Getting and Cleaning Data
# Course Project
# 23/07/2015

#Clean up workspace
rm(list=ls())

# loading necessary packages

library(plyr)
library(dplyr)

# 1. Merges the training and the test sets to create one data set

# Read all relevant files into R

trainSet <- read.table("./Coursera/X_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
testSet <- read.table("./Coursera/X_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
subjTest <- read.table("./Coursera/subject_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
subjTrain <- read.table("./Coursera/subject_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
lblSetTest <- read.table("./Coursera/y_test.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
lblSetTrain <- read.table("./Coursera/y_train.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
features <- read.table("./Coursera/features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)
actLabels <- read.table("./Coursera/activity_labels.txt", sep = "", header = FALSE, stringsAsFactors = FALSE)

# Organize train data set
# Merge y_train (lblSetTrain) with activity labels (actLabels) to assign activity to number
# and assign result to temporary variable, labeltemp

labeltemp <- inner_join(lblSetTrain, actLabels)

# cbind labeltemp to the left of train data set

trainSet <- cbind(labeltemp, trainSet)

# bind subjects to train data set

trainSet <- cbind(subjTrain, trainSet)

# Repeat process for test data set

labeltemp2 <- inner_join(lblSetTest, actLabels)
testSet <- cbind(labeltemp2, testSet)
testSet <- cbind(subjTest, testSet)

# rbind test data set to train data set

finalSet <- rbind(trainSet, testSet)

# rename columns

names(finalSet) <- c("subject", "activity_code", "activity", features[, 2])

# select mean and standard deviation for each measurement

finalSet <- finalSet[, !duplicated(colnames(finalSet))]

tidySet <- finalSet %>% select(subject, activity, matches("(mean|std)\\(.*\\)")) %>%
		group_by(subject, activity) %>% summarise_each(funs(mean))

# Export result
write.table(format(tidySet, digits = 4), "./Coursera/tidySet.txt", sep = "\t", row.names = F, quote = FALSE)
