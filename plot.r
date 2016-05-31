library("readxl")
library("(RColorBrewer")

setwd("/Users/weichun/Desktop/stock")

readData <- function(filename){

	temp <- read_excel(filename, col_names=T, skip=1)
	temp <- temp[-1,]
	return (temp)
}

data <- readData("eco_year.xlsx")
rownames(data) <- c(1:nrow(data))

data2 <- head(data, (nrow(data)-1)) #刪掉2015年，因為很多蘭市NA
na_col <- unique(which(data2=="NA", arr.ind=T)[,2])
data2 <- data2[,-na_col] #刪掉有NA的欄位

data3 <- data.matrix(data2, rownames.force = NA) #轉numeric matrix

matplot(scale(data3[,2:ncol(data3)]), type = "l", lty = 1, lwd = 1, pch = 16, col = c(1:40))
        # xlab = NULL, ylab = NULL, xlim = NULL, ylim = NULL
axis(1,at=seq(1,15,1),label=c(2000:2014))#放x軸

legend("topright", inset=.05, legend=colnames(data3[,2:ncol(data3)]), fill=c(1:40), horiz=F)
