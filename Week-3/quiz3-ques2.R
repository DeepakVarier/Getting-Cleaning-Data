fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
getwd()
setwd("C:/Users/Deepak/Documents/John Hopkins Data science")
filedest <- paste(getwd(),"Cleaning Data/Week 3"sep="/")
filename <- paste(filedest,"jeff.jpg",sep="/")
# download from the URL
download.file(fileurl, filename, method='curl' )

# download from the URL
download.file(file.url, file.dest, mode='wb' )

# load package
library(jpeg)

# load the data
picture <- readJPEG('jeff.jpg', native=TRUE)

# get the quantile info
quantile(picture, probs = c(0.3, 0.8) )