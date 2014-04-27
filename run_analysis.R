#
# Create the first tidy dataset:
#

# Read the data into data tables
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)
labels   <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors=FALSE, col.names=c("activity_id","activity_name"))
xtest    <- read.table("test/X_test.txt", header=FALSE, stringsAsFactors=FALSE)
ytest    <- read.table("test/y_test.txt", header=FALSE, stringsAsFactors=FALSE, col.names=c("activity"))
stest    <- read.table("test/subject_test.txt", header=FALSE, stringsAsFactors=FALSE, col.names=c("subject"))
xtrain   <- read.table("train/X_train.txt", header=FALSE, stringsAsFactors=FALSE)
ytrain   <- read.table("train/y_train.txt", header=FALSE, stringsAsFactors=FALSE, col.names=c("activity"))
strain   <- read.table("train/subject_train.txt", header=FALSE, stringsAsFactors=FALSE, col.names=c("subject"))

# Add column names to the features
names(xtest)  <- features[,2]
names(xtrain) <- features[,2]

# Get the mean and standard deviation column indexes
mean_std_columns <- grep("mean()|std()", colnames(xtest))

# Create the train and test data tables which contain the activities, subjects, and features
train <- cbind(ytrain, strain, xtrain[, mean_std_columns])
test  <- cbind(ytest, stest, xtest[, mean_std_columns])

# Create the combined train and test data table
combined <- rbind(train, test)

# Update the activity column to use the descriptive activity names
combined$activity <- factor(combined$activity, labels=labels$activity_name, ordered=TRUE)

# Write the table to disk
write.table(combined, file="combined.txt")

#
# Create 2nd tidy dataset:
#

# Melt the data using activity and subject as identifiers with the mean and standard deviation columns as measurements
combined_melt <- melt(combined, id=c("activity", "subject"), measure.vars=grep("mean()|std()", colnames(xtest), value=TRUE))

# Cast the data such that means are returned per activity and subject for each measurement column 
combined_means <- dcast(combined_melt, activity + subject ~ variable,mean)

# Write the table to disk
write.table(combined_means, file="combined_means.txt")