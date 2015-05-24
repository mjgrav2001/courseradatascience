#-------------------------------------------------------------------------
This is a description of the R script run_analysis.R for the Course Project 
in the Coursera Course 'Getting and Cleaning Data':

The R script 'run_analysis.R' does the following:
- It merges the training and the test sets to create one data set.
- It extracts only the measurements on the mean and standard deviation for each measurement. 
- It uses descriptive activity names to name the activities in the data set
- It appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It should be noted that the data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. The data is provided at: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The following libraries in R are loaded in order to be able to use some of the R commands to reshape the created data frames into the requested tidy and skinny data set: plyr, dplyr, Hmisc, reshape2.
#-------------------------------------------------------------------------

In a first step,  the data in the following .txt files that had been copied into the sub-directory ./data/ of the working directory, 

activity_labels.txt,
features.txt,
subject_train.txt,
X_train.txt,
y_train.txt,
subject_test.txt,
X_test.txt, 

and 

y_test.txt

are copied using read.table as command into data frames named

actlabels, 
features,
subjecttrain, 
xtrain, 
ytrain, 
subjecttest, 
xtest,

and 
 
ytest, respectively.
#-------------------------------------------------------------------------

Column names 'activity' and 'activity_name' are added to data frame actlabels. Column name 'activity' represents the activities that were generally conducted with each subject. Column name 'activity_name' contains the actual activity described in form of a character string.

Column name 'activity' is added to data frame ytrain. The variable names listed in the data frame features, created from features.txt and representing the names of the acceleration data downloaded with X_train.txt, are then copied as column names to data frame xtrain. Accordingly, data frame 'subjecttrain' receives the heading 'subject' for the enumerated subjects from whom the training / test data had been collected.

Data frame xtraindata is then created in steps from combining data frames xtrain, ytrain and subjecttrain:

Key is to first select the relevant columns containing mean and standard deviation values of acceleration measurements from the total number of 561 columns containing the feature data (described in features.txt and and  a readme file provided at the listed website with the data) gained by inspection with the command head(xtrain) and comparison with the information in features.txt, features_info.txt and readme.txt. 

Following columns are selected from xtrain through subsetting and stored as new data frame xtrain2 that only contain mean and standard deviation data:
1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543.

Data frames ytrain and xtrain2 are merged through a column bind with the call 'cbind'. The resulting data frame called traindata is then merged through a second column bind with data frame subjecttrain. 

The exact same procedure is performed with the corresponding data frames of the test data where the above description holds equally by simply replacing any wording with '...train...' with '...test...'
#-------------------------------------------------------------------------

xdata is the merged data frame of xtraindata and xtestdata where all variables with the same name are used to merge the two data frames using the command 'merge'.

xalldata as data frame then merges this data frame xdata with the data frame actlabels containing the listing of activity numbers and names with column variable name 'activity' used as common name for the merging process. 

In xalldata, then the column with the activity numbering is subsequently dropped, using command 'select'. The columns are reorganized by subsetting with 'subject' and then 'activity_name' listed as first two columns and all acceleration data listed in the remaining columns 3 though 68.

xalldata_melt is then the 'molten' data frame created from xalldata with the command 'melt' where all acceleration data columns are compressed to a single column named value. The names of the individual measurement variables (accelerations) are listed in a separate new column named variable. 

Data frame xalldata_select is created by grouping the data with command 'group_by' with column variables subject, activity_name and variable used as grouping ids. 

Data frame xalldata_av then summarizes the existing data frame xalldata_select in terms of a tidy and skinny using 'ddply' where the mean of the values of the measurement variables is calculated for each subject, activity and variable from the 'molten' column values.  The mean values are contained in xalldata_av in the new variable mean together with the two columns named subject and activity_name.

#-------------------------------------------------------------------------
A tidy and skinny data set called average_acc_data.txt is created as a .txt file withe command write.table() with the setting row.names=FALSE.

average_acc_data.txt describes a data set that contains three columns titled 'subject' for the subject doing the physical activity, 'activity_name' naming one of the six activities having been done by each subject and a last column titled 'mean' that contains the mean values of the measurement values for each subject, activity and variable. 

average_acc_data.txt is stored in a sub-directory ./data of the working directory.



