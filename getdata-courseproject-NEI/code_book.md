#-------------------------------------------------------------------------
Code book for run_analysis.R:

Following .txt files have been copied into the sub-directory ./data/ of my working directory:

activity_labels.txt
features.txt

subject_train.txt
X_train.txt
y_train.txt

subject_test.txt
X_test.txt
y_test.txt

Following data frames are created when reading in the listed .txt files 

actlabels 
features

subjecttrain 
xtrain 
ytrain 

subjecttest 
xtest 
ytest 

#-------------------------------------------------------------------------
Data frame xtrain2 is derived from data frame xtrain which represents the training data set removing all columns with acceleration data except for the columns containing the mean and standard deviation. 

The new, combined data frame xtraindata is derived from xtrain2 and contains two new columns from data frames ytrain and subjecttrain representing the activity listing and number of the subject doing the activity. 

#-------------------------------------------------------------------------
Data frame xtest2 is derived from data frame xtest which represents the test data set removing all columns with acceleration data except for the columns containing the mean and standard deviation. 

The new, combined data frame xtestdata is derived from xtest2 and contains two new columns from data frames ytest and subjecttest representing the activity listing and number of the subject doing the activity. 

#-------------------------------------------------------------------------
xdata is the merged data frame of xtraindata and xtestdata with the common column variable 'activity' used to merge both data frames.

xalldata as data frame then merges this data frame xdata with the data frame actlabels containing the listing of activity numbers and names. 

In xalldata, then the column with the activity numbering is subsequently dropped and the columns are reorganized with 'subject' and then 'activity_name' listed as first two columns and all acceleration data listed in the remaining columns 3 though 68.

xalldata_melt is then the 'molten' data frame where all acceleration data  columns are compressed to a single column named value. The names of the individual measurement variables (accelerations) are listed in a separate new column named variable.

xalldata_select and then xalldata_av first group the data in terms of subject, activity_name and variable and then calculates the mean value for each variable respectively.  

#-------------------------------------------------------------------------
A tidy and skinny data set called average_acc_data.txt is created as a .txt file that contains three columns titled 'subject' for the subject doing the activity, 'activity-name' naming one of the six activities having been done by the subject and a last column titled 'mean' that contains the mean values of the measurements. It is stored in a sub-directory ./data of the working directory.



