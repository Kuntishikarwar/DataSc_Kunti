# set working directory
setwd("~/R/Prac/CleanData/data/")

# intialize the file URL and zipfilename
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
File <- "UCI HAR Dataset.zip"

#check if the zip file is present in the working directory or not
#if the file is not present download and unzip the same
if (!file.exists(File)) {
  download.file(Url,File, mode = "wb")
}
unzip(File)

#the working directory to the dataset directory
if (!file.exists("UCI HAR Dataset"))
{
  setwd("~/R/Prac/CleanData/data/UCI HAR Dataset/")
}

#reading features and activities lable to datasets
feature<-read.csv("features.txt",sep = " ",header = FALSE,col.names = c("id","featurename"))
act<-read.csv("activity_labels.txt",sep = " ",header = FALSE,col.names = c("id","activityname"))

# selecting only feature names where the feature denotes STD/MEAN and standardizing the column names
featuresWanted <- grep("(mean|std)",  feature$featurename)
featuresWanted.names <- feature[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


# reading training sets along with subject and activity variables and combining  them into single dataset
train <- read.csv("train/X_train.txt",sep = "",header = FALSE)[featuresWanted]
trainSub <- read.csv("train/subject_train.txt",sep = "",header = FALSE)
trainAct <- read.csv("train/y_train.txt",sep = "",header = FALSE)
final_train<-cbind(trainSub,trainAct,train)

# reading test setsalong with subject and activity variables and combining  them into single dataset
test <- read.csv("test/X_test.txt",sep = "",header = FALSE)[featuresWanted]
testSub <- read.csv("test/subject_test.txt",sep = "",header = FALSE)
testAct <- read.csv("test/y_test.txt",sep = "",header = FALSE)
final_test<-cbind(testSub,testAct,test)


#combining test and training data set and adding appropriate column names
final_df<-rbind(final_train,final_test)
colnames(final_df) <- c("subject", "activity", as.vector(featuresWanted.names))
final_df=merge(act,final_df,by.y='activity',by.x = 'id')
final_df=final_df[,2:82]                                                         


# creating tidy data set with average per acitivity per
tidy_df<- group_by(final_df,subject,activityname) 
cols<-names(tidy_df)
cols<-cols[3:81]
tidy_df<- summarise_each(tidy_df,mean)  

#writing data into text file
write.table(tidy_df, file="final_tidy_data.txt",col.names = TRUE, sep=" " ,row.names = FALSE,quote=FALSE)




