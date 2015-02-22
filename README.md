# Data-Cleaning-Course-Project

First we read in all the data along with the column names, subject names, and activity labels. Then we found all of the columns
that contained the phrases "std()" or "mean()" and recorded those column numbers into seperate vectors. We then combined all 
the data (including subjects, y train and test data, the columns of the mean data and the columns of the standard deviation 
data) into one data frame. Next we had to tidy this data. We did this by looping through every column of the data set, creating 
a new vector contain the subject, activity label, and mean of the desired row, and finally row binding each new vector together.
Next we simply replaced the each ambiguous column name (most were abbreviated) to a more descriptive name. 
