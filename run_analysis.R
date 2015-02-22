setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset/test")
x_test=read.table("X_test.txt")
y_test=read.table("y_test.txt")

setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset/train")
x_train=read.table("X_train.txt")
y_train=read.table("y_train.txt")

xcombine=rbind(x_test,x_train)
ycombine=rbind(y_test,y_train)

combined=(cbind(xcombine,ycombine))

setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset")

col_names=read.table("features.txt")

colnames(combined)=t(col_names[,2])



setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset/test")

subject_test=read.table("subject_test.txt")

setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset/train")

subject_train=read.table("subject_train.txt")

subject_total=rbind(subject_train,subject_test)

setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning/UCI HAR Dataset")

activity_labels=read.table("activity_labels.txt")



stdevcount=grep("std()",colnames(combined))
meancount=grep("mean()",colnames(combined))

stdevcols=combined[,stdevcount]
meancols=combined[,meancount]

meanFreq_cols=grep("meanFreq",colnames(meancols))

meancols=meancols[,-meanFreq_cols]

data=cbind(subject_total,ycombine,meancols,stdevcols)


tidydata=c()
subjects=c(1:30)
colnames(data)[1]="Subjects"
colnames(data)[2]="Activities"


for(i in 1:30){
  for(j in 1:6){
    fake=subset(data,Subjects==subjects[i]&Activities==activity_labels[j,1])
    vector=apply(fake[,3:68],2,mean)
    new_vector=cbind(subjects[i],activity_labels[j,2],t(vector))
    tidydata=rbind(tidydata,new_vector)
  }
}

colnames(tidydata)[1]="Subjects"
colnames(tidydata)[2]="Activities"

names(tidydata)=gsub("At","Time",names(tidydata))
names(tidydata)=gsub("Acc","Accelerometer",names(tidydata))
names(tidydata)=gsub("^f","Frequency",names(tidydata))
names(tidydata)=gsub("Gyro","Gyroscope",names(tidydata))
names(tidydata)=gsub("Mag","Magnitude",names(tidydata))
names(tidydata)=gsub("BodyBody","Body",names(tidydata))

setwd("C:/Users/C16Matthew.Burzenski/Documents/Cadet Second Class Year/MATH378/R Projects/Data Cleaning")

write.table(tidydata,file="tidydata.txt",row.names=F)
