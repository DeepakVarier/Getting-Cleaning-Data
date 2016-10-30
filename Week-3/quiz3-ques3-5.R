
# Download csv file from internet
library(dplyr)
directory <- "/John Hopkins Data science/Cleaning Data/Week 3"
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
path <- paste(getwd(),directory,sep="/")
print(path)
filename <- paste(path,"GDP.csv",sep="/")
download.file(url,destfile = filename,method="curl") #curl is to be used only for mac OS
dateDownloaded <- date()
# load the data
gdp <- read.csv(filename, header=FALSE,skip=5,nrows=190)
View(gdp)

# download the 2nd data set(educational dataset)
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
path <- paste(getwd(),directory,sep="/")
print(path)
filename2 <- paste(path,"GDP2.csv",sep="/")
download.file(url,destfile = filename2,method="curl") #curl is to be used only for mac OS
dateDownloaded2 <- date()
# load the 2nd data set
gdp2 <- read.csv(filename2)
View(gdp2)

# merge datasets
combined <- merge(gdp, gdp2, by.x='V1', by.y='CountryCode', sort=TRUE)
View(combined)

# sort the combined dataset
View(arrange(combined,desc(V2)))

# OECD
mean(combined[combined$Income.Group=='High income: OECD',]$V2)
# non OECD
mean(combined[combined$Income.Group=='High income: nonOECD',]$V2)

# Q5.
# assign quantile values
quentile <- c(0.2,0.4,0.6,0.8,1)
q <- quantile(combined$V2, quentile)

filt <- filter(combined,V2 <= 38,Income.Group == "Lower middle income")
View(arrange(filt,desc(V2)))