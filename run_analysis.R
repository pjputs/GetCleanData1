## Coursera Data Scientist : Getting and Cleaning Data
## Programming Assignment

library(plyr)
## Step A : Get the data files
## Download and unzip the data (zip file lands in current working directory)
if(!file.exists("UCI HAR data.zip")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
                  %20Dataset.zip",destfile="UCI HAR data.zip")
    unzip(zipfile="UCI HAR data.zip")
}

## Step B : Read the data files
Xtest<-read.table("UCI HAR Dataset/test/X_test.txt")
Ytest<-read.table("UCI HAR Dataset/test/y_test.txt")
Xtrain<-read.table("UCI HAR Dataset/train/X_train.txt")
Ytrain<-read.table("UCI HAR Dataset/train/y_train.txt")
subjtest<-read.table("UCI HAR Dataset/test/subject_test.txt")
subjtrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
feature<-read.table("UCI HAR Dataset/features.txt")
actlabel<-read.table("UCI HAR Dataset/activity_labels.txt")

## Step C : Merging test & training datasets [step 1 in Coursera assignment]
X<-rbind(Xtest,Xtrain)
Y<-rbind(Ytest,Ytrain)
subj<-rbind(subjtest,subjtrain)
Z<-cbind(X,Y,subj)
## Z is our single, merged dataset (but it is not tidy yet)
## Originally, test and train were separated by subject

## Step D : Extract only mean and standard deviation measurements [step 2 in Coursera assignment]
## Search for "mean" or "std" in the column names (but be sure to keep columns from Y, subj in)
dimf<-dim(feature)[1]
fbin<-grepl("mean|std",feature[,2])
findex<-(1:dimf)[fbin]
ZC<-Z[,c(findex, dimf+1:2)]
## ZC is our extracted dataset with means and standard deviation measurements only
## As length(unique(feature[,2]))<length(feature[,2], there are duplicate column names
## As length(unique(feature[findex,2])=length(feature[findex,2]), subsetting by findex has already 
eliminated the duplicate column names

## Step E : Add descriptive labels [step 3 in Coursera assignment]
colnames(ZC)<-c(as.vector(feature[findex,2]),"activity","subject")

## Step F : Add column for activity names [step 4 in Coursera assignment]
colnames(actlabel)<-c("activity","activitylabel")
tidy<-join(ZC,actlabel,by="activity")
## tidy is our tidy dataset

## Step G : Create second tidy dataset, containing averages [step 5 in Coursera assignment]
tidy2<-aggregate(. ~ activity + activitylabel + subject,data=tidy,FUN="mean")

## Step H : Write this second tidy dataset to file (txt file lands in current working directory)
write.table(tidy2,"tidy2.txt",row.names=FALSE)