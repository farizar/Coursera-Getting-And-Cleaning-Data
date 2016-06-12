Purpose of this codebook
------------------------

It shall describe the variables, the data, and any transformations or work that were performed to clean up the data.

Origin of data
--------------

\[1\] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description of variables and raw data used
------------------------------------------

1.  Data measurements were contained in test and training files labeled as "X\_test.txt" and "X\_train.txt".
2.  The labels of each measurement type are contained in the "features.txt" file.
3.  Description of activities related to the data measurements are contained in the "Y\_test.txt" and "Y\_train.txt" files.
4.  The labels for the activities are contained in the "activity\_labels.txt" file.
5.  Description of subject IDs related to the data measurements are contained in the "subject\_test.txt" and "subject\_train.txt" files.

R-script
--------

The [R-script](https://github.com/farizar/GettingAndCleaningDataCourseProject/blob/master/run_analysis.R) created retrieves the data from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> and performs a series of data cleaning steps to produce the final [output file](https://github.com/farizar/GettingAndCleaningDataCourseProject/blob/master/tidyDataset.txt).

Data cleaning steps
-------------------

1.  First the raw data of interest are downloaded and stored into variables with appropriate labeling.
2.  The data measurements in the X table are merged for the test and training data.
3.  Only the mean and standard deviation measurements in the merged X table are retained.
4.  The labels for the subject ID and the activity type are added to the X table to complete the full dataset.
5.  An independent tidy dataset is created by averaging each measurement variables for each activity and each subject.
6.  Finally the tidy dataset is written out to a text file.
