# Step 1: Merges the training and the test sets to create one data set.
        #load X_Train, X_Test, y_test, y_train, features, subject_train, 
        #and subject_test and change the subjects to class factor
        test<- read.table ("./test/X_test.txt", header=FALSE, sep="")
        train <- read.table ("./train/X_train.txt", header=FALSE, sep="")
        testlabels<- read.table ("./test/y_test.txt", header=FALSE, sep="")
        trainlabels<- read.table ("./train/y_train.txt", header=FALSE, sep="")
        columns<- read.table ("./features.txt", header=FALSE, sep="")
        sjtest<- read.table ("./test/subject_test.txt", header=FALSE, sep="")
        sjtrain<- read.table ("./train/subject_train.txt", header=FALSE, sep="")
                sjtest$V1<- as.factor(as.character(sjtest$V1))
                sjtrain$V1<- as.factor(as.character(sjtrain$V1))
        #Merge the subjects with the activities
        p1<- cbind(sjtest, testlabels)
        p2 <- cbind(sjtrain, trainlabels)
        # Merge each table with its subject/activity
        q1<- cbind(p1, test)
        q2<- cbind (p2, train)
        #Merge both tables
        r<- rbind(q1,q2)
        
# Step 4: Appropriately labels the data set with descriptive variable names.
#This step is out of order because it is easy to add te columns' names with
#already appropriate labels. For further explanation on what is appropriate to
#me, please reffer to the CodeBook.md
        #add the names of the first two columns
        names<- as.character(columns$V2)
        names <-c("SjId", "Activity", names)
        #Replace () and create better labels
        names<-make.names(names, unique=TRUE)
        names<-sub("...","_",names, fixed=TRUE)
        names<-sub(".","_",names, fixed=TRUE)
        #Add columns' names 
        colnames (r) <- names
        
# Step 2: Extracts only the measurements on the mean and standard deviation 
#for each measurement. (For explanations on which variables I choose and why 
#please refer to the CodeBook.md)
        library(data.table)
        r <- data.table (r)
        dat<-r[ , c(1:2, 3:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519,531:532, 544:545), with=FALSE]

# Step 3: Uses descriptive activity names to name the activities in the data set
        dat$Activity<- factor(dat$Activity,
                            levels=c("1","2","3","4","5","6"), 
                            label=c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
        
# Step 5: From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
        #Melting the table into the long format (only four columns)
        library(reshape2)
        datMelt<-melt(dat, variable.name= "Feature", value.name= "Value")
        #Group by and summarize the three variables: subject, activity and 
        #feature. 
        library(dplyr)
        datMelt<- tbl_df(datMelt)
        datMelt$SjId <- as.numeric(datMelt$SjId)
        datMelt$Activity <- as.factor(datMelt$Activity)
        dato<-group_by (datMelt, SjId, Activity, Feature)
        dato<-arrange (dato, SjId, Activity, Feature)
        final<-summarise_each(dato, funs(mean))
        #Create table document
        write.table(final, file="Tidy Data Set.txt", row.names=FALSE, col.names=TRUE)
        #Print
        final
        