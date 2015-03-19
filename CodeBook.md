---
title: "CodeBook.md"
author: "cermin"
date: "Tuesday, March 17, 2015"
output: html_document
---

This document describes the code inside  run_analysis.R .

# The code is split (by comments) into 6 sections and Information Sections about the data:

1. Downloading the UCI Har Data and unzips the files
2. Merges the training and the test sets to create one data set
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names
6. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

## Section 1: Downloading the UCI Har Data and unzips the files
1.  Loaded the downloader and utils library to download the UCI Har Data and unzipped the files.
2.  The UCI Har Data was downloaded from the following site:
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Information regarding the UCI Har Data files.
1. All the data for measurements variables are in x_test and x_train.
2. I renamed the column names right after I read in the data.
3. y_test and y_train have the numeric values for the activity names.  
4. subject_test and subject_train had the subject ids of the participants in the human activity recognition study.
5. activity_name :  The numeric values are 1 through 6. Their descriptive names respectively are "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING" and "LAYING".  These were taken from the activity_labels.txt file which links the class labels (numeric values) with their activity names.
6.  subject_ID :  There were 30 subjects who participated in the study.  Measurements were taken for these 30 subjects whose ids are from 1 through 30. (found in y_test and y_train files)
7. The features.txt file has a total of 561 variables.(Measurement Variables)

## Section 2: Merges the training and the test sets to create one data set
1. Read in the names from features.txt into object VarNames.
2. As soon as I read in the files, I renamed their columns accordingly. 
3. x_test and y_test were combined together with subject_test to create one dataset. This is stored in an object called  "datatest".
4. x_train and y_train were were combined together with subject_train to create another dataset. This is stored in an object called "datatrain".
5. Finally both these datasets were combined using rbind to create an object called, "MergedData",

## Section 3: Extracts only the measurements on the mean and standard deviation for each measurement.
1. Extracts only the measurements ( used the function grepl) on the mean and standard deviation for each measurement variable. 
2. Only column names where the words "mean" and "std" appeared in the description of their column names in object, "MergedData"  were extracted.
3. This extraction resulted in 79 columns/variables with the word "mean" and "std" in their names.  
4. These 79 variables are stored in the object called full_dataextract.  These measurement variables , start in column 3.
5. Did not select the variables with mean in their names that were related to angle because these were angle measurements between 2 vectors as stated in the features_info.txt file.

## Section 4: Uses descriptive activity names to name the activities in the data set
1. Created a for loop to replace the descriptive activity_name in place of their numeric values.

## Section 5: Appropriately labels the data set with descriptive variable names
1. The column names in the object, full_dataextract were not changed from the original names found in features.txt file.  The only manipulation performed  was to rename the column names where the word "body", appeared twice in the description.  I felt this was a typo and replaced those names with the word "body" to only appear once.
2. The rest of the names are identical to what appears in the features.txt file.
3. Used the dplyr library to sort the data using the arrange function.
4. I did a sort on the full_dataextract and stored that result in an object called "sortedData".
   I took this step so that it was easier for me to check my work to see if my mean function was applied correctly by each 
  activity and each subject under step 6. 

## Information regarding the Measurement Variables
1. The measurements reflecting the mean and standard deviation were taken by the following method:  
  	 + If taken using accelerometer, the abbreviation in the variable name is Acc.
		 + If taken using a gyroscope the abbreviation in the variable is Gyro.
		 + '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
		 + The t in the name denotes time domain signal.
		 + The f in the name denotes a Fast Fourier Transform (FFT) calculation .
		 + Mag is the abbreviation for Magnitude where the magnitude was calculated using Euclidean norm for 
       the 3 dimensional signals.

