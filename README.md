There are 4 main steps in the script, which all will end up with a tidy dataset.

#1 Download the datasets from the internet and allocate the dataset to each variable, after that it will merge the "X_train.txt" and "X_test.txt"

#2 In the second step, the script names each one of the collumns of the new merged dataset with the help of the "features.txt", which contains the collumn´s names.
  
#3 Each dataset´s rows represents one activity, and this information is found in the "y_train.txt" and "y_test.txt", which is found in its numerical form, then we transform the numerical factor to character factor with the "activity_labels.txt" file and merge the two datasets.

#4 Next step is to get the means of each variable regarding each type of activity, the script accomplish this by grouping the variables by activicties groups and then perform the mean operation giving us the "dataset_means", whichs the dataset that we´ll striving for