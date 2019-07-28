run_analysis <- function(){
  
  # load test and training data  
  
  subject_test = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
  X_test = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
  Y_test = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
  
  subject_train = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
  X_train = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
  Y_train = read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
  
  # load features and activities, also remove "_" from activity Labels
  
  features <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))
  activitylabels <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
  activitylabels$activityLabel <- gsub("_", "", as.character(activitylabels$activityLabel))
  
  #only mean and std
  neededFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureLabel)
  
  ##Merges the training and the test sets to create one data set.
  subject <- rbind(subject_test, subject_train)
  names(subject) <- "subjectId"
  X <- rbind(X_test, X_train)
  
  #Extracts only the measurements on the mean and standard deviation for each measurement. 
  X <- X[, neededFeatures]
  #give appropriate names to the remaining 66 cols (without brackets)
  names(X) <- gsub("\\(|\\)", "", features$featureLabel[neededFeatures])
  
  Y <- rbind(Y_test, Y_train)
  names(Y) = "activityId"
  ##Uses descriptive activity names to name the activities in the data set
  activities <- merge(Y, activitylabels, by="activityId")$activityLabel
  
  # merge data frames of different columns to form one data table
  data <- cbind(subject, X, activities)
  write.table(data, "tidy_merge.txt")
  
  
  # create a dataset grouped by subject and activity after applying standard deviation and average calculations
  library(data.table)
  dataDT <- data.table(data)
  calc_data <- dataDT[, lapply(.SD, mean), by=c("subjectId", "activities")]
  write.table(calc_data, "tidy_calc.txt")
  
}