<h1>Coursera Data Science Specialization
<h2>Getting and Cleaning Data -> Course Programming Assignment

The assignment for Getting and Cleaning Data Coursera course 3 of the Data Science Specialization generates 3 files
<li>This Readme file
<li>The Codebook decribes DataSet Identifiers (keys), measures and a lookup DataSet
<li>run_analysis.R, R Script executes the following:

Download the zip file containing the datasets if it doesn't already exist
Extracts all files from the zip file if not already done
Load feature and activity text files into R data frames and insure proper data typing
Load test and training text files into R data frames, only load columns containing "mean" or "std" in column name
Load activity and subject text files into R data frames
Merges activity, subject and test or training data frames into test and training data frames
Merges the test and training data frames into a complete data frame container
Transforms activity and subject columns as factors in preparation for a melt operation
Uses Reshape2 function melt to split out identifiers and measures into a "long" vertical data frame
Creates a "tidy" dataset containing "mean" of each measure (variable) by activity-subject identifier candidate key group
dplyr chaining functionality generates the tidytDf data frame in the last step
