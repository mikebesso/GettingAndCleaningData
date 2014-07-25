# Getting and Cleaning Data Project - Code Book

## The Original Data

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

## Tidy Processing

### Assumptions

* The data from the zip file is extracted to the working directory keeping the same structure in a folder called _data_.

### Approach

* For the data in both the test and training folders,
 * The X, Y and subject_text files
 * The columns were named using the features file (after first making the names more readable)
 * The activity codes were replace with the lables from the activity labels file.

* The resultant data frame from above was then normalized with melt, into
  * Dimensions
   * subject
   * activity
   * variable
  * Measures
   * the mean of the measurement

* Two additional dimensions were inferred from the variable names
 * axis (X, Y, Z)
 * domain (time, frequency)
 
* The variable dimension was the cleaned up again to remove reference to axis and domain.
