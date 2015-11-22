# Getting-and-cleaning-data-course-project

# Hello! 

#### Below there is a description how the run_analysis.R script works and how to use it:

##### This script works with data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##### The zip file should be unpacked in R-working directory
##### After run the script, it load data from unpacked directory and work ONLY with files from this directory!!!
##### The script does:
###### - merge train with test data sets and add voluntieers ids and activities ids from downloaded directory into one tidy data set called "db"
###### - create data set that contain only measurement on the mean or sd called "db_mean_sd"
###### - add column names
###### - replace number decribing activities on activity names
###### - create another data set, that contain average of each variable for each volunteer and each activity called "sd_sum"

#### Product of the scrips is also a txt file with data from "sd_sum" data set, that is save in working directory.
