library(downloader)  ## used for downloading https files
library(utils)       ## needed for unzip function

########## Download the zipped file and the unzip into a folder called Dataset #################################
URL<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(URL, dest="Dataset.zip", mode="wb") 
################################################################################################

##  Step 1: Merges the training and the test sets to create one data set
##  Need to read the train and test data  (subject,X and Y)
##  There is a total of 6 files to read in and then merge.
##  Read the files individually and then do a cbind first for test and train separately.
##  Then rbind to to merge test and train data

VarNames<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/features.txt")

##  read the test data into a data frame and rename the columns per the values in VarNames
x_test<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/test/X_test.txt")
colnames(x_test)<-VarNames[,2] 

subject_test<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)<-"subject_ID"

y_test<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/test/y_test.txt")
colnames(y_test)<- "activity_name"

##  read the train data into a data frame and rename the columns per the values in VarNames

x_train<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/train/X_train.txt")
colnames(x_train)<-VarNames[,2]

subject_train<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)<- "subject_ID"

y_train<-read.table("/Users/Usha/Documents/Dataset/UCI HAR Dataset/train/y_train.txt")
colnames(y_train)<- "activity_name"

# fixed variables come before the measured variables
datatest<- cbind(subject_test,y_test,x_test) 
dim(datatest) #[1] 2947  563

datatrain<-cbind(subject_train,y_train,x_train)
dim(datatrain) #[1] 7352  563


MergedData<- rbind(datatest,datatrain)
dim(MergedData)
head(MergedData)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

data_meanextract<- MergedData[ , grepl( "*mean*" , names(MergedData) ) ]
colnames(data_meanextract)
dim(data_extract)

data_stdextract<- MergedData[ , grepl( "*std*" , names(MergedData) ) ]
colnames(data_stdextract)
dim(data_stdextract)

full_dataextract<- cbind(MergedData[,1:2],data_meanextract,data_stdextract)
colnames(full_dataextract)
head(full_dataextract)


## Step 3: Uses descriptive activity names to name the activities in the data set
## In the activity_labels.txt there are 6 activity names that are used in the y test and train files.
   
for (i in 1:10299){
	if (full_dataextract$activity_name[i]==1){
      full_dataextract$activity_name[i]<-"WALKING"
	}
	if (full_dataextract$activity_name[i]==2){
      full_dataextract$activity_name[i]<-"WALKING_UPSTAIRS"
	}
	if (full_dataextract$activity_name[i]==3){
      full_dataextract$activity_name[i]<-"WALKING_DOWNSTAIRS"
	}
	if (full_dataextract$activity_name[i]==4){
      full_dataextract$activity_name[i]<-"SITTING"
	}
	if (full_dataextract$activity_name[i]==5){
      full_dataextract$activity_name[i]<-"STANDING"
	}
	if (full_dataextract$activity_name[i]==6){
      full_dataextract$activity_name[i]<-"LAYING"
	}
}


##  Step 4: Appropriately labels the data set with descriptive variable names
##  I did not change the variables names ( they made sense to me) given in the features.txt file other than  
##  for the variables that had the word "Body" appearing twice in their names.
##  The variable names in features.txt was used inplace of V1:V561 in step 1.

colnames(full_dataextract)
dataset<-gsub("BodyBody","Body",(colnames(full_dataextract)))  
head(dataset)
colnames(full_dataextract)<- dataset[1:81]

library(dplyr)
# sorted the data so that it was easier for me to check my work.
sortedData<-arrange(full_dataextract,subject_ID,activity_name)

head(sortedData)
dim(sortedData)  # 10299 81




##  Step 5:From the data set in step 4, create a second, independent tidy data set with
##   the average of each variable for each activity and each subject.
##   data set from step 4 is named sortedData

library(reshape2)

activityMelt<- melt(sortedData,id=c("activity_name","subject_ID"))							
dim(activityMelt)   # 813621 4                                                    

## Tidy Data - wide form
activityData<-dcast(activityMelt, activity_name + subject_ID ~ variable,mean)
activityData[1:31,] # for me to check if the results are what I expected
dim(activityData)   # 180 81   

write.table(activityData,"/Users/Usha/Documents/TidyDataSet.txt",row.name=FALSE)


