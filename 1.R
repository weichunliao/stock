setwd("C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock") //#gitignore 

readData <- function(filename ){

	data <- read.table(filename, header = TRUE, sep = ",", stringsAsFactors = FALSE,skip=1)
	data <- data[-1,]
	data <-  as.data.frame(apply(data,2,as.numeric))
	return(data)
}
checkTheSameColumn　<-function(data){

	for(i in c(1:(ncol(data)-1))){

		for(j in c((i+1):ncol(data))){

			if(identical(data[,i],data[,j])){
				print (i)
				print (j)
				print ("-----")
			}
		}
	}

}
separateXY <- function(data,ynames){
	xnames<- setdiff(colnames(data),ynames)
	data_y <- data[ynames]
	data_x <- data[xnames]
	return(list("x"=data_x,"y"=data_y))
}

##讀檔
year <- readData("year.csv")
month <- readData("month.csv")
season <- readData("season.csv")


year_y_names<-c("成交股數...股票..千股.","成交金額...股票..新台幣千元.","成交筆數...總筆數..千股.",
	"上市公司家數..新台幣千元.","上市總股數..千股.","上市股份面值總額..新台幣千元.",
	"上市股份市值總額.期終日...新台幣千元.","增資總金額..新台幣千元.",
	"發行量加權股價指數..基期..民國.55.年.100.","股價指數..基期..民國.55.年.100.","平均每日成交股數...股票..千股.",
	"平均每日成交金額...股票..千股.","上市股票...公司家數..家.","上市股票...總面值..新台幣百萬元.",
	"上市股票...總市值..新台幣百萬元.","上市股票...總成交值..新台幣百萬元.",
	"上市股票...日平均成交值..新台幣百萬元.")
year_s<- separateXY(year,year_y_names)
year_y <- year_s$y
year_x <- year_s$x

month_y_names<-c("成交股數...股票..千股.","成交金額...股票..新台幣千元.","成交筆數...總筆數..千股.",
	"股價指數..基期..民國.55.年.100.","上市股票...公司家數..家.","上市股票...總面值..新台幣百萬元.",
	"上市股票...總市值..新台幣百萬元.","上市股票...總成交值..新台幣百萬元.",
	"上市股票...日平均成交值..新台幣百萬元.")
month_s<- separateXY(month,month_y_names)
month_y <- month_s$y
month_x <- month_s$x

# season_y_names<-c("")
# season_s<- separateXY(season,season_y_names)
# season_y <- season_s$y
# season_x <- season_s$x

plot(cbind(year_y[,1],year_x[,c(1:6)]))
plot(cbind(year_y[,1],year_x[,c(7:12)]))
plot(cbind(year_y[,1],year_x[,c(13:18)]))
plot(cbind(year_y[,1],year_x[,c(19:24)]))

##好像相關的
year_relevant_names <- c("利率...貨幣市場利率..年率..","匯率..新台幣.外幣....美金","經濟成長率....",
	"國民所得毛額..按當期價格計算...百萬美元.","國內生產毛額...中華民國..美金十億元.","經濟成長率...美國....")
year_relevant <- year[year_relevant_names]
year_anal <- cbind(y=year_y[,1],year_relevant)
m <- lm(y~. , data=year_anal)
