# Introduction
This repository serves as a part of the *Getting and Cleaning Data Course Project* for peer assesment. Three files are included: 
- README.md
- run_analysis.R
- CodeBook.md
In this README.md, the course project background, data cleaning process and final "tidy data" description are introduced respectively. If you have any questions please contact young.tao@outlook.com.

# Course Project Background
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The data to be processed is from "Human Activity Recognition Using Smartphones Data Set".
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity are captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
For more information please refer to **Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012**. The raw data are available at **http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones**.

# Data Cleaning Process
## Sofeware Environment
The data are manipulated using R X64 3.1.0 on Windows 8.1 X64.
## run_analysis.R
All codes are in a single script named run_analysis.R. The final tidy data would be generated if you run this script which locates in the same directory with the raw data. You may find details of codes in the script. Here only the structure will be introduced.
### Import Necessary Package
The only one beyond defalt packages is "plyr". You need to install it in advance.
### Import Necessary Dataset
Not all files are necessary. I initial a character vector containing all the directories of files to be read and then use read.table function to import them. In this manner I could use lapply to execute read.table.
### Combine Test and Train Dataset
The codes are self-explained.
### Extract Target Data
According to the instruction of the project, all mean and standard deviation are to be extracted. I use "mean(" and "std(" as keywords and grepl function to search such columns whose name has the keyword.
### Change to Descriptive Names
The name of columns has enough information but not as descriptive as required. It is possible that we interpret them all by human, but more convenient to use computer do this tedious job. We can map keywords and replacements as follows:
"^t"--"timeDomain"
"^f"--"frequencyDomain"
"-mean\\("--"MeanValueOf"
"-std\\("--"StandardDeviationOf"
"Mag"--"TheMagnitudeOf"
"Jerk"--"JerkSignalOf"
"BodyAcc"--"BodyLinearAcceleration"
"GravityAcc"--"GravitionalAcceleration"
"BodyGyro"--"BodyAngularVelocity"
"-X"--"AlongXAxis"
"-Y"--"AlongYAxis"
"-Z"--"AlongZAxis"
I use a for loop to replace all keywords with descriptive words.
### Generate Tidy Dataset
The entire data is ready. According to instructions, we should split the entire data with "subject" and "activity" then apply mean function to get the avarage of each. It is quite straight-forward to use ddply function in "plyr" package. In order to make it tidier, the output content is seperated with "tab" and without row names.

# Tidy Data Description
The tidy dataset is a txt file with 181 rows(including head) and 68 columns(including "subject" and "activity"). Each entry is the avarage value of variable(indicated by its column name) of a specific activity of a subject.
More information could be found in Codebook.md.

