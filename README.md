COURSERA - GETTING AND CLEANING DATA - PROJECT

Author: Altemir Palmede Pedroso

Date: Saturday, October 24, 2015

README Objective: Explain how the R script was developed to get and clean the data from the link

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zipworks (file run_analysis.R)


The main steps of the R scrips are as following:

1) Show basic information for the data

Load packages "data.table" and "reshape2"


2) Create 1st set of data set (x_test and y_test) 

Load subjects data

Load data labels 

Load features list

Create factor LABELS with 6 levels (activity_labels)

Extract only the measurements on the mean and standard deviation for each measurement.

Load data from X_test & y_test files

Rename data labels with activity name

Merge data, subjects, and labels to single tiny data set


3) Create 2nd set of data set (x_train and y_train):

Repeat the steps of item for data from training 


4) Merge test and train data


5) Write tiny data set to file
