---
title: "README"
author: "KaidenFrizu"
date: "6/29/2020"
output: html_document
---

This repository is a part of Peer Assignment as one of the course requirements in Coursera: "Getting and Cleaning the Data" by John Hopkins University. 

***

### Dataset Overview

"One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone."

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

For more details, you can visit this [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
You can download the dataset in this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

***

### Scope of the Project

The objective of this project is to create a tidy data set from the given raw data. In this project, the only data files that would be processed are: `features.txt`, `activity_labels.txt`, `X & Y Train`, `X & Y Test`, `subject_train`, and `subject_test` (These files can be found from the download link above). The following features in `features.txt` that is concerned in this project are only columns that calculates the mean and the standard deviation.

***

### R Analysis Script

The file `run_analysis.R` contains several functions that is used to create a tidy data set. The following functions are:

* `datacheck()`
* `dataextract()`
* `mean_sd_find()`
* `autobind()`
* `mean_sd_summary()`
* `activity_sub()`

If you want a quick run of the functions, source the file `run_analysis.R` and type `simulation_analysis()` in which it makes the variables and performs the functions for you. Make sure to set your working directory first to **GCD-Peer-Assignment-master** folder (or any other folder) before doing this.

See codebook.md for detailed description of the functions used