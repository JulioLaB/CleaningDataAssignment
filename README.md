# CleaningDataAssignment
A repository that includes the final course assignment work

There are three documents
* this README
* A cook book where the variables are defined
* An R script to run the analysis.

To run the analysis in you PC you have to change the path (line 10 of the Rscript), so it takes you to the folder "UCI HAR Dataset" in your PC. The code is commented to ease understanding. Each one of the steps that leads to the final tidy dataset is explicitly differentiated from the others.

The analysis fullfills the following requirements (extracted from the assignment page):
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To read the tidy dataset use the following code in R (where "path" is the path in your computer where the file can be found)

##########################################################################

path= #define path here

data <- read.table(file = paste0(path, "\\\\tidy_means_dset.txt"), header = TRUE)

#NOTE If you are not using windows you may have to substitute "\\\\" with "/" here and elswhere in the script

##########################################################################
