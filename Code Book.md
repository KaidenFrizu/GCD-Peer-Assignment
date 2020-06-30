# Code Book

Here are the following codes that is used for reference in the tidy data. This is also where you can find the details of each variables and functions. Additional details are also found in the pdf version of this code book

***

### Measurement Variable Code 

The table corresponds to the description of column names found in the tidy data set. You can find the table in the pdf version, `Code-Book.pdf`, of this code book found in this repository.

*Sadly, the table doesn't appear correctly on .md files*

***

### Variables

The following variables are pre-processed and automatically creates after executing certain functions.

* **modfeature** - Created after performing the function `mean_sd_find()`. Creates a table that contains the descriptions of column names in the tidy data set. Same as the table given above.
* **downloaddate** - A variable created by `Sys.time` after doing the function `datacheck()`. Used to track the download date for reference.
* **listnum** - Created after performing the function `mean_sd_find()`. A vector of numbers that corresponds to the required columns where it contains mean() or std() of any measurement.

***

### Functions

The following functions were created for the analysis. Sorted by name.

* `activity_sub()` - A function that is used to change the numerical value to descriptive by the lookup table from `activity_labels.txt`
* `autobind()` - A function that automatically binds train and test data from the functions `test_tidy()` and `train_tidy()`. Created for the purpose of convenience
* `column_gsub()` - A function that substitutes keywords found in **modfeature** to give a descriptive explanation of the codes found in the tidy data set
* `datacheck()` - Downloads the given files in the study and records the date and time of download. A text input passed to this function is the file name (including the extension)
* `dataextract()` - Extracts the necessary files to be used in this project. The following files are: `features.txt`, `activity_labels.txt`, `X & Y Train`, `X & Y Test`, `subject_train`, and `subject_test`
* `mean_sd_find()` - A function that reads `features.txt` file and filters the required columns to be used. In addition, the variables **modfeature** and **listnum** would be created. Requires `dplyr`
* `mean_sd_summary()` - A function that groups the tidy data by Activity and Subject and calculates the mean of each group. A data frame must be passed to this function in order to use it.
* `simulation_analysis()` - Performs the analysis for you by automatically assigning variables and executing functions in order.
* `test_tidy()` - Creates a tidy table that uses the data in `subject_test.txt`, `X_test.txt`, `y_test.txt`, and **listnum**
* `train_tidy()` - Same function as `test_tidy()` but to be used in train data