# Getting and Cleaning Data Project

## Instructions

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 

* a tidy data set as described below
* a link to a Github repository with your script for performing the analysis
* a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Solution

### Assumptions

* The data from the zip file is extracted to the working directory keeping the same structure in a folder called _data_.

### Approach

* Since we are merging similar data (test and training) from two different folders, create a function to reuse that code
* When creating a data frame (test or training)
 * Combine data from the X, Y and subject_text files
 * Set column names from features file
 * Get the activity name from activity_labels and _merge_.
* Create a function to do the analysis 
 * Support testing with a _count_ parameter to facilitate quick test runs.  Testing was done using 10 to 100 rows of data at a time.
 * Return a list of data frame that can be inspected or written to files
 * Produce a data frame that meets the first requirement (just _means_ and _std_ columns)
 * Create a _tidy_ data frame that normalizes the data into the following columns
  * Dimensions
   * subject
   * activity
   * axis (X, Y, Z)
   * domain (time, frequency)
   * variable
  * Measures
   * the mean of the measurement

### Results

* The resulting data files have been uploaded to coursera
* A codebook was created


