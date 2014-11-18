# read feature names
features <- read.table("./UCI HAR Dataset/features.txt")
features_name <- features[,2]

# read activiy labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("label","activity")

# read train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(X_train) = features_name
X_train <- X_train[,grep("mean|std", features_name)]

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(y_train) <- "label"
y_train <- merge(y_train,activity_labels)
y_train[,1] = NULL

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"

data_train <- cbind(cbind(subject_train, y_train), X_train)

# read test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(X_test) = features_name
X_test <- X_test[,grep("mean|std", features_name)]

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(y_test) <- "label"
y_test <- merge(y_test,activity_labels)
y_test[,1] = NULL

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"

data_test <- cbind(cbind(subject_test, y_test), X_test)

# marge, output file
data <- rbind(data_train, data_test)
write.table(data, file = "./tidy_data.txt")

#
detail <- aggregate(data, by=list(data$activity, data$subject), FUN=mean)
detail[,3]=NULL
detail[,3]=NULL
colnames(detail)[1] <- "activity"
colnames(detail)[2] <- "subject"
write.table(detail, file = "./detail.txt")
