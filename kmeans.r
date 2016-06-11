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
data2 <- data2[-empty_row,]

data = read.csv("c:\\Users\\weich_000\\Downloads\\newdata_2.csv", header=T, skip=2,fileEncoding="big-5")
colnames(data)[2] = "name"

data2 = data[-unique(which(data == "-", arr.ind=T)[,1]),]

data2[,3] <- as.double(gsub(",", "",as.character(data2[,3])))
data2[,4] <- as.double(gsub(",", "",as.character(data2[,4])))
data2[,5] <- as.double(gsub(",", "",as.character(data2[,5])))
data2[,6] <- as.double(gsub(",", "",as.character(data2[,6])))
data2[,7] <- as.double(gsub(",", "",as.character(data2[,7])))
data2[,8] <- as.double(gsub(",", "",as.character(data2[,8])))


data2 <- data2[,-5]
data2 <- data2[,-5]

beta <- read.table("Downloads/beta_new.csv",header=T,skip=2,fileEncoding="big-5",na.strings="NA",sep=",")
colnames(bbb)[2] <- "公司名"

# hclust
m_trix = data2[,2:5]

dm = dist(m_trix,method="euclidean")
cluster = hclust(dm, method="complete")
plot(cluster)

#kmean

# km <- kmeans(data2[,2:6], 5, nstart = 25)
# plot(data2[,2:6], col = km$cluster)

data2[,3] <- as.double(data2[,3])
data2[,4] <- as.double(data2[,4])
data2[,5] <- as.double(data2[,5])
data2[,6] <- as.double(data2[,6])
data2[,7] <- as.double(data2[,7])
data2[,8] <- as.double(data2[,8])


data3[,2] <- as.numeric(data3[,2])
data3[,3] <- as.numeric(data3[,3])
data3[,4] <- as.numeric(data3[,4])
data3[,5] <- as.numeric(data3[,5])
data3[,6] <- as.numeric(data3[,6])

# 
km <- kmeans(scale(data2[,3:8]), 5, nstart=25)
plot(data2[,3:8], col = km$cluster)


# 


# points(km$centers, col = 1:6, pch = 8)

group1 <- as.numeric(names(km$cluster[km$cluster == 1]))
group2 <- as.numeric(names(km$cluster[km$cluster == 2]))
group3 <- as.numeric(names(km$cluster[km$cluster == 3]))
group4 <- as.numeric(names(km$cluster[km$cluster == 4]))
sort(o_data[group1, 2])
sort(o_data[group2, 2])
sort(o_data[group3, 2])
sort(o_data[group4, 2])

group1_2 <- as.numeric(names(km2$cluster[km2$cluster == 1]))
group2_2 <- as.numeric(names(km2$cluster[km2$cluster == 2]))
group3_2 <- as.numeric(names(km2$cluster[km2$cluster == 3]))
group4_2 <- as.numeric(names(km2$cluster[km2$cluster == 4]))
group5_2 <- as.numeric(names(km2$cluster[km2$cluster == 5]))
sort(o_data[group1_2, 2])
sort(o_data[group2_2, 2])
sort(o_data[group3_2, 2])
sort(o_data[group4_2, 2])
sort(o_data[group5_2, 2])

sort(data[group1_2, 2])
sort(data[group2_2, 2])
sort(data[group3_2, 2])
sort(data[group4_2, 2])
sort(data[group5_2, 2])


group1_3 <- which(km3$cluster == 1,arr.ind=T)
group2_3 <- which(km3$cluster == 2,arr.ind=T)
group3_3 <- which(km3$cluster == 3,arr.ind=T)
group4_3 <- which(km3$cluster == 4,arr.ind=T)

group1_4 <- which(km4$cluster == 1,arr.ind=T)
group2_4 <- which(km4$cluster == 2,arr.ind=T)
group3_4 <- which(km4$cluster == 3,arr.ind=T)
group4_4 <- which(km4$cluster == 4,arr.ind=T)

###


# 
km2 <- kmeans(scale(data3[,2:5]), 5)
plot(data3[,2:5], col = km2$cluster)

plotcluster(data3[,2:5], km$cluster)


v1 <- as.numeric(data2[,2])
v2 <- as.numeric(data2[,3])
v3 <- as.numeric(data2[,4])

scatter3D(x=v2, y=v1, z=v3, colvar = v1, col = NULL, add = FALSE)









