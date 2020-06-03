library(data.table)
library(dplyr)
#Download dataset file and unzip it
dataset_url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "getdata_projectfiles_UCI HAR Dataset.zip")
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
#Read datasets train and test from directories created and load them into data table objects
#Reading 561-feature vector with time and frequency domain variable
homedir <- getwd()
colnames_attrib <- fread(paste(homedir, "/UCI HAR Dataset/features.txt", sep = ""))
dataset_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = colnames_attrib$V2)
dataset_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = colnames_attrib$V2)
#Reading Its activity label
activities_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
activities_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
#Reading identifier of the subject who carried out the experiment
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
#1.Merging the training and the test datasets to create one dataset of each kind of attribute Information
#- A 561-feature vector with time and frequency domain variables: merged_datasets
merged_datasets <- merge(dataset_train, dataset_test, all = TRUE)
#- Its activity label: merged_activities
merged_activities <- rbind(activities_train, activities_test)
#- An identifier of the subject who carried out the experiment: merged_subject
merged_subject <- merge(subject_train, subject_test, all = TRUE)
#Extract mean and standard deviation for each measurement.
#Test each column name to search for particular string - mean()
ind_mean <- grepl('mean', colnames(merged_datasets))
#Test each column name to search for particular string - std()
ind_std <- grepl('std', colnames(merged_datasets))
#Create a dataset only with mean and std measurements 
merged_mean_std <- cbind(merged_datasets[ind_mean], merged_datasets[ind_std])
#Merge all data
merged_all <- cbind(merged_subject, merged_activities, merged_mean_std)
#3.Uses descriptive activity names to name the activities in the data set
activities_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("ActivityCode", "ActivityName"))
merged_all$Activity <- activities_labels[merged_all$Activity,2]
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#Grouping dataset for activity and subject
group_merged_all <- group_by(merged_all,Activity,Subject)
#After grouping for activity and subject, calculate average for each variable
merged_avg <- group_merged_all %>% mutate(across(everything(), mean, na.rm = TRUE))