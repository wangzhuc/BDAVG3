#######################################
###  This cluster model is updated  ###
###  to inlude feature exclusion    ###
###  for irrelevant features.       ###
#######################################


# tell R where your file is located
#setwd('')

# this code checks if the dummies package is installed and if not installs it
if ("dummies" %in% installed.packages()) {
	library(dummies)
} else {
	install.packages("dummies")
	library(dummies)
}


# tell R what file to use
mydata <- read.csv("moble_devices.csv")

# convert to a R data frame
mydata <- data.frame(mydata)

# exclude unimportant variables
dummyVals <- c("blue", "dual_sim","four_g","three_g","touch_screen","wifi")
mydata <- dummy.data.frame(mydata, names=c(dummyVals), sep="_")

# fit the K-means model to mydata
fit <- kmeans(mydata, 5) #3 cluster solution

# get cluster means
means <- aggregate(mydata, by=list(fit$cluster), FUN=mean)

# append cluster assignment
mydata <- data.frame(mydata, fit$cluster)

# write the data back out to Excel
write.csv(mydata, file="ThirdCluster.csv", row.names=FALSE) # full data file with cluster assignments
write.csv(means, file="ThirdClusterMeans.csv", row.names=FALSE) # list of means by cluster

#end