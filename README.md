# CleaningDataAssignment
A repository that includes the final course assignment work

There are three documents
* this README
* A cook book where the variables are defined
* An R script to run the analysis.

To run the analysis you have to change the path (line 10 in the Rscript) that takes you to the folder "UCI HAR Dataset".

The analysis fullfills the following requirements:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Each step is explicitly differentiated fom the others and the code is commented to ease understanding.

To read the data set use the following code in R (where "path" is the path in your computer where the file can be found)

##########################################################################
path= #define path here
data <- read.table(file = paste0(path, "\\tidy_means_dset.txt"), header = TRUE)
##########################################################################
