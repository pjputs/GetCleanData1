# CodeBook for Coursera assignment in "Getting and Cleaning Data"
# This CodeBook describes variables, data and transformations/work for the assignment
# This CodeBook is in addition to files README.txt and features_info.txt included in the downloaded files, which provide the detailed background to the data coming from UCI, namely Human Activity Recognition using Smartphones
# See link : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Step A : Get the data files
- checks whether the assigned file (zip file) already downloaded
- if not, downloads and unzips its
- zip file lands in the current working directory
- the unzip places the files in a subdirectory

## Step B : Read the data files
- 8 data files are read from the data directory

## Step C : Merging test & training datasets [step 1 in Coursera assignment]
- test and training datasets are merged using cbind
- this happens for X-, y, and subject-data
- other files (features, activity) are common across test & training
- then the three datasets are merged together into a single one using rbind
- the merged dataset is called Z (it is not tidy yet)

## Step D : Extract only mean and standard deviation measurements [step 2 in Coursera assignment]
- we look for measurements for mean or standard deviation only
- assumption is that these have "mean" or "std" in feature name
- so first a search for these strings is done in the feature names
- then a vector findex is constructed to index the right columns
- this is used to subset Z (while maintaining the added columns with y-, subject-data)
- thankfully, the subsetting also eliminated the duplicate column names still in Z
- the resulting dataset ZC is the required extract

## Step E : Add descriptive labels [step 3 in Coursera assignment]
- the descriptive column names from the features.txt file are added to ZC
- column names "activity", "subject" are added for the columns with y-, subject-data

## Step F : Add column for activity names [step 4 in Coursera assignment]
- activity labels data columns are appropriately labelled
- then dataset tidy is created, by joining ZC on column "activity"
- this dataset tidy is the required tidy dataset

## Step G : Create second tidy dataset, containing averages [step 5 in Coursera assignment]
- using a single aggregate statement, the required average (i.e. mean) is taken
- this is grouped per activity, subject
- note that activitylabel is also included (but is dependent on activity)
- the resulting dataset tidy2 is the second required tidy dataset

## Step H : Write this second tidy dataset to file (txt file lands in current working directory)
- this tidy2 dataset is written to tidy2.txt
- this file lands in the current working directory
