---
title: "第四周项目作业"
author: "swsoyee"
date: "2017-9-6"
output: html_document
---


# Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

### Review criteria

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

### Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

## 1. 环境配置以及数据下载

首先设置工作路径、加载必要的包、下载数据等。


```r
# 用到的包加载
library(data.table)
library(stringr)
library(dplyr)

# 检查并且建立数据下载的文件夹
if (!file.exists("downloadData")) {
  dir.create("downloadData")
}

# 检查之前是否有下载过相应文件并且已经解压完成
fileInDir <- list.files(path = "./downloadData", recursive = T)
if (length(fileInDir) != 29) {
  # 下载地址
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  # 下载到本地的位置
  destfile <- "./downloadData/data.zip"
  # 数据下载
  download.file(fileUrl, destfile = destfile, method = "auto")
  # 压缩包解压
  unzip(destfile, exdir = "./downloadData")
  # 输出下载并且解压成功信息
  fileSuccess <- "已经为你完成了数据下载和解压..."
  fileSuccess
} else {
  fileExist <- "你已经下载并且解压过该文件了，跳过下载解压步骤..."
  fileExist
}
```

```
## [1] "已经为你完成了数据下载和解压..."
```

```r
# 记录日期
dataCreatTime <- file.info("./downloadData/data.zip")$ctime
```
数据下载于2017-09-08 15:55:10，在工作路径D:/coursera/cleanData的`downloadData`文件夹下。

下载完成后检查一下所下载并且解压的文件

```r
fileInDir <- list.files(path = "./downloadData", recursive = T)
# 如果下载的文件数目不符合，则不输出结果
if (length(fileInDir) != 29) {
    stop("Maybe there is some problems with your files, please check your files.")
} else {
    fileInDir
}
```

```
##  [1] "data.zip"                                                    
##  [2] "UCI HAR Dataset/activity_labels.txt"                         
##  [3] "UCI HAR Dataset/features.txt"                                
##  [4] "UCI HAR Dataset/features_info.txt"                           
##  [5] "UCI HAR Dataset/README.txt"                                  
##  [6] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"   
##  [7] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"   
##  [8] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"   
##  [9] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"  
## [10] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"  
## [11] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"  
## [12] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"  
## [13] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"  
## [14] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"  
## [15] "UCI HAR Dataset/test/subject_test.txt"                       
## [16] "UCI HAR Dataset/test/X_test.txt"                             
## [17] "UCI HAR Dataset/test/y_test.txt"                             
## [18] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
## [19] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" 
## [20] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" 
## [21] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
## [22] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
## [23] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
## [24] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
## [25] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
## [26] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"
## [27] "UCI HAR Dataset/train/subject_train.txt"                     
## [28] "UCI HAR Dataset/train/X_train.txt"                           
## [29] "UCI HAR Dataset/train/y_train.txt"
```
预期文件数目包括所下载的data.zip，一共有29个文件。实际有29个文件。

## 2. 数据拼接

