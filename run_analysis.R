require(dplyr) #Requires dplyr

datacheck <- function(DataFileName = "Data.zip") {
    fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    message("Downloading file... Please wait")
    download.file(url = fileurl, destfile = DataFileName)
    downloaddate <<- Sys.time() #Checking download time
    message(paste("Date Downloaded:",downloaddate))
    message(paste("Filename:",DataFileName))
    Sys.sleep(2)
    message("File downloaded successfully")
}

dataextract <- function(datazip = "Data.zip") {
    unzip(zipfile =  datazip, files = c("UCI HAR Dataset/train/X_train.txt",
                                        "UCI HAR Dataset/train/y_train.txt",
                                        "UCI HAR Dataset/train/subject_train.txt",
                                        "UCI HAR Dataset/test/X_test.txt",
                                        "UCI HAR Dataset/test/y_test.txt",
                                        "UCI HAR Dataset/test/subject_test.txt",
                                        "UCI HAR Dataset/features.txt",
                                        "UCI HAR Dataset/activity_labels.txt"))
    message("Files extracted successfully")
}

mean_sd_find <- function() {
    dataframe <- read.table("UCI HAR Dataset/features.txt")
    dataframe2 <- filter(dataframe, grepl("-mean()", V2))
    dataframe3 <- filter(dataframe, grepl("-std()", V2))
    dataframe4 <- rbind(dataframe2, dataframe3)
    dataframe4 <- dataframe4[order(dataframe4$V1),]
    names(dataframe4) <- c("Code","Description")
    listnum <<- dataframe4$Code
    dataframe4$Code <- paste0("V", dataframe4$Code)
    modfeature <<- dataframe4
    message("The following variables were created: listnum, modfeature")
}

column_gsub <- function() {
    
    repfunc <- function(oldname, newname, case = FALSE) {
        gsub(oldname, newname, modfeature$Description, ignore.case = case)
    }
    #List of keywords to be subsituted
    modfeature$Description <<- repfunc("^t","time.")
    modfeature$Description <<- repfunc("Body","body.")
    modfeature$Description <<- repfunc("Acc","accelerometer.")
    modfeature$Description <<- repfunc("-mean()","mean.")
    modfeature$Description <<- repfunc("-std()","SD.")
    modfeature$Description <<- repfunc("Gravity","gravity.")
    modfeature$Description <<- repfunc("Jerk","jerk.")
    modfeature$Description <<- repfunc("Gyro","gyroscope.")
    modfeature$Description <<- repfunc("Mag","magnitude.")
    modfeature$Description <<- repfunc("^f","fast.fourier.transform.")
    modfeature$Description <<- repfunc("-meanFreq()","mean.frequency.")
    modfeature$Description <<- repfunc("body.body.","body.")
    modfeature$Description <<- repfunc(")-X$","x-axis)")
    modfeature$Description <<- repfunc(")-Y$","y-axis)")
    modfeature$Description <<- repfunc(")-Z$","z-axis)")
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

activity_sub <- function(dataframe) {
    lookup <- read.table("UCI HAR Dataset/activity_labels.txt")
    names(lookup) <- c("Activity", "Description")
    df <- as.data.frame(dataframe$Activity)
    names(df) <- ("Activity")
    df2 <- merge(df,lookup)
    dataframe$Activity <- df2$Description
    dataframe
}

mean_sd_summary <- function(dataframe) {
    dataframe <- aggregate(. ~ Subject + Activity, data = dataframe, FUN = mean)
    dataframe$Activity <- as.factor(dataframe$Activity)
    dataframe$Subject <- as.factor(dataframe$Subject)
    message("Data set has been created")
    dataframe
}

simulation_analysis <- function() {
    Sys.sleep(2)
    message("Processing: datacheck()")
    datacheck()
    Sys.sleep(2)
    message("Processing: dataextract()")
    dataextract()
    Sys.sleep(2)
    message("Processing: mean_sd_find()")
    mean_sd_find()
    Sys.sleep(2)
    message("Processing: column_gsub()")
    column_gsub()
    Sys.sleep(2)
    message("Processing: autobind()")
    Dataset <<- autobind()
    Sys.sleep(2)
    message("Processing: mean_sd_summary()")
    Dataset_summary <<- mean_sd_summary(Dataset)
    Sys.sleep(2)
    message("Processing: activity_sub()")
    Dataset <<- activity_sub(Dataset)
    Dataset_summary <<- activity_sub(Dataset_summary)
    Sys.sleep(2)
    message("Simulation finished")
}