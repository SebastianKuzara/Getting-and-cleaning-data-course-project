library(reshape)
library(dplyr)

# Load data into R:

## test files:
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


## training files:
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Read features:

features <- read.table("./UCI HAR Dataset/features.txt")
features <- melt(features[,2])
features <- t(features)

## activity lables:

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- melt(activity_labels[,2])

# Step 1. Bind data sets:

y <- rbind(y_train, y_test)
x <- rbind(x_train, x_test)
subject <- rbind(subject_train, subject_test)

db <- cbind(subject, y, x)

# Add column names to main data set:

part_feat <- t(as.matrix(c("subject", "activity")))
full_feat <- cbind(part_feat, features)
colnames(db) <- full_feat

# Step 2. Extract measurments on mean and sd:

desired_feat <- sort(as.vector(cbind(-1, 0, t(grep("mean()", features)), t(grep("std()", features))))) +2

db_mean_sd <- db[,desired_feat]

# Step 3. replacing numbers descrabing activities on activity names:

for (i in 1:6) {
  db_mean_sd[,2] <- replace(db_mean_sd[,2], db_mean_sd[,2] == i, as.vector(activity_labels[i,1]))
}

# Step 4. changing column names:

names(db_mean_sd) <- gsub("-", ".", names(db_mean_sd))
names(db_mean_sd) <- gsub("\\()", "", names(db_mean_sd))
names(db_mean_sd) <- gsub("BodyBody", "Body", names(db_mean_sd))


# Create a 2nd data set with means of all variables from
# previous data set for defined groups of subjects and activities

db_sum <- db_mean_sd %>%
  group_by(subject , activity) %>%
    summarize_each(funs(mean))

names(db_sum) <- sub("$", "Mean", names(db_sum))

# Write last data set to .txt file

write.table(db_sum, file = "db_sum.txt", row.names = FALSE)



