#run_analysis.R

R Script to tidy and summarize data from:
##Human Activity Recognition Using Smartphones Dataset - Version 1.0

Created by David Alexander - June 26, 2016

Data cleanup project required during week 4 of the Coursera / Johns Hopkins Getting and Cleaning Data Course

##Data Source Background
The original experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experimenters
captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, 
where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width 
sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and 
body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

See references under License in this file for more details on the original data set components.

##Output
For this assignment, two data sets are created in R from the original data:

ActivityData = Mean and Std variables organized with descriptive column names, descriptive activity labels, and subject identifier

ActivityMeans = Mean calculated for variable in the ActivityData set grouped by activity and subject


##Each Record Provides:

###ActivityData
- Subject indentifier for the individual who carried out the experiment
- Activity description
- 66 variables containing mean and standard deviation for each original variable recorded from:
	-- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
	-- Triaxial Angular velocity from the gyroscope.

###ActivityMeans
- Same variables as ActivityData but summarized into means grouped by Subject and Activity

##The dataset includes the following files:
- 'README.md'
- 'CodeBook.md'
- 'run_analysis.R': Completes the steps required to tidy and summarize data into the two result tables

##Notes:
- Features were normalized and bounded within [-1,1].
- Each feature vector is a row in the table.
- The script will attempt load the package "dplyr" which is required. The script will not run unless the package has been previously installed in R.

For more information about the original dataset contact: activityrecognition@smartlab.ws

Original data set:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For more information about the R script 'run_analysis.R': david@alexapolis.com

##License:

License recognition carried from the source data documentation:
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
