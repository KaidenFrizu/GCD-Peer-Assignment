datacheck <- function(DataFileName = "Data.zip") {
    if(!file.exists("Data.zip")) {
        fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        message("Downloading file... Please wait")
        download.file(url = fileurl, destfile = DataFileName, quiet = TRUE)
        downloaddate <<- Sys.time() #Checking download time
        message(paste("Date Downloaded:",downloaddate))
        message(paste("Filename:",DataFileName))
        Sys.sleep(2)
        message("File downloaded successfully")
    }
    else {
        if (exists("downloaddate")) message(paste("Date Downloaded:",downloaddate))
        message("File already exists")
    }
}

dataextract <- function(datazip = "Data.zip") {
    unzip(zipfile =  datazip, files = c("UCI HAR Dataset/train/X_train.txt",
                                        "UCI HAR Dataset/train/y_train.txt",
                                        "UCI HAR Dataset/train/subject_train.txt",
                                        "UCI HAR Dataset/test/X_test.txt",
                                        "UCI HAR Dataset/test/y_test.txt",
                                        "UCI HAR Dataset/test/subject_test.txt",
                                        "UCI HAR Dataset/features.txt"))
    message("Files extracted successfully")
}

mean_sd_find <- function() {
    dataframe <- read.table("UCI HAR Dataset/features.txt")
    dataframe2 <- filter(dataframe, grepl("mean()", V2))
    dataframe3 <- filter(dataframe, grepl("std()", V2))
    dataframe4 <- rbind(dataframe2, dataframe3)
    dataframe4 <- dataframe4[order(dataframe4$V1),]
    names(dataframe4) <- c("Code","Description")
    listnum <<- dataframe4$Code
    dataframe4$Code <- paste0("V", dataframe4$Code)
    modfeature <<- dataframe4
}

train_tidy <- function() {
    mean_sd_data <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", header = FALSE)[,listnum]
    activity_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt", header = FALSE)
    names(activity_train) <- "Activity"
    subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    names(subject_train) <- "Subject"
    result <- cbind(subject_train, activity_train, mean_sd_data)
    message("Train data loaded")
    result
}

test_tidy <- function() {
    mean_sd_data <- read.table(file = "./UCI HAR Dataset/test/X_test.txt", header = FALSE)[,listnum]
    activity_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt", header = FALSE)
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
    dataframe <- aggregate(. ~ Subject + Activity, data = dataframe, FUN = mean)
    dataframe$Activity <- as.factor(dataframe$Activity)
    dataframe$Subject <- as.factor(dataframe$Subject)
    dataframe
}