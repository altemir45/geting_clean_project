
# RUN_ANALYSIS.R
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require("data.table")
require("reshape2")

# Read the files of features, activities labels and extract mean and SD
FEATURES_INFO <- read.csv('features_info.txt', sep= '', header=FALSE) 
FEATURES <- read.table("features.txt")[,2]
LABELS <- read.table("activity_labels.txt") [,2] # create factor LABELS with 6 levels (activity_labels)
extract_features <- grepl("mean|std", FEATURES) # Extract mean and standard deviation for each measurement.

# Load and process X_test & y_test data.
X_test <- read.table('test/X_test.txt')
y_test <- read.table('test/y_test.txt')
subject_test <- read.table('test/subject_test.txt')
names(X_test) = FEATURES
X_test = X_test[,extract_features] # Extract only mean and SD for each measurement.
y_test[,2] = LABELS[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"
test_data <- cbind(subject_test, y_test, X_test) # Bind data

# Load and process X_train & y_train data.
X_train <- read.table('train/X_train.txt')
y_train <- read.table('train/y_train.txt')
subject_train <- read.table('train/subject_train.txt')
names(X_train) = FEATURES
X_train = X_train[,extract_features] # Extract only mean and SD for each measurement.
y_train[,2] = LABELS[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"
train_data <- cbind(subject_train, y_train, X_train) # Bind data

# Merge test and train data
data = rbind(test_data, train_data)
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "tidy_data.txt")

TYDE <- read.table('tidy_data2.txt')
