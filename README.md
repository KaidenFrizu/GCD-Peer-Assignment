# README

This repository is a part of Peer Assignment as one of the course requirements in Coursera: "Getting and Cleaning the Data" by John Hopkins University. 

***

### Dataset Overview

"One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone."

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

For more details, you can visit this [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
You can download the dataset in this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

***

### Scope of the Project

The objective of this project is to create a tidy data set from the given raw data. In this project, the only data files that would be processed are: `features.txt`, `activity_labels.txt`, `X & Y Train`, `X & Y Test`, `subject_train`, and `subject_test` (These files can be found from the download link above).
The following features in `features.txt` that are concerned in this project are columns that measures only the mean and the standard deviation of each measurement. Anything that is related to mean() and std() are taken, then the rest are discarded.

***

### About the Data

`features.txt` is a list of all measurements in the study, denoted by a corresponding number. These numbers are used to indicate the order of a set of numbers in a single line found in train and test files.

`activity_labels.txt` is a small text file that can be used as a lookup for substituting its corresponding numbers found in `y_train.txt` and `y_test.txt`.

`x_train` and `x_test` are a series of numbers where the order of numbers within the single line corresponds to the number found in `features.txt`. The frequency of numbers within a single line is exactly the same as the number of measurements in `features.txt`.

`y_train.txt` and `y_test.txt` are sets of numbers which corresponds to the lookup table found in `activity_labels.txt`.

`subject_train.txt` and `subject_test.txt` are numbers that uniquely identifies a particular person in the study.

***

### R Analysis Script

The file `run_analysis.R` contains several functions that is used to create a tidy data set. Additional details of each function can be found in the code book. The primary functions below processes the data in its order:

* `datacheck()` - downloads the untidy data in zip file
* `dataextract()` - extracts the required data in the zip file
* `mean_sd_find()` - locates the required columns which are related to mean() and std()
* `autobind()` - creates tidy data sets for train and test data and binds them together
* `mean_sd_summary()` - creates a mean summary grouped by Activity and Subject
* `activity_sub()` - Performs lookup in Activity column

If you want a quick run of the functions, source the file `run_analysis.R` and type `simulation_analysis()` in which it makes the variables and performs the functions for you. Make sure to set your working directory first to **GCD-Peer-Assignment-master** folder (or any other folder) before doing this.

When the simulation is finished, there are two tables created that contains tidy data (These tables can be manually assigned to a variable if you didn't run the simulation). They are called `Dataset` and `Dataset_summary`.

`Dataset` contains the tidy data that is sorted by Activity, Subject, and measurements. However, the columns of the measurements are named as *V1,V2,V3, etc.*. The description of these column names can be found in the variable `modfeature` and the given code book.

`Dataset_summary` contains the mean of each measurement grouped by activity and subject. 

These two tables are created by the simulation function. When done manually, you have to assign these tables to some variables, so any variable names are fine.

In addition, there are certain variables in this project that cannot be assigned manually. These are `downloaddate`, `listnum`, and `modfeature`. The details can be found in the code book. Furthermore, there are also functions that are not mentioned in this readme. You can check them in the code book provided.