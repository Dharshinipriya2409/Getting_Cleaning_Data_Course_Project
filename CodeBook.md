## Getting and Cleaning Data Course Project - CodeBook

The run_analysis.R script downloads and prepares data according to course data project instructions.

        1. Download data and unzip it in a directory called UCI HAR Dataset.
        
        All training and test sets besides information files for the project are in this directory.
        
        2.  Read datasets train and test from directories created and load them into data table objects. These objects are:
        - dataset_train and dataset_test: contain a 561-feature vector with time and frequency domain variable.
        - activities_train and activities_test: contain its activity label
        - subject_train and subject_test: contain identifier of the subject who carried out the experiment.

        3. Merges training and the test sets to create one data set.
        Each training and test datasets of each kind of attribute Information are separately merged:
        - merged_datasets: a dataset with 561-feature vector with time and frequency domain variables from training and test data.
        - merged_activities: a dataset with activity labels from training and test data.
        - merged_subject: a dataset with all individuals from training and test data.
        - merged_all: a dataset with all subjects, activities and training and test data.
        
        2. Extracts only the measurements on the mean and standard deviation for each measurement.
        To extract mean and standard deviation for each measurement, each column name was searched for particular strings - mean() and std() 
        - merged_mean_std: dataset only with mean and std measurements
        
       3. Uses descriptive activity names to name the activities in the dataset.
       All code values from activity were replace for activity names.

        4. Appropriately labels the data set with descriptive variable names.
        Making data clearer Acc was replaced for accelerometer and Gyro was replaced for  gyroscope in order to identify the features.
        
        5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
        
        -group_merged_mean_std: variable to group dataset for activity and subject.
        -merged_avg: variable to calculate average for all columns - each variable.
        -merged_avg.txt: export dataset as txt to submit assignmet:
        
        
        

        
