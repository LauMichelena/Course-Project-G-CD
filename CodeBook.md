**Experimental design and background:**
---------------------------------------

Human Activity Recognition Using Smartphones Dataset

Version 1.0

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

**

Packages needed
---------------
Besides the basic packages in R, for this code you'll need:

 - data.table
 - reshape2
 - dplyr

**


**Raw data:**
-------------

The raw data was download from:
`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`
And unzip manually

These are the seven files inside used to create the data:

 - X_test.txt: data from the subject on the test set
 - X_train.txt: data from the subject on the train set
 - y_test.txt: activities (in numbers) corresponding to the test set
 - y_train.txt: activities (in numbers) corresponding to the train set
 - features.txt: variables names in a data.frame
 - subject_test.txt subject id for the test set
 - subject_train.txt: subject id for the train set
 - activity_labels.txt: names corresponding to the activity's number un the y test and train sets.

*How the files are combined is explained in the Processed data section*

**Processed data:**
-------------------

The code is divided in five steps, according to the assignment.

 **Step 1: Merges the training and the test sets to create one data set.**

All the files except features and activity_labels were put toghether using a combination of `cbind` and `rbind`as shown in run_analysis.R and following this instructions:
![alt text][1]

The final part of this step was a data frame of 10229x563 without colums names, that looks like this:
![alt text][2]

 **Step 4: Appropriately labels the data set with descriptive variable names.**

 This step is out of order because it's easier to add the column names already fixed. The labels where modified to remove the "()-" part, and substitude with "_" as shown in the run_analysis.R.

The final part of this step was a data frame of 10229x563 with colums names, that looks like this:
![alt text][3]

**Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.**

For this step, only de variables ending in mean() or std() where considered; meanFreq() was not taken into acount because is the weighted average of the frequency components, not an average of a measure of an activity; angles() where not taken into acount because they were not vectors, but angles of a vector. 

In consecuense, the final part of this step was a data frame of 10229x68 (Subject, Activity and 66 measurements)

**Step 3: Uses descriptive activity names to name the activities in the data set**

Using the activity_labels.txt file and the function `factor()`, The numbers of the Activity column where substitute by its appropiate label.

The final part of this step was a data frame of 10229x68, that looks like this:
![alt text][4]

**Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

To create a tidy data set, all features where coerced into one variable. As explained in several threads both a wide or long form of tidy are correct (wide meaning 180 rows and 66 colums, and long 11880 rows and 4 colums). I choose the latter because is easier to read.

Using the `group_by` and `summarise_each` functions, I created a data set that had the average for each combination of subject&activity&feature. And created a txt file with this data.

The final part of this assignment was a data frame of 11880x5, that looks like this:
![alt text][5]


**

Variable Codes:
---------------
The variables in the data frame where:

 *Sj_Id*: Subject Id, a numeric vector from 1 to 30 to identify each of the 30 subjects in the experiment.

*Activity*: Activity perform by the subject(each activity was perform by each subject), a factor vector with this labels:

 - Walking
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING 
 - LAYING

*Feature*:The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ, is a character vector with the 66 labels:

For each of this 8 measures it include 3 axial values and one mean and standard deviation. Meaning that 8x3x2= 48 values
 - tBodyAcc: raw signals in time of the body's aceleration measure with the accelerometer in a 3-axial way (X, Y, Z).
 - tGravityAcc: raw signals in time  of the gravity's aceleration measure with the accelerometer in a 3-axial way (X, Y, Z).
 - tBodyAccJerk:  in time, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals, measure with the accelerometer in a 3-axial way (X, Y, Z).
 - tBodyGyro: raw signals in time  of the body's aceleration measure with the gyroscope  in a 3-axial way (X, Y, Z). 
 - tBodyGyroJerk: in time, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals, measure with the gyroscope in a 3-axial way (X, Y, Z).
 - fBodyAcc: raw signals in frecuency of the body's aceleration measure with the accelerometer in a 3-axial way (X, Y, Z).
 - fBodyAccJerk: in frecuency, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals, measure with the accelerometer in a 3-axial way (X, Y, Z).
 - fBodyGyro:  raw signals in frecuency of the body's aceleration measure with the gyroscope  in a 3-axial way (X, Y, Z).

   
For each of this 9 measures it inlcudes one mean and one standard deviation. Meaning that 9x2= 18
 - tBodyAccMag: Magnitude of the body's aceleration signals were calculated using the Euclidean norm 
 - tGravityAccMag: Magnitude of the gravity's aceleration signals were calculated using the Euclidean norm 
 - tBodyAccJerkMag: Magnitude of these three-dimensional signals were calculated using the Euclidean norm 
 - tBodyGyroMag: Magnitude of these three-dimensional signals were calculated using the Euclidean norm 
 - tBodyGyroJerkMag: Magnitude of these three-dimensional signals were calculated using the Euclidean norm 
 - fBodyAccMag:Magnitude of these three-dimensional signals were calculated using the Euclidean norm 
 - fBodyAccJerkMag:Magnitude of these three-dimensional signals were calculated using the Euclidean norm    
 - fBodyGyroMag:Magnitude of these three-dimensional signals were calculated using the Euclidean norm  
 - fBodyGyroJerkMag: Magnitude of these three-dimensional signals were calculated using the Euclidean norm 




*Value*: value associated with the given feature, a numeric vector from -1 to +1

**


  [1]: http://i57.tinypic.com/10xres0.png
  [2]: http://i57.tinypic.com/vyo3g5.png
  [3]: http://i57.tinypic.com/zn1m5v.png
  [4]: http://i61.tinypic.com/2urxwrb.png
  [5]: http://i60.tinypic.com/2ijj7uo.png