fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
filedest <- paste(getwd(),"John Hopkins Data science/Cleaning Data/Week 3"sep="/")
filename <- paste(filedest,"getdata_data_ss06hid.csv",sep="/")
# download from the URL
download.file(fileurl, filename, method='curl' )

# read the data
ACS <- read.csv(filename)

# create vector
ACS$agricultureLogical <- ifelse(ACS$ACR==3 & ACS$AGS==6,TRUE,FALSE)

# read lines
which(ACS$agricultureLogical)
