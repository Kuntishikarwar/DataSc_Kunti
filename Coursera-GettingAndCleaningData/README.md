Getting and Cleaning Data
This is the course project for the Getting and Cleaning Data Coursera course.
The Script run_analysis.R performs the following steps in order to retreive tidy data set from  experiments that have been carried out with a group of 30 volunteers
each performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)wearing a smartphone .

*******************Steps to get Tidy data set******************************
Set working directory
Initialize the file URL and zipfilename for data directory to be downloaded.
Check if the the sample data is not present in the working directory. in case its not present download the dataset from URL initialized in previous step.
set working directory as the Data Directory downloaded.
Load the activity and feature attributes
subset the features data to capture only attributes that correspond to std deviation or means of the  measurements  and standardize the column names
Load training set for subjects,activities and measurements and combine all of them togeather into final training set
Load test set for subjects,activities  and measurements and combine all of them togeather into final test set
Combine final training and test set to create a single Dataset and assign proper column names to all attributes of the data set
Merge combined data set with activity dataset to get activity names description in the final data set
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
Store the  finaly cleaned data in the file final_tidy_data.txt.