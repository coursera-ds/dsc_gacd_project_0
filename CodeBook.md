## Source

The source dataset, its description, and descriptions of the variables and values within it can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

## This dataset

The run_analysis.R script produces two datasets from the source data set above.  The first dataset combines the training and test datasets from the source data and includes only the variables related to means or standard deviations.  The first two columns contain the activity being tracked (as a descriptive string) and the subject (as 1-30) for which the data pertains.  Descriptions of the remaining mean and standard deviation variables can be found in the source documentation above.

The following process was used to generate the first dataset:

1. The following data were read into data tables: 
..* features.txt
..* activity_labels.txt
..* test/X_test.txt
..* test/y_test.txt
..* test/subject_test.txt
..* train/X_train.txt
..* train/y_train.txt
..* train/subject_train.txt
2. The features data table was applied to the x_test and x_train data as column names
3. The feature column names containing either of the strings: 'mean()' or 'std()' were identified
4. A train data table was created by combining columns from the y_train, subject_train, and x_train data.  Note that only features from the x_train data for means or standard deviations were included.
5. A test data table was created in the same manner as the train data (with the exception of using the test data)
6. The test data table was appended to the train data table to create the new dataset.
7. The activity column was updated to use the activity names from the activity_labels file.
8. The new data table is written to disk as 'combined.txt'.

The second dataset leverages the first and stores the average values per activity/subject pair.  It was created using the following process:

1. The combined dataset above is "melted" using the activity and subject as identifiers with the mean and standard deviation columns as measurement variables.
2. The melted data is then shaped to generate a data table containing the average values of the mean and standard deviation variables per activity/subject pair.
3. The new dataset is written to disk as 'combined_means.txt'

These steps are automated and commented in the run_analysis.R file.
