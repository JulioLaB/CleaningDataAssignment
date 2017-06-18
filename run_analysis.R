##################################################################################
## You should create one R script called run_analysis.R that does the following.##
##################################################################################

###########a###########################################################
## 1. Merges the training and the test sets to create one data set. ##
######################################################################

#provide a path to the folder UCI HAR Dataser
path <- "C:\\Users\\Julio\\Documents\\data-science-jhuniversity\\3cleaningdata\\assignment\\UCI HAR Dataset\\"
#setwd to yourpath
setwd(path)
rm(path) #we'll not need this from now on


#to simplify things let's do a for loop, to do the same with training and tests sets
sets <- c("TRAIN", "TEST")

for(set in sets){
        
        #read the appropiate data
        subject <- read.table(paste0("..\\UCI HAR Dataset\\",set, "\\subject_",set,".txt"))
        x <- read.table(paste0("..\\UCI HAR Dataset\\", set, "\\X_", set,".txt"))
        y <- read.table(paste0("..\\UCI HAR Dataset\\", set, "\\y_", set,".txt"))
        
        #name the cols of your dfirst two columns
        colnames(subject)<- "subject"
        colnames(y)<- "activity"
        
        #if dframe does not exist, create it (this happens in the first iteration of the for loop)
        #else, rbind the new reads to the previous ones (this happens in the secont loop)
        if(!exists("dframe")){
                dframe <- cbind(set= set, subject, y, x)
        }else{
                dframe <- rbind(dframe, cbind(set= set, subject, y, x))
        }
        
        #we´ll not need the following...
        rm(subject)
        rm(x)
        rm(y)
}

#that was it, now we have merged the training and the test sets to create the dframe dataset.



############################################################################
### 2. Extracts only the measurements on the mean and standard deviation ###
### for each measurement ###################################################
############################################################################

#read and store feature names from file
feature_names <- read.table("..\\UCI HAR Dataset\\features.txt", na.strings=NA, stringsAsFactors=FALSE)

#get the index of columns that in feature names have the word mean or std
cols_with_means_and_sds <- grep("mean|std",  feature_names[,2])

#select the columns set, subject, activity and columns that have means and std
#IMPORTANT, mean the +3, to account foo the first three columns (test,)
msdframe <- select(dframe, set, subject, activity, cols_with_means_and_sds + 3 )

#msdframe only has the measurements on the mean and SD of each measurement



#################################################################################
### 3. Uses descriptive activity names to name the activities in the data set ###
#################################################################################

#read and store codes activity names from file
activity_names <- read.table("..\\UCI HAR Dataset\\activity_labels.txt", col.names = c("code", "activity"),
                             na.strings=NA, stringsAsFactors=FALSE)

# use descriptive activity names to name the activities
msdframe <- msdframe %>% mutate(activity = factor(activity, labels = activity_names$activity))

#now msdframe has descriptive names for each activity



#############################################################################
### 4. Appropriately labels the data set with descriptive variable names. ### 
#############################################################################

#get the names of the measured variables that you are including (same as before but with value = TRUE)
names_of_measured_vars <- cols_with_means_and_sds <- grep("mean|std",  feature_names[,2], value=TRUE)

#clean the names a bit, I use "." as separator
names_of_measured_vars <- gsub("\\(\\)-", "-", names_of_measured_vars)
names_of_measured_vars <- gsub("\\(\\)", "", names_of_measured_vars)
names_of_measured_vars <- gsub("-", ".", names_of_measured_vars)

#provide the variables descriptive names
colnames(msdframe) <- c("set", "subject", "activity", names_of_measured_vars)

#I consider the names provided by Reyes-Ortiz et al. (the scientists that took the measurements)
#descriptive so I used those names (e.g. tBodyAcc.mean.X is more descriptive than V4).
#now msdframe has descriptive variable names



###################################################################################
### 5. From the data set in step 4, creates a second, independent tidy data set ###
### with the average of each variable for each activity and each subject. #########
###################################################################################

#group the data by set, subject, and activity
grouped_msdframe <- group_by(msdframe, set, subject, activity)

#use function summarize_at with input grouped_msdframe, specify variables with grouped_msdframe
#and set the function to mean
means <- summarize_at(grouped_msdframe, .vars = names_of_measured_vars, .funs=(mean))

#from msdframe we have created means, a tidy dataset with the means of each variable for 
#each activity and each subject

#intuitive check: the object means has 180 rows, that is 30 individuals times 6 activities!!! 


#now save it
write.table(means, file = "..\\tidy_means_dset.txt",  row.name=FALSE, col.names = TRUE)


#END
