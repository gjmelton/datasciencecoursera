<h1>Coursera Data Science Specialization</h1>
<h2>Getting and Cleaning Data -> Course Programming Assignment</h2>

The assignment for Getting and Cleaning Data Coursera course 3 of the Data Science Specialization generates 3 files:
  <li>This Readme file
  <li>The Codebook decribes DataSet Identifiers (keys), measures and a lookup DataSet
  <li>run_analysis.R, R Script executes the following:


<li>Download the zip file containing the datasets if it doesn't already exist
<li><li>Extracts all files from the zip file if not already done
<li>Load feature and activity text files into R data frames and insure proper data typing
<li>Load test and training text files into R data frames, only load columns containing "mean" or "std" in column name
<li>Load activity and subject text files into R data frames
<li>Merges activity, subject and test or training data frames into test and training data frames
<li>Merges the test and training data frames into a complete data frame container
<li>Transforms activity and subject columns as factors in preparation for a melt operation
<li>Uses Reshape2 function melt to split out identifiers and measures into a "long" vertical data frame
<li>Creates a "tidy" dataset containing "mean" of each measure (variable) by activity-subject identifier candidate key group
<li>dplyr chaining functionality generates the tidytDf data frame in the last step

