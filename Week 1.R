# Download csv file from internet

directory <- "/John Hopkins Data science/Cleaning Data"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
path <- paste(getwd(),directory,sep="/")
print(path)
filename <- "getdata_data_ss06hid.csv"
download.file(url,destfile = paste(path,filename,sep="/"),method="curl") #curl is to be used only for mac OS
dateDownloaded <- date()
data <- read.csv(paste(path,filename,sep="/"),header=TRUE)
names(data)
summary(data$VAL)
prop_over <- subset(data,data$VAL==24)
nrow(prop_over)

###################---------------------------############################

# Download Excel file from internet
install.packages("xlsx")
library(xlsx)
library(rJava)
install.packages("rJava")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
path <- paste(getwd(),directory,sep="/")
print(path)
filename <- "getdata_data_FDATA.gov_NGAP.xlsx"
download.file(url,destfile = paste(path,filename,sep="/"),method="curl") #curl is to be used only for mac OS
dateDownloaded <- date()

col <- 7:15
Nat_Gas_Acq <- read.xlsx(paste(path,filename,sep="/"),sheetIndex = 1,colIndex=col,startRow=18, endRow=23,header = TRUE)
names(Nat_Gas_Acq)
dat <- Nat_Gas_Acq
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

###################---------------------------############################


## Download and read xml files from internet
install.packages("XML")
library(XML)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
path <- paste(getwd(),directory,sep="/")
print(path)
filename <- "getdata_data_rest.xml"
download.file(url,destfile = paste(path,filename,sep="/"),method="curl") #curl is to be used only for mac OS
dateDownloaded <- date()

doc <- xmlParse(paste(path,filename,sep="/"))
## doc <- xmlTreeParse(url,useInternalNodes = TRUE)  ---> Did Not work
rootNode <- xmlRoot(doc)
xmlName(rootNode)
## Checking the 1st entry in the xml file
rootNode[[1]]

# Read the values in the zipcode and sum the no. of observations for which zip = 21231
zip <- xpathSApply(doc, "//zipcode", xmlValue)
sum(zip == "21231")


###################---------------------------############################

install.packages("data.tables")
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
filename <- "housingIdaho.csv"
download.file(url, destfile = paste(path,filename,sep="/"), method = "curl")
dateDownloaded <- date()

## Read the data using fread
DT <- fread(paste(path,filename,sep="/"))
## Find the mean of pwgtp15 variable broken down by sex
DT[,mean(pwgtp15),by=SEX]