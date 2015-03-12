# GettingandCleaningDataProject

Steps taken to produce the tidy data text file

libraries needed for the r script file, "run_analysis.R" are:
1.  downloader  - for downloading the file from a https site
2.  utils       - to unzip the file, 
3.  dplyr       - to use the arrange function  
4.  reshape2    - to use the melt and dcast functions.


1.  Used the download function to downlaod the zipped file from the https site given in the project. 
  (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
2.  Then used the download function to unzip the file to a folder in my working directory.
3.  Read in the variables names from fetures.txt into an object named "VarNames".

4.  Under step 1, read in 3 test files ( X_test.txt,subject_test.txt,y_test.txt) into objects named x_test,subject_test, 
  y_test, respectively.  The test files had 2947 rows of observations. 
5.  Took similar steps for reading in the train files (X_train.txt,subject_train.txt,y_train.txt) into objects named x_train,
  subject_train, y_train respectively.  The train files had 7352 rows of observations.
6.  The X_test and X_train files have 51 columns of variables and the subject_test, y_test,subject_train and y_train have 1 
  column each.
7.  Before merging the data sets together, I renamed the column names for each of the data set by the names stored in the 
  object "VarNames".
8.  I merged the test files together using a cbind and repeated that for the train files.  These 2 data sets then ended up with 
  53 columns.
9.  Then I used rbind to append the train data set (named datatrain) to the test data set (datatrain) into an object named 
  "MergedData".  This produced 10299 rows and 81 columns
  
10. In Step 2 , I used the grepl function to extract only the variables with the names "mean" or "std" in the variables name.
    These were stored in the oject named data_meanextract and data_stdextract respectively.
11. After that, I used the cbind function to join the these 2 objects to the column 1 and 2 of the "MergedData" object and 
    stored the results in object named full_dataextract.
    Column 1 and 2 of the MergedData object are the variables named subject_ID and activity_name.
    
12. In step 3, I used a for loop to substitute the descriptive activity names found in the activity_labels.txt and assigned them 
    to the numeric value of the activity name.  The outcome here was that all the numeric values in the column , activity_name 
    were replaced with their descriptive activity names.
    
13. The requirements listed under step 4 for the assignment- to rename the variables to appropriate descriptive variable names
    were done in step 1, mentioned in line 7 above.  I felt these names were descriptive compared to V1, v2......
    Step 4 in the run_analysis script file : Because I noticed that some of the variable had the word "body" appear twice in their
    names, I used the gsub function to replace the word "bodybody" to just "body"  whenever the word "bodybody" appeared in any 
    of the variables' names.
    
14. In step 5, I used the functions melt and dcast from the reshape2 library to create the final tidy dataset ( stored in the
    object named activityData) which had the averages for each measurement variable by the activity and subject_id. 
10. Finally in step 5 , I used the write.table function to create the tidy data file- named TidyDataSet.txt.

