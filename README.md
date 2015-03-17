# GettingandCleaningDataProject
 + Class project assignment for the Coursera Data Science class on Getting and Cleaning Data

## Steps taken to produce the tidy data text file
 + For information on the variables, please see CodeBook.md

### Libraries needed for the r script file, "run_analysis.R" are:
1.  downloader  - for downloading the file from a https site
2.  utils       - to unzip the file, 
3.  dplyr       - to use the arrange function  
4.  reshape2    - to use the melt and dcast functions.

### Steps taken to download and unzip file
1.  Used the download function to downlaod the zipped file from the https site given in the project. 
  (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
2.  Then used the unzip function to unzip the file to a folder in my working directory.

### Steps taken to Merge the training and the test sets to create one data set
3.  Read in the variables names from fetures.txt into an object named "VarNames".

4.  Under step 1, read in 3 test files ( X_test.txt,subject_test.txt,y_test.txt) into objects named x_test,subject_test, 
    y_test, respectively.  The test files had 2947 rows of observations. 
5.  Took similar steps for reading in the train files (X_train.txt,subject_train.txt,y_train.txt) into objects named
    x_train, subject_train, y_train respectively.  The train files had 7352 rows of observations.
6.  The X_test and X_train files have 51 columns of variables and the subject_test, y_test,subject_train and y_train have 1 
    column each.
7.  Before merging the data sets together, I renamed the column names for each of the data set by the names stored in the 
    object "VarNames".
8.  Merged the test files together using a cbind and repeated that for the train files.  These 2 data sets then ended up  
    with 53 columns.
9.  Then I used rbind to append the train data set (named datatrain) to the test data set (datatrain) into an object named 
    "MergedData".  This produced 10299 rows and 81 columns

### Extracts only the measurements on the mean and standard deviation for each measurement.
1.  I used the grepl function to extract only the variables with the names "mean" or "std" in the variables name.
    These were stored in the oject named data_meanextract and data_stdextract respectively.
2.  After that, I used the cbind function to join the these 2 objects to the column 1 and 2 of the "MergedData" object and 
    stored the results in object named full_dataextract.
    Column 1 and 2 of the full_dataextract object are the variables named subject_ID and activity_name.


### Uses descriptive activity names to name the activities in the data set
1.  Used a for loop to substitute the descriptive activity names found in the activity_labels.txt and assigned them 
    to the numeric value of the activity name.  The outcome here was that all the numeric values in the column,
    activity_name were replaced with their descriptive activity names.

### Appropriately labels the data set with descriptive variable names
1.  Used the variable names from features.txt to rename the measurement variables colummns. I felt these names were 
    descriptive compared to V1, v2......
2.  The only manipulation performed  was to rename the column names where the word "body", appeared twice in the 
    description.  I felt this was a typo and replaced those names with the word "body" to only appear once.
3.  The rest of the names are identical to what appears in the features.txt file.
3.  Used the dplyr library to sort the data using the arrange function.
4.  Did a sort on the full_dataextract and stored that result in an object called "sortedData".
    I took this step so that it was easier for me to check my work to see if my mean function was applied correctly by each 
    activity and each subject for the final step in creating the tidy data set. 
    
### Create a second, independent tidy data set with the average of each variable for each activity and each subject.    
1.  Used functions melt and dcast from the reshape2 library to create the final tidy dataset ( stored in the
    object named activityData) which had the averages for each measurement variable by the activity and subject_id. 
2.  Finally, I used the write.table function to create the tidy data set called "TidyDataSet.txt".

