#Code Book #

This document records the variables and transformations used to tidy up the following data:
>*[Human Activity Recognition][1]*

## Description of data
The data has been gathered through experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity. 

## Variables

 - trainSet: Raw data from the training set;
 - testSet: Raw data from the test set;
 - subjTest: Subjects from the test set;
 - subjTrain: Subject from the training set;
 - lblSetTest: Codes that correspond to activity in the test data set;
 - lblSetTrain: Codes that correspond to activity in the train data set;
 - features: Variable names for both data sets;
 - actLabels: Activity names;

##Transformation
The following transformations are dependent on the following libraries:
>* plyr;
>* dplyr;

Once all the necessary data has been read into R, the transformation steps were:

 1. Merge *lblSetTrain* with *actLabels* to link activity to its code number. Assign resulting table to temporary variable, *labeltemp*;
 2. Bind columns of *labeltemp* to the training data set;
 3. Bind the subjects to the training data set;
 4. Repeat steps *1* to *3* with respect to the test data set;
 5. Bind both resulting sets into the *finalSet*;
 6. Rename the columns with the proper variable names;
 7. Eliminate duplicate variables;

Now we have a complete data set that is ready to be manipulated with functions from the *dplyr* library.

 1. Select the variables that correspond to the mean and standard deviation for each measurment;
 2. Group the data by subject and activity;
 3. Summarise each variable taking its mean;

Finally, the data is exported into a *txt* file for display.



  [1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones