#Importing the necessary packages for this analysys
library(dplyr)


#This first part of the code just download the file with the data and unzip it into the working directory

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url = url, destfile = "./data.zip")

unzip(zipfile = "./data.zip")




url_training_dataset <-   "./UCI HAR Dataset/train/X_train.txt"
url_test_dataset <- "./UCI HAR Dataset/test/X_test.txt"

dataset_train <- read.table(url_training_dataset)
dataset_test <- read.table(url_test_dataset)

#We can see, reading the description of the dataset on the author´s site 
#(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) 
#that these datasets are incomplete, each row represent one type of activity and the labels are in the "y" variant of the dataset
#The short description of each collumn is found on the"activity.txt" file

#Let?s now move to the first step which is to merge the two datasets! 


merged_dt <- rbind(dataset_test, dataset_train)


#In the second step we?ll extract only the variables regarding the means and standard deviation, but first we?ll need
# to rename the collumns

url_collumns_names <- "./UCI HAR Dataset/features.txt"

collumns <- read.table(url_collumns_names)

collumns <- gsub("-","", collumns[,2], fixed = TRUE)
collumns <- gsub("()","", collumns, fixed = TRUE)

colnames(merged_dt) <- collumns


mean_st <- c(grep("mean", colnames(merged_dt)), grep("std", colnames(merged_dt)))

dt_mean_st <- merged_dt[, mean_st]


#Now in the third step we?ll use the "y" train and test datasets to label each row regarding the type of activity
#We?ll merge the two "y" datasets in the same order as the  main datasets and then we?ll merge with the merged_datasets 

url_activity_labels <- "./UCI HAR Dataset/activity_labels.txt"
url_label_row_test <- "./UCI HAR Dataset/test/y_test.txt"
url_label_row_train <- "./UCI HAR Dataset/train/y_train.txt"

y_test <- read.table(url_label_row_test)
y_train <- read.table(url_label_row_train)

y_merged <- rbind(y_test, y_train)

labels <- read.table(url_activity_labels)


y_labeled <- merge(y_merged, labels, by.x = "V1", by.y = "V1")[-1]

dataset <- cbind(y_labeled, dt_mean_st)
colnames(dataset)[1] <- "Activity"

#In the final step, we?ll group the variables in activities groups and calculate the mean of each one 

tidy_dataset <- group_by(dataset, Activity)

dataset_means <- tidy_dataset %>% summarise_all(funs(mean))

