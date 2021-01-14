run_analysis <- function() {
      ##sets directory path
      setwd("/Users/dan 1/Desktop/Coursera/Data Science with R/Cleaning and Tidying Data with R")
      
      ##reads x_test, y_test, subject_test files and binds them together
      ##into test_table
      x_test <- read.table("X_test.txt")
      y_test <- read.table("Y_test.txt", col.names="activity_name")
      subject_test <- read.table("subject_test.txt", col.names="subject_id")
      test_table <- cbind(x_test, y_test, subject_test)
      
      ##reads x_train, y_train, subject_train files and binds them together
      ##into train_table
      x_train <- read.table("X_train.txt")
      y_train <- read.table("Y_train.txt", col.names="activity_name")
      subject_train <- read.table("subject_train.txt", col.names="subject_id")
      train_table <- cbind(x_train, y_train, subject_train)
      
      ##bind the test_table and train_table together to create one table with
      ##563 variables and 10299 observations
      full_set <- rbind(test_table, train_table)
      
      ##Select all columns with mean() or std() in name, according to
      ##features.txt
      tidy_set <- select(full_set, subject_id, activity_name, V1:V6, V41:V46, 
                         V81:V86, V121:V126, V161:V166, V201:V202, V214:V215, 
                         V227:V228, V240:V241, V253:V254, V266:V271, V345:V350, 
                         V424:V429, V503:V504, V516:V517, V529:V530, V542:V543)
      
      ##Apply names to the activity_name column
      act_names <- c("1"="Walking", "2"="Walking Upstairs", 
                     "3"="Walking Downstairs", "4"="Sitting", "5"="Standing", 
                     "6"="Laying")
      tidy_set$Activities <- as.character(act_names[tidy_set$activity_name])
      tidy_set <- select(tidy_set, -activity_name)
      
      ##Apply names to the rest of the remaining variables
      tidy_names <- c("Subject_ID", "tBodyAcc.mean.X", "tBodyAcc.mean.Y",
                      "tBodyAcc.mean.Z", "tBodyAcc.std.X", "tBodyAcc.std.Y",
                      "tBodyAcc.std.Z", "tGravityAcc.mean.X", 
                      "tGravityAcc.mean.Y", "tGravityAcc.mean.Z",
                      "tGravityAcc.std.X", "tGravityAcc.std.Y",
                      "tGravityAcc.std.Z", "tBodyAccJerk.mean.X",
                      "tBodyAccJerk.mean.Y", "tBodyAccJerk.mean.Z",
                      "tBodyAccJerk.std.X", "tBodyAccJerk.std.Y",
                      "tBodyAccJerk.std.Z", "tBodyGyro.mean.X",
                      "tBodyGyro.mean.Y", "tBodyGyro.mean.Z",
                      "tBodyGyro.std.X", "tBodyGyro.std.Y", "tBodyGyro.std.Z",
                      "tBodyGyroJerk.mean.X", "tBodyGyroJerk.mean.Y",
                      "tBodyGyroJerk.mean.Z", "tBodyGyroJerk.std.X",
                      "tBodyGyroJerk.std.Y", "tBodyGyroJerk.std.Z",
                      "tBodyAccMag.mean", "tBodyAccMag.std",
                      "tGravityAccMag.mean", "tGravityAccMag.std",
                      "tBodyAccJerkMag.mean", "tBodyAccJerkMag.std",
                      "tBodyGyroMag.mean", "tBodyGyroMag.std",
                      "tBodyGyroJerkMag.mean", "tBodyGyroJerkMag.std",
                      "fBodyAcc.mean.X", "fBodyAcc.mean.Y",
                      "fBodyAcc.mean.Z", "fBodyAcc.std.X", "fBodyAcc.std.Y", 
                      "fBodyAcc.std.Z", "fBodyAccJerk.mean.X", 
                      "fBodyAccJerk.mean.Y", "fBodyAccJerk.mean.Z",
                      "fBodyAccJerk.std.X", "fBodyAccJerk.std.Y",
                      "fBodyAccJerk.std.Z", "fBodyGyro.mean.X",
                      "fBodyGyro.mean.Y", "fBodyGyro.mean.Z",
                      "fBodyGyro.std.X", "fBodyGyro.std.Y",
                      "fBodyGyro.std.Z", "fBodyAccMag.mean",
                      "fBodyAccMag.std", "fBodyBodyAccJerkMag.mean",
                      "fBodyBodyAccJerkMag.std", "fBodyBodyGyroMag.mean",
                      "fBodyBodyGyroMag.std", "fBodyBodyGyroJerkMag.mean",
                      "fBodyBodyGyroJerkMag.std", "Activities")
      colnames(tidy_set) <- tidy_names
      
      #Group the tidy data set by subject_id, then activity, in ascending order
      tidy_set <- arrange(tidy_set, Subject_ID, Activities, by_group=TRUE)
      
      grouped_set <- aggregate.data.frame(tidy_set, by=list(tidy_set$Subject_ID,
                                                         tidy_set$Activities),
                                                FUN = mean)
      
      #Rearrange data to group by subject instead of activity, then drop
      #unnecessary columns
      grouped_set <- arrange(grouped_set, Subject_ID)
      grouped_set <- select(grouped_set, -Group.1, -Activities)
      grouped_set <- grouped_set %>% rename(Activity=Group.2)
      
      #Output the grouped summary data set to the working directory
      write.table(grouped_set, "Tidy Data Set", row.names = FALSE, 
                  col.names=TRUE)
      
}