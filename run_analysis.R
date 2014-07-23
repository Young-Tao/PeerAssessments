#########################################################################################
#
#
#
#
#########################################################################################
library("plyr")
#
tableDirectories <- c("features.txt", "activity_labels.txt", "test/subject_test.txt", 
                      "test/X_test.txt", "test/y_test.txt", "train/subject_train.txt", 
                      "train/X_train.txt", "train/y_train.txt")
tableNames <- c("features", "activity_labels", "subject_test", 
                "X_test", "y_test", "subject_train", 
                "X_train", "y_train")
tables <- lapply(tableDirectories, read.table)
names(tables) <- tableNames
#
attach(tables)
combinedTable <- rbind(X_test, X_train)
names(combinedTable) <- as.character(features[[2]])
#
extractedTable <- cbind("subject" = as.factor(rbind(subject_test, subject_train)[[1]]), 
                        "activity" = as.factor(rbind(y_test, y_train)[[1]]), 
                        combinedTable[,grepl("mean\\(|std\\(", names(combinedTable))])
levels(extractedTable$activity) <- c("walking", "walkingUpstairs", "walkingDownstairs",
                                     "sitting", "standing", "laying")
detach(tables)
#
newNames <- character(length(extractedTable))
keyWords <- c("^t", "^f", "-mean\\(", "-std\\(", "Mag", "Jerk", "BodyAcc", 
              "GravityAcc", "BodyGyro", "-X", "-Y", "-Z")
replacedWords <- c("timeDomain", "frequencyDomain", "MeanValueOf", 
                   "StandardDeviationOf", "TheMagnitudeOf", "JerkSignalOf", 
                   "BodyLinearAcceleration", "GravitionalAcceleration", 
                   "BodyAngularVelocity", "AlongXAxis", "AlongYAxis", "AlongZAxis")
names(replacedWords) <- keyWords
for(key in keyWords){
  newNames[grepl(key, names(extractedTable))] <- 
    paste(newNames[grepl(key, names(extractedTable))], replacedWords[key], sep = "")
}
names(extractedTable)[3:length(extractedTable)] <- newNames[3:length(extractedTable)]
#
tidyTable <- ddply(extractedTable, .(subject, activity), colwise(mean))
write.table(tidyTable, file = "tidyTable.txt", sep = "\t", row.names = FALSE)