参考了[Benjamin Chan](https://github.com/swsoyee/GettingAndCleaningData/tree/master/Project)的输出结果，独立完成处理代码。

***

根据所下载的文件里的`README.md`说明，我们可以了解到以下信息：

1. 数据集里包含了`train`和`test`两个文件夹，其中的subject_前缀的文件为测试者编号（一共30名测试者，被分为了2组，所以两个文件里的数字合起来为1~30）；

2. 上述的两个文件夹中的`y_前缀`的文件为每一条记录所对应的动作，动作类型一共有6种；

3. 上述的两个文件夹中的`X_前缀`的文件为每一条记录所对应的某一时刻的所有测试坐标，纵列为时间

4. `features.txt`里一共有561行，对应X_前缀的文件的每一列。

***

根据要求，我们可以按以下思路进行分析：

1. 要求中只需要抽取mean和standard deviation这两项，也就是说可以从`features.txt`中获取所有mean和standard deviation所在的行数，对应抽取X_前缀文件里的具体列构成`xMeanSD`；

2. 把`subjects_test.txt` `xMeanSD` `y_test.txt`进行列合并，train部分的数据集进行相同处理，
然后再把train和test进行行合并；

3. 利用`y_前缀`文件中的数字，对应`activity_labels.txt`进行匹配追加新的一列（数字列可以先保留）；

Step1. 设置处理上述要求的函数

```r
step1 <- function(data){
  # 选择处理train集还是test集
  if (tolower(data) == "train") {
    input = c("/X_train.txt", "/y_train.txt", "/subject_train.txt")
  } else if (tolower(data) == "test") {
    input = c("/X_test.txt", "/y_test.txt", "/subject_test.txt")
  } else {
    stop("Parameter error! Only 'train' or 'test' are permitted.")
  }
  
  # 读取X坐标文件
  xTrainUrl <- grep(pattern = input[1], x = fileInDir, value = T)
  xTrain <- fread(input = paste0("./downloadData/", xTrainUrl))
  # 读取features文件
  featuresUrl <- grep(pattern = "features.txt", x = fileInDir, value = T)
  features <- fread(input = paste0("./downloadData/", featuresUrl))
  
  # 挑选出要求的mean和sd关键字的列位置
  columnOfMeanAndSD <- features[grepl(pattern = "mean|std", x = tolower(features$V2)),]
  columnOfMeanAndSD$V1 <- paste0("V", columnOfMeanAndSD$V1)
  # 根据列位置抽取指定列
  xTrainMeanAndSD <- subset(xTrain, select = columnOfMeanAndSD$V1)
  names(xTrainMeanAndSD) <- columnOfMeanAndSD$V2
  
  # 读取y坐标文件
  yTrainUrl <- grep(pattern = input[2], x = fileInDir, value = T)
  yTrain <- fread(input = paste0("./downloadData/", yTrainUrl))
  # 读取活动数字和描述匹配文件
  activityLabelsUrl <- grep(pattern = "activity_labels.txt", x = fileInDir, value = T)
  activityLabels <- fread(input = paste0("./downloadData/", activityLabelsUrl))
  # 追加描述到yTrain里面
  yTrainAppend <- merge(x = yTrain, y = activityLabels, by = "V1", sort = FALSE)
  
  # 读取受试者文件
  subjectTrainUrl <- grep(pattern = input[3], x = fileInDir, value = T)
  subjectTrain <- fread(input = paste0("./downloadData/", subjectTrainUrl))
  
  # 列相并拼合所有文件
  stepOneMerge <- cbind(subject = subjectTrain$V1, activity = yTrainAppend$V2, xTrainMeanAndSD) 
  data.table(stepOneMerge)
}
```
Step2. 调用`step1`函数，对两个数据集进行处理, 合并两个数据集，并且melt使其一列只有一个值。

```r
dtTrain <- step1("train")
dtTest <- step1("test")

dt <- rbind(dtTrain, dtTest)

step2 <-  melt(data = dt, 
            id.vars = c("subject", "activity"), 
       measure.vars = names(dt)[3:ncol(dt)]
       )
head(step2)
```

```
##    subject activity          variable     value
## 1:       1 STANDING tBodyAcc-mean()-X 0.2885845
## 2:       1 STANDING tBodyAcc-mean()-X 0.2784188
## 3:       1 STANDING tBodyAcc-mean()-X 0.2796531
## 4:       1 STANDING tBodyAcc-mean()-X 0.2791739
## 5:       1 STANDING tBodyAcc-mean()-X 0.2766288
## 6:       1 STANDING tBodyAcc-mean()-X 0.2771988
```
Step3. 把重整后的varible列中变量名再次分解。
首先尝试把最后一个-后的XYZ坐标给分解，如果没有，则为NA

```r
# 取variable属性的最后一位，增加一列轴属性
step2[, axis := substr(x = variable, 
                   start = nchar(as.character(variable)), 
                    stop = nchar(as.character(variable)))]
# 检查一下axis里面的所有值
unique(step2$axis)
```

```
## [1] "X" "Y" "Z" ")"
```

```r
# 如果variable属性的最后一位不为XYZ， 则把其变为NA值
step2$axis <- gsub(pattern = "[^XYZ]", replacement = NA, x = step2$axis)
# 取-X-中间的字段作为方法属性，大概为mean()或者是std()
step2$method <- str_extract(string = step2$variable, pattern = "-(.+?)\\(\\)")
# 检查一下method里面的所有值
unique(step2$method)
```

```
## [1] "-mean()"     "-std()"      "-meanFreq()" NA
```

```r
# 进行符号整理
step2$method <- str_replace_all(string = step2$method, 
                               pattern = "[-\\(\\)]",
                           replacement = "")
# 取-前的部分作为feature属性
step2$feature <- str_extract(string = step2$variable, pattern = "(.+?)-")
# 检查一下feature里面的所有值
unique(step2$feature)
```

```
##  [1] "tBodyAcc-"             "tGravityAcc-"         
##  [3] "tBodyAccJerk-"         "tBodyGyro-"           
##  [5] "tBodyGyroJerk-"        "tBodyAccMag-"         
##  [7] "tGravityAccMag-"       "tBodyAccJerkMag-"     
##  [9] "tBodyGyroMag-"         "tBodyGyroJerkMag-"    
## [11] "fBodyAcc-"             "fBodyAccJerk-"        
## [13] "fBodyGyro-"            "fBodyAccMag-"         
## [15] "fBodyBodyAccJerkMag-"  "fBodyBodyGyroMag-"    
## [17] "fBodyBodyGyroJerkMag-" NA
```

```r
# 进行符号整理
step2$feature <- str_replace_all(string = step2$feature, 
                                pattern = "[-]",
                            replacement = "")
# 去掉variable列的数据
step2Output <- step2[, variable:=NULL]
head(step2Output)
```

```
##    subject activity     value axis method  feature
## 1:       1 STANDING 0.2885845    X   mean tBodyAcc
## 2:       1 STANDING 0.2784188    X   mean tBodyAcc
## 3:       1 STANDING 0.2796531    X   mean tBodyAcc
## 4:       1 STANDING 0.2791739    X   mean tBodyAcc
## 5:       1 STANDING 0.2766288    X   mean tBodyAcc
## 6:       1 STANDING 0.2771988    X   mean tBodyAcc
```
如果愿意，还可以把feature进行细分，这里就不进行细分了。

Step3. 在上述整理过的数据集的基础上，构建新数据集，按activity和subject进行分类获取mean。

```r
avgTidy <- step2Output %>% 
  group_by(subject, activity, feature, axis, method) %>% 
  summarise(mean = mean(value), count = n())
# 把部分字段转成factor以便于统计
avgTidy$activity <- as.factor(avgTidy$activity)
avgTidy$feature <- as.factor(avgTidy$feature)
avgTidy$axis <- as.factor(avgTidy$axis)
avgTidy$method <- as.factor(avgTidy$method)

# 备选：在起初抽取的时候把angle()部分的数据也包含了，通过features == NA去除
avgTidy <- avgTidy[!is.na(avgTidy$feature), ]

head(avgTidy)
```

```
## Source: local data frame [6 x 7]
## Groups: subject, activity, feature, axis [2]
## 
## # A tibble: 6 x 7
##   subject activity  feature   axis   method        mean count
##     <int>   <fctr>   <fctr> <fctr>   <fctr>       <dbl> <int>
## 1       1   LAYING fBodyAcc      X     mean -0.93909905    50
## 2       1   LAYING fBodyAcc      X meanFreq -0.15879267    50
## 3       1   LAYING fBodyAcc      X      std -0.92443743    50
## 4       1   LAYING fBodyAcc      Y     mean -0.86706521    50
## 5       1   LAYING fBodyAcc      Y meanFreq  0.09753484    50
## 6       1   LAYING fBodyAcc      Y      std -0.83362556    50
```

```r
summary(avgTidy)
```

```
##     subject                   activity            feature       axis     
##  Min.   : 1.0   LAYING            :2370   fBodyAcc    :1620   X   :3420  
##  1st Qu.: 8.0   SITTING           :2370   fBodyAccJerk:1620   Y   :3420  
##  Median :15.5   STANDING          :2370   fBodyGyro   :1620   Z   :3420  
##  Mean   :15.5   WALKING           :2370   tBodyAcc    :1080   NA's:3960  
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:2370   tBodyAccJerk:1080              
##  Max.   :30.0   WALKING_UPSTAIRS  :2370   tBodyGyro   :1080              
##                                           (Other)     :6120              
##       method          mean              count      
##  mean    :5940   Min.   :-0.99767   Min.   :36.00  
##  meanFreq:2340   1st Qu.:-0.95242   1st Qu.:49.00  
##  std     :5940   Median :-0.34232   Median :54.50  
##                  Mean   :-0.41241   Mean   :57.22  
##                  3rd Qu.:-0.03654   3rd Qu.:63.25  
##                  Max.   : 0.97451   Max.   :95.00  
## 
```

```r
#导出文件
write.table(avgTidy, file = "avgTidy.txt", quote = FALSE, sep = "\t", row.names = FALSE)
```

