
## Load the libraraies needed
library(dplyr)
library(data.table)
library(plyr)
library(dtplyr)


## Import the data from the text files
x_test <- fread("data/test/X_test.txt")
y_test <- fread("data/test/y_test.txt")
subject_test <- fread("data/test/subject_test.txt")
x_train <- fread("data/train/X_train.txt")
y_train <- fread("data/train/y_train.txt")
subject_train <- fread("data/train/subject_train.txt")
features <- fread("data/features.txt")
activity_labels<- fread("data/activity_labels.txt")
      
    
