# Roll no. 33140
# Batch L9
# Assignment 5 (1) : Perform subsetting, melting and casting of dataset (Facebook).

setwd("G:/College/SL6/Assignment5/")

dataset_Facebook = read.csv2("G:/College/Sl-VI DataSets/dataset_Facebook.csv",header = T, sep = ';')
View(dataset_Facebook)
str(dataset_Facebook)

#subsetting
v1 <- subset(dataset_Facebook,type = "photo")
# View(v1)
str(v1)

# subsetting as per comments
v2 <- subset(dataset_Facebook,type = "video")
# View(v2)
str(v2)


#merge data
m1 <- merge(v1,v3,by="Paid")
# View(m1)
str(m1)

#sort data
s1 <- dataset_Facebook[order(dataset_Facebook$comment),]
# View(s1)
s1

#sorting data in ascending order as number of comments, and then decreasing number of shares
s2 <- dataset_Facebook[order(dataset_Facebook$comment, -dataset_Facebook$share),]
# View(s2)
s2

# Transposing Data (Row names bacome column names)
t(v1)

# Melting Data to long format
library(reshape2)
# Melt, i.e. each row is a unique ID-variable combination
m1 <- melt(v3, id <-  c("Type","Lifetime.Post.Total.Reach"))
m2 <- m1 # Extra variable
View(m1)
# head(m1)
# tail(m1)
str(m1)

levels(m1$variable)[levels(m1$variable) == 'Paid'] <- 'first'
levels(m1$variable)[levels(m1$variable) == 'Lifetime.Post.Total.Impressions'] <- 'second'
m1

# Sort as per Type and variable
# This is long format
m1 <- m1[ order(m1$Type,m1$variable),]
m1

# Long to wide
m2_wide = dcast(m2,Type + Lifetime.Post.Total.Reach ~ variable, value.var = "value")
  # This is the wide format data
m2_wide

