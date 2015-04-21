# 1. Merge the training and the test sets to create one data set.

# Read training data
features     = read.table('./UCI HAR Dataset/features.txt', header=FALSE);
activity_labels = read.table('./UCI HAR Dataset/activity_labels.txt', header=FALSE);
subject_train = read.table('./UCI HAR Dataset/train/subject_train.txt', header=FALSE);
x_train       = read.table('./UCI HAR Dataset/train/x_train.txt', header=FALSE);
y_train       = read.table('./UCI HAR Dataset/train/y_train.txt', header=FALSE);

# Assigin column names to training tables
colnames(activity_labels)  = c('activityId','activityType');
colnames(subject_train)  = "subjectId";
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activityId";

# Create the final training set
trainingData = cbind(y_train,subject_train,x_train);

# Read test data
subject_test = read.table('./UCI HAR Dataset/test/subject_test.txt', header=FALSE);
x_test       = read.table('./UCI HAR Dataset/test/x_test.txt', header=FALSE);
y_test       = read.table('./UCI HAR Dataset/test/y_test.txt', header=FALSE);

# Assign column names to test tables
colnames(subject_test) = "subjectId";
colnames(x_test)       = features[,2]; 
colnames(y_test)       = "activityId";

# Create the final test set
testData = cbind(y_test,subject_test,x_test);

# Combine training and test data to create a final data set
finalData = rbind(trainingData,testData);

# Create a vector for the column names from the finalData, which will be used
# to select the desired mean() & stddev() columns
colNames  = colnames(finalData); 



# 2. Extract only the mean and standard deviation measurements. 

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
colsWeWant = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("mean()",colNames) & !grepl("-meanFreq..",colNames) | grepl("std()",colNames));

# Subset finalData table based on the logicalVector to keep only desired columns
finalData = finalData[colsWeWant==TRUE];



# 3. Use descriptive activity names to name the activities in the data set

# Merge the finalData set with the acitivityType table to include descriptive activity names
finalData = merge(finalData,activity_labels,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  = colnames(finalData); 



# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = colNames;



# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, finalDataNoActivityType without the activityType column
finalDataNoActivityType = finalData[,names(finalData) != 'activityType'];

# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidyData = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId=finalDataNoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData = merge(tidyData,activity_labels,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(tidyData, './tidy_data.txt',row.names=TRUE,sep='\t');