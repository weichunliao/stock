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


年月日	成交金額	成交數量	成交筆數	總委買數量	總委買筆數	總委賣數量	總委賣筆數	漲停委買數量	漲停委買筆數	
漲停委賣數量	漲停委賣筆數	跌停委買數量	跌停委買筆數	跌停委賣數量	跌停委賣筆數	上漲家數	下跌家數	持平家數	未成交家數	
漲停家數					