setwd("C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock") //#gitignore 

readData <- function(filename ){

	data <- read.table(filename, header = TRUE, sep = ",", stringsAsFactors = FALSE,skip=1)
	data <- data[-1,]
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

year <- readData("year.csv")
month <- readData("month.csv")
season <- readData("season.csv")


# year_y_names<-c("成交股數 - 股票 (千股)","成交金額 - 股票 (新台幣千元)","成交筆數 - 總筆數 (千股)",
# 	"上市公司家數 (新台幣千元)","上市總股數 (千股)","上市股份面值總額 (新台幣千元)",
# 	"上市股份市值總額(期終日) (新台幣千元)","增資總金額 (新台幣千元)",
# 	"發行量加權股價指數 (基期: 民國 55 年=100)","平均每日成交股數 - 股票 (千股)",
# 	"平均每日成交金額 - 股票 (千股)","股價指數 (基期: 民國 55 年=100)","上市股票 - 公司家數 (家)",
# 	"上市股票 - 總面值 (新台幣百萬元)","上市股票 - 總市值 (新台幣百萬元)",
# 	"上市股票 - 總成交值 (新台幣百萬元)","上市股票 - 日平均成交值 (新台幣百萬元)")


year_y_names<-c("成交股數...股票..千股.","成交金額...股票..新台幣千元.","成交筆數...總筆數..千股.",
	"上市公司家數..新台幣千元.","上市總股數..千股.","上市股份面值總額..新台幣千元.",
	"上市股份市值總額.期終日...新台幣千元.","增資總金額..新台幣千元.",
	"發行量加權股價指數..基期..民國.55.年.100.","平均每日成交股數...股票..千股.",
	"平均每日成交金額...股票..千股.","上市股票...公司家數..家.","上市股票...總面值..新台幣百萬元.",
	"上市股票...總市值..新台幣百萬元.","上市股票...總成交值..新台幣百萬元.",
	"上市股票...日平均成交值..新台幣百萬元.")
year_x_names<- setdiff(colnames(year),year_y_names)
year_y <- year[year_y_names]
year_x <- year[year_x_names]

month_y_names<-
