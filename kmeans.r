library("readxl")
library("stats")
library("scatterplot3d")
library("graphics")
library("GA")
library("plot3D")

setwd("Downloads")
temp <- read_excel("TW100.xls.xlsx", col_names=T)

data2015 <- temp[which(temp[,3] == temp[1,3]),]
null_col <- unique(which(data2015[,4:5]== "-",arr.ind=T)[,1])
data2015_2 <- data2015[-null_col,]


data2014 <- temp[which(temp[,3] == temp[98,3]),]
null_col <- unique(which(data2014[,4:7]== "-",arr.ind=T)[,1])
data2014_2 <- data2014[-null_col,]

data2013 <- temp[which(temp[,3] == temp[195,3]),]
null_col <- unique(which(data2013[,4:7]== "-",arr.ind=T)[,1])
data2013_2 <- data2013[-null_col,]

v1 <- as.numeric(data2013_2[,4])
v2 <- as.numeric(data2013_2[,5])
v3 <- as.numeric(data2013_2[,6])

scatter3D(x=v1, y=v2, z=v3, colvar = v1, col = NULL, add = FALSE)

###
library(stats)

o_data <- read.table("Downloads/cluster_stock.csv",header=T,skip=2,na.strings="NA",sep=",",fileEncoding="big-5")
colnames(o_data)[2] <- "公司名"
o_data <- o_data[,-c(3,4)]

o_data <- o_data[,-7]
data <- o_data[,-2]

empty_row <- which(data[,3]==data[6,3],arr.ind=T)
data2 <- data[-empty_row,]

empty_row <- which(data2[,4]=="-", arr.ind=T)
data2 <- data2[-b,]

data2[,2] <- as.numeric(data2[,2])
data2[,3] <- as.numeric(data2[,3])
data2[,4] <- as.numeric(data2[,4])
data2[,5] <- as.numeric(data2[,5])
data2[,6] <- as.numeric(data2[,6])


beta <- read.table("Downloads/beta_new.csv",header=T,skip=2,fileEncoding="big-5",na.strings="NA",sep=",")
colnames(bbb)[2] <- "公司名"

# hclust
m_trix = data2[,2:6]

dm = dist(m_trix,method="euclidean")
cluster = hclust(dm, method="complete")
plot(cluster)

#kmean

# km <- kmeans(data2[,2:6], 5, nstart = 25)
# plot(data2[,2:6], col = km$cluster)


data3 <- data2[,-5]
km <- kmeans(scale(data3[,2:5]), 4, nstart = 25)
plot(data3[,2:5], col = km$cluster)

km2 <- kmeans(scale(data3[,3:5]), 4, nstart = 25)
plot(data3[,3:5], col = km2$cluster)

data4 <- temp
data4[,2] <- as.numeric(data4[,2])
data4[,3] <- as.numeric(data4[,3])
data4[,4] <- as.numeric(data4[,4])
data4[,5] <- as.numeric(data4[,5])
data4[,6] <- as.numeric(data4[,6])


km3 <- kmeans(scale(data4[,2:6]), 4, nstart = 25)
plot(data4[,2:6], col = km3$cluster)

km4 <- kmeans(scale(data4[,3:6]), 4, nstart = 25)
plot(data4[,3:6], col = km4$cluster)



# points(km$centers, col = 1:6, pch = 8)

group1 <- which(km$cluster == 1,arr.ind=T)
group2 <- which(km$cluster == 2,arr.ind=T)
group3 <- which(km$cluster == 3,arr.ind=T)
group4 <- which(km$cluster == 4,arr.ind=T)

group1_2 <- which(km2$cluster == 1,arr.ind=T)
group2_2 <- which(km2$cluster == 2,arr.ind=T)
group3_2 <- which(km2$cluster == 3,arr.ind=T)
group4_2 <- which(km2$cluster == 4,arr.ind=T)

group1_3 <- which(km3$cluster == 1,arr.ind=T)
group2_3 <- which(km3$cluster == 2,arr.ind=T)
group3_3 <- which(km3$cluster == 3,arr.ind=T)
group4_3 <- which(km3$cluster == 4,arr.ind=T)

group1_4 <- which(km4$cluster == 1,arr.ind=T)
group2_4 <- which(km4$cluster == 2,arr.ind=T)
group3_4 <- which(km4$cluster == 3,arr.ind=T)
group4_4 <- which(km4$cluster == 4,arr.ind=T)













