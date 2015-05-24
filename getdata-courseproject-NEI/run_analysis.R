#-------------------------------------------------------------------------
# This R script called 'run_analysis.R' does the following:
# - It merges the training and the test sets to create one data set.
# - It extracts only the measurements on the mean and standard deviation for each measurement. 
# - It uses descriptive activity names to name the activities in the data set
# - It appropriately labels the data set with descriptive variable names. 
# - From the data set in step 4, it creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
#
# Note: The data linked to from the course website represent data collected 
# from the accelerometers from the Samsung Galaxy S smartphone. The data is provided at: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
#-------------------------------------------------------------------------
# Necessary library calls in R:
library(plyr)
library(dplyr)
library(Hmisc)
library(reshape2)
#
#-------------------------------------------------------------------------
actlabels <- read.table("./data/activity_labels.txt", colClasses = "character")
features <- read.table("./data/features.txt", colClasses = "character")
#-------------------------------------------------------------------------
colnames(actlabels) <- c("activity", "activity_name")
head(actlabels)
#-------------------------------------------------------------------------
subjecttrain <- read.table("./data/subject_train.txt", colClasses = "numeric")
xtrain <- read.table("./data/X_train.txt", colClasses = "numeric")
ytrain <- read.table("./data/y_train.txt", colClasses = "numeric")

subjecttest <- read.table("./data/subject_test.txt", colClasses = "numeric")
xtest <- read.table("./data/X_test.txt", colClasses = "numeric")
ytest <- read.table("./data/y_test.txt", colClasses = "numeric")
#-------------------------------------------------------------------------
colnames(ytrain) <- "activity"
#head(ytrain)
colnames(xtrain) <- as.character(features$V2)
#head(xtrain)
colnames(subjecttrain) <- "subject"
#head(subjecttrain)
#-------------------------------------------------------------------------
xtrain2 <- xtrain[, c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 
                    227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 
                    503:504, 516:517, 529:530, 542:543)]
traindata <- cbind(ytrain, xtrain2)
xtraindata <- cbind(subjecttrain, traindata) 
#colnames(xtraindata)
#-------------------------------------------------------------------------
colnames(ytest) <- "activity"
#head(ytest)
colnames(xtest) <- as.character(features$V2)
#head(xtest)
colnames(subjecttest) <- "subject"
#head(subjecttest)
#-------------------------------------------------------------------------
xtest2 <- xtest[, c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 
                  227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 
                  503:504, 516:517, 529:530, 542:543)]
testdata <- cbind(ytest, xtest2)
xtestdata <- cbind(subjecttest, testdata)
#colnames(xtestdata)
#-------------------------------------------------------------------------
xdata <- merge(xtraindata, xtestdata, all = TRUE)
#-------------------------------------------------------------------------
xalldata <- merge(xdata, actlabels, by.x = "activity", by.y = "activity", all = TRUE)
#-------------------------------------------------------------------------
xalldata <- arrange(xalldata, subject, activity_name)
xalldata <- select(xalldata, -activity)
xalldata <- xalldata[c(1, 68, 2:67)]
#colnames(xalldata)
#-------------------------------------------------------------------------
xalldata_melt <- melt(xalldata, id.vars = c("subject", "activity_name"))
#head(xalldata_melt)
#-------------------------------------------------------------------------
xalldata_select <- group_by(xalldata_melt, subject, activity_name, variable)
#head(xalldata_select)
#-------------------------------------------------------------------------                            
xalldata_av <- ddply(xalldata_select, c("subject", "activity_name", "variable"), summarise, mean = mean(value, na.rm = TRUE))
head(xalldata_av)
#-------------------------------------------------------------------------  
write.table(xalldata_av, file = "./data/average_acc_data.txt", sep =" ", eol="\n", na="NA", dec=".", row.names=FALSE, col.names=TRUE)
