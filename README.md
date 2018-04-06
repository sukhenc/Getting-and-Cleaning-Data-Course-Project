# Coursera *Getting and Cleaning Data* Course Project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for further analysis.

This repository contains the following files:

- `README.md`, this file, which provides an overview of the data set and how it was created.
- `tidy.txt`, which contains the data set.
- `CodeBook.md`, the code book, which has the description of the data set 
- `run_analysis.R`, the R script whihc was used to create the data set 

## Study design <a name="study-design"></a>

The source data set that this project was based on was obtained from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), which describes how the data was initially collected as follows:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Training and test data were first merged together to create one data set, then the measurements on the mean and standard deviation were extracted for each measurement (79 variables extracted from the original 561), and then the mean of each measurements were calculated for each subject and activity, resulting in the final data set.

## Creating the data set <a name="creating-data-set"></a>

The R script `run_analysis.R` can be used to create the data set for raw data. It dowloands the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

- Download and unzip source data if it doesn't exist already.
- Load the activity and feature info.
- Loads both the training and test datasets, keeping only those columns which are mean or standard deviation of a measurement
- Appropriately label the data set with descriptive variable names.
- Merge the training and the test sets to create one data set.
- Use descriptive activity names to name the activities in the data set.
- Create a second, independent tidy set with the mean of each variable for each activity and each subject.
- Write the data set to the `tidy.txt` file.

The `tidy.txt` in this repository was created by running the `run_analysis.R` script using R version 3.3.3 (2017-03-06) on Windows 7 64-bit edition.
