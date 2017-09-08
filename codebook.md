---
title: "Codebook"
author: "swsoyee"
date: "2017-9-8"
output: html_document
---


# Code book

## Dataset structure

```
##        subject         activity        feature axis   method        mean
##     1:       1           LAYING       fBodyAcc    X     mean -0.93909905
##     2:       1           LAYING       fBodyAcc    X meanFreq -0.15879267
##     3:       1           LAYING       fBodyAcc    X      std -0.92443743
##     4:       1           LAYING       fBodyAcc    Y     mean -0.86706521
##     5:       1           LAYING       fBodyAcc    Y meanFreq  0.09753484
##    ---                                                                  
## 14216:      30 WALKING_UPSTAIRS    tGravityAcc    Y      std -0.91493394
## 14217:      30 WALKING_UPSTAIRS    tGravityAcc    Z     mean -0.02214011
## 14218:      30 WALKING_UPSTAIRS    tGravityAcc    Z      std -0.86240279
## 14219:      30 WALKING_UPSTAIRS tGravityAccMag   NA     mean -0.13762786
## 14220:      30 WALKING_UPSTAIRS tGravityAccMag   NA      std -0.32741082
##        count
##     1:    50
##     2:    50
##     3:    50
##     4:    50
##     5:    50
##    ---      
## 14216:    65
## 14217:    65
## 14218:    65
## 14219:    65
## 14220:    65
```
## Variable: subject
a group of 30 volunteers within an age bracket of 19-48 years.

```r
unique(tidy$subject)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
## [24] 24 25 26 27 28 29 30
```
## Variable: activity
Six activities.

```r
unique(tidy$activity)
```

```
## [1] "LAYING"             "SITTING"            "STANDING"          
## [4] "WALKING"            "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"
```
## Variable: feature and axis

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 


```r
unique(tidy$feature)
```

```
##  [1] "fBodyAcc"             "fBodyAccJerk"         "fBodyAccMag"         
##  [4] "fBodyBodyAccJerkMag"  "fBodyBodyGyroJerkMag" "fBodyBodyGyroMag"    
##  [7] "fBodyGyro"            "tBodyAcc"             "tBodyAccJerk"        
## [10] "tBodyAccJerkMag"      "tBodyAccMag"          "tBodyGyro"           
## [13] "tBodyGyroJerk"        "tBodyGyroJerkMag"     "tBodyGyroMag"        
## [16] "tGravityAcc"          "tGravityAccMag"
```

```r
unique(tidy$axis)
```

```
## [1] "X" "Y" "Z" NA
```
## Variable: method
Mean or standard deviation.

```r
unique(tidy$method)
```

```
## [1] "mean"     "meanFreq" "std"
```

## Variable: mean and count
Average and count of each variable for each activity and each subject.
