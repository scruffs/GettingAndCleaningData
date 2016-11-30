run_analysis <- function() {
      
      ## Remove the extra column from features to leave just a 
      ## vector of names
      features <- features$V2
      
      ## Extract the names of the features from the file and remove
      ## dashes and braces from the names
      features <- gsub("-", "_", features)
      features<- gsub("\\(|\\)", "", features)
      
      ## Add the activity label for the end column once the 
      ## tables have been merged
      features <- c("subject", "activity", features)
      
      
      ## Add the activity type to a column on the end
      x_train <- cbind(subject_train, y_train, x_train)
      x_test <- cbind(subject_test, y_test, x_test)
      
      ## Set the column names in the data sets to the features.
      names(x_test) <- features
      names(x_train) <- features
      
      ## Merge the two data sets into one table
      x_merged <- rbind(x_train, x_test)
      
      ## Extract only the columns that have "mean" or "std" in the name
      ## to keep the mean and standard deviation columns of data. Also 
      ## need to keep the activity and subject columns.
      mean_std_names <- features[grepl("mean|std|activity|subject", features)]
      mean_std <- select_(x_merged, .dots = mean_std_names)
      
      ## Recast the "activity" column as a factor and then apply the
      ## activity names as those factors.
      mean_std$activity <- as.factor(mean_std$activity)
      levels(mean_std$activity) <- activity_labels$V2

      ## Group the data by the subject and activity. The summarize fundtion 
      ## by these columns. That grouped table is piped into the summarize
      ## mean function.
      data_to_output <- mean_std %>% 
            group_by(subject, activity) %>% 
            summarise_each(funs(mean))
      
      ## Write the data to a file.
      write.table(data_to_output, file = "data_mean_std.txt")
      
      ## Leave the table as the return value
      data_to_output
} 