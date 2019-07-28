Codebook:

For further Details on how I dealt the data in R, please check the Code. It is commented in bigger detail.

Generally, after downloading und Unpacking the necessary data into my Working Directory, I use R to perform the following steps:

1) reading the data into dataframes (read.table is used for X and Y on test and train datasets, aswell as the subjects, the activitylabels and the features).
The names of the variables correspond with the names of the txt.files containing the original data.

2) I remove the "_" from the activitylabels via gsub and also select only the features containing mean and std via grep.

3) I merge the datasets (subject, X and Y via rbind)
gsub removes the "()" from the featurelabels and "merge" gives me the correct activitylabels instead of the numbers 1 to 6.

4) I cbind the data subject, X and activitylabels as merged tidy data.

5) From the data set in step 4, I create a second, independent tidy data set with the average of each variable for each activity and each subject.

