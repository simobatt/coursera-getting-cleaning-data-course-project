## Getting and Cleaning Data - Course Project

This repository contains the submission for the "Getting and Cleaning Data" Coursera course, part of the Data Science specialization.

#### Overview
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.
The goal is to prepare tidy data that can be used for later analysis.

#### Raw data
The source data for this project can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
A full description of these data used can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Submission files
`CodeBook.md` is a code book that describes the variables, the data, and any transformations or work performed to clean up the data.
`run_analysis.R` is an R script that does the following:
You should create one R script called run_analysis.R that does the following. 
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive activity names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#### Prerequisites to run the code
The code takes for granted all the data is present in the same folder, un-compressed and without names altered.
- The data must be unzipped and the "UCI HAR Dataset" directory must be placed in the R home directory.
- Data directories and data files names must not be changed.