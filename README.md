# Getting-and-Cleaning-Data

*An important note: the dplyr package is used in this script and must be installed and loaded prior to running

The first block in the run_analysis() script sets the directory path on the local drive.  The working directory for this file includes the files x_test, y_test, subject test, x_train, y_train and subject_train.  The test datasets contain 561, 1 and 1 variable respectively with 947 observations each, which are then column bound together as a test_table.  The train datasets contain identical numbers of variables with 7352 observations each.  The train datasets are bound together similarly to the test sets.

To row bind the test and train datasets, the column for y_test and y_train is named "activity_name", and the column for subject_test and subject_train is named "Subject_ID".  The datasets are then row bound with readable column names for the subject and activity columns, but simply V1:V561 for the other columns.  The full dataset contains 563 variables and 10299 observations.

After reading the features.txt file in the zip file download, it is possible to determine all columns that contain either mean or std measurements. This is interpreted to be both raw mean/std measurements, as well as mean()/std() measurements, which when selected from the full dataset using dplyr (along with the activity and subject columns) yields 67 variables in total.  

The activity name column is then applied strings instead of numeric values per the activity_labels.txt file in the zip download.  This is done by subsetting the columns in the selected dataset and using the as.character function with the subset activity_name string.

Column names are then applied to the remaining columns (i.e. those selected from V1:V561).

The properly labeled data set is then grouped by subject_id, then activity type, in ascending order, such that they can be summarized.

The aggregated data is then summarized using the aggregate function, where the data is subset by subject_id and activity.  This dataset is then arranged by subject_id, instead of activity label, and the unecessary columns are dropped.

Finally, the summarized dataset is output to the working directory as a text file.
