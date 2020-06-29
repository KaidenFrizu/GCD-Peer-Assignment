datacheck <- function(DataFileName = "Data.zip") {
    if(!file.exists("Data.zip")) {
        fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url = fileurl, destfile = DataFileName)
        downloaddate <<- Sys.time() #Checking download time
        message(paste("Date Downloaded:",downloaddate))
        Sys.sleep(1)
        message("File downloaded successfully")
    }
    else {
        if (exists("downloaddate")) message(paste("Date Downloaded:",downloaddate))
        message("File already exists")
    }
}

dataextract <- function(datazip = "Data.zip") {
    if(!file.exists("UCI HAR Dataset")) {
        unzip(datazip)
        Sys.sleep(1)
        message("File extracted successfully")
    }
    else message(paste(datazip, "is already extracted"))
}

train_tidy <- function() {
    mean_sd_data <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE)[,1:6]
    activity_train <- read.table(file = "./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
    names(activity_train) <- "Activity"
    subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    names(subject_train) <- "Subject"
    result <- cbind(subject_train, activity_train, mean_sd_data)
    message("Train data loaded")
    result
}

test_tidy <- function() {
    mean_sd_data <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE)[,1:6]
    activity_test <- read.table(file = "./UCI HAR Dataset/test/Y_test.txt", header = FALSE)
    names(activity_test) <- "Activity"
    subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
    names(subject_test) <- "Subject"
    result <- cbind(subject_test, activity_test, mean_sd_data)
    message("Test data loaded")
    result
}

autobind <- function() {
    data_train <- train_tidy()
    data_test <- test_tidy()
    result <- rbind(data_train,data_test)
    message("Tables combined successfully")
    result
}

mean_sd_summary <- function(dataframe) {
    require(dplyr) #dplyr must be installed to use this function
    tdata <- dataframe %>% arrange(Subject, Activity)
    aggregate(. ~ Subject + Activity, data = tdata, FUN = mean)
}