2. The measurement variables with only the word "mean" and "std" are below:  This is what was extracted in step 5 and  stored in the object, "full_dataextract".

 + 3 tBodyAcc-mean()-X
 + 4 tBodyAcc-mean()-Y
 + 5 tBodyAcc-mean()-Z
 + 7 tGravityAcc-mean()-Y
 + 8 tGravityAcc-mean()-Z
 + 9 tBodyAccJerk-mean()-X
 + 10 tBodyAccJerk-mean()-Y
 + 11 tBodyAccJerk-mean()-Z
 + 12 tBodyGyro-mean()-X
 + 13 tBodyGyro-mean()-Y
 + 14 tBodyGyro-mean()-Z
 + 15 tBodyGyroJerk-mean()-X
 + 16 tBodyGyroJerk-mean()-Y
 + 17 tBodyGyroJerk-mean()-Z
 + 18 tBodyAccMag-mean()
 + 19 tGravityAccMag-mean()
 + 20 tBodyAccJerkMag-mean()
 + 21 tBodyGyroMag-mean()
 + 22 tBodyGyroJerkMag-mean()
 + 23 fBodyAcc-mean()-X
 + 24 fBodyAcc-mean()-Y
 + 25 fBodyAcc-mean()-Z
 + 26 fBodyAcc-meanFreq()-X
 + 27 fBodyAcc-meanFreq()-Y
 + 28 fBodyAcc-meanFreq()-Z
 + 29 fBodyAccJerk-mean()-X
 + 30 fBodyAccJerk-mean()-Y
 + 31 fBodyAccJerk-mean()-Z
 + 32 fBodyAccJerk-meanFreq()-X
 + 33 fBodyAccJerk-meanFreq()-Y
 + 34 fBodyAccJerk-meanFreq()-Z
 + 35 fBodyGyro-mean()-X
 + 36 fBodyGyro-mean()-Y
 + 37 fBodyGyro-mean()-Z
 + 38 fBodyGyro-meanFreq()-X
 + 39 fBodyGyro-meanFreq()-Y
 + 40 fBodyGyro-meanFreq()-Z
 + 41 fBodyAccMag-mean()
 + 42 fBodyAccMag-meanFreq()
 + 43 fBodyAccJerkMag-mean()      : original name in features.txt is fBodyBodyAccJerMag-mean()
 + 44 fBodyAccJerkMag-meanFreq()  : original name in features.txt is fBodyBodyAccJerMag-meanFreq() 
 + 45 fBodyGyroMag-mean()         : original name in features.txt is fBodyBodyGyroMag-mean()
 + 46 fBodyGyroMag-meanFreq()     : original name in features.txt is fBodyBodyGyroJerkMag-mean()
 + 48 fBodyGyroJerkMag-meanFreq() : original name in features.txt is fBodyBodyAccJerMag-meanFreq()
 + 49 tBodyAcc-std()-X
 + 50 tBodyAcc-std()-Y
 + 51 tBodyAcc-std()-Z
 + 52 tGravityAcc-std()-X
 + 53 tGravityAcc-std()-Y
 + 54 tGravityAcc-std()-Z
 + 55 tBodyAccJerk-std()-X
 + 56 tBodyAccJerk-std()-Y
 + 57 tBodyAccJerk-std()-Z
 + 58 tBodyGyro-std()-X
 + 59 tBodyGyro-std()-Y
 + 60 tBodyGyro-std()-Z
 + 61 tBodyGyroJerk-std()-X
 + 62 tBodyGyroJerk-std()-Y
 + 63 tBodyGyroJerk-std()-Z
 + 64 tBodyAccMag-std()
 + 65 tGravityAccMag-std()
 + 66 tBodyAccJerkMag-std()
 + 67 tBodyGyroMag-std()
 + 68 tBodyGyroJerkMag-std()
 + 69 fBodyAcc-std()-X
 + 70 fBodyAcc-std()-Y
 + 71 fBodyAcc-std()-Z
 + 72 fBodyAccJerk-std()-X
 + 73 fBodyAccJerk-std()-Y
 + 74 fBodyAccJerk-std()-Z
 + 75 fBodyGyro-std()-X
 + 76 fBodyGyro-std()-Y
 + 77 fBodyGyro-std()-Z
 + 78 fBodyAccMag-std()
 + 79 fBodyAccJerkMag-std()     : original name in features.txt is fBodyBodyAccJerMag-std()
 + 80 fBodyGyroMag-std()        : original name in features.txt is fBodyBodyGyroMag-std()
 + 81 fBodyGyroJerkMag-std()    : original name in features.txt is fBodyBodyGyroJerkMag-std()

## Section 6: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
1. Loaded the reshape2 library to create my wide form, tidy data.  Used the melt and dcast functions to calculate the mean for each measurement variable by each activity and each subject.  This was stored in an object called "activityData".
2. Finally, I used the write.table function to create the tidy data set called "TidyDataSet.txt"