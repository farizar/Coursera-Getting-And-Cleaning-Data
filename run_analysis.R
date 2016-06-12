# Checks for Data directory and creates one if it doesn't exist and download the dataset
setwd("C://Users//Home//GettingAndCleaningDataCourseProject")
if (!file.exists("Data")) {
  dir.create("Data")
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url = URL,destfile = "./Dataset.zip", method="curl")
  unzip("./Dataset.zip",exdir = "./Data")
}

# List the content of the Data directory and subdirectory
list.files(path = "./Data", recursive = TRUE)

# 1. Merge the training and test sets
X.labels <- read.table("Data/UCI HAR Dataset/features.txt")
X.train <- read.table("Data/UCI HAR Dataset/train/X_train.txt", col.names = X.labels[,2])
X.test <- read.table("Data/UCI HAR Dataset/test/X_test.txt", col.names = X.labels[,2])
merged.X <- rbind(X.train,X.test)

Y.train <- read.table("Data/UCI HAR Dataset/train/Y_train.txt", col.names = "Activities")
Y.test <- read.table("Data/UCI HAR Dataset/test/Y_test.txt", col.names = "Activities")
merged.Y <- rbind(Y.train,Y.test)

subject.train <- read.table("Data/UCI HAR Dataset/train/subject_train.txt", col.names = "Subject_ID")
subject.test <- read.table("Data/UCI HAR Dataset/test/subject_test.txt", col.names = "Subject_ID")
merged.subject <- rbind(subject.train,subject.test)

# 2. Extract only the measurements on the mean and standard deviation for each measurement 
trimmed.X <- merged.X[,grepl("mean()|std()",names(merged.X))]

# 3. Use descriptive activity names to name the activities in the data set
# by replacing numbers in the Y dataset with texts from activity_labels.txt file
activities.label <- read.table("Data/UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
merged.Y[merged.Y == "1"] = activities.label[1,2]
merged.Y[merged.Y == "2"] = activities.label[2,2]
merged.Y[merged.Y == "3"] = activities.label[3,2]
merged.Y[merged.Y == "4"] = activities.label[4,2]
merged.Y[merged.Y == "5"] = activities.label[5,2]
merged.Y[merged.Y == "6"] = activities.label[6,2]

# 4. Appropriately labels the data set with descriptive variable names 
# by adding the Activity labels in merged.Y and the Subject_ID labels in merged.subject
# to the trimmed X dataset
full.dataset <- data.frame(merged.subject,merged.Y,trimmed.X)

# 5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject

# Easy to summarize data (with mean, standard deviation, etc.), broken down by group
library(plyr)   
# Function calculates the column mean for all columns except the first two which are not measurement data
tidy.dataset <- ddply(full.dataset, c("Subject_ID", "Activities"), function(x) colMeans(x[,-(1:2)]))  

# 6. Write out tidy dataset to a text file
write.table(tidy.dataset, "./tidyDataset.txt", row.names = FALSE)