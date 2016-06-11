library("RODBC")

### ptt
channel = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\ptt_stock_data.accdb")
data = sqlQuery(channel, paste("select id, post_time, content_type, author, negative_score, positive_score, neg, pos from content;"))


### forum
channel = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\forum_data.accdb")
data = sqlQuery(channel, paste("select id, post_time, s_name, content_type, author, negative_score, positive_score, neg, pos from content;"))

### news1
channel = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\news_data_part1.accdb")
data = sqlQuery(channel, paste("select id, post_time, s_name, content_type, negative_score, positive_score, neg, pos from content;"))


### news2
channel = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\news_data_part2.accdb")
data = sqlQuery(channel, paste("select id, post_time, s_name, content_type, negative_score, positive_score, neg, pos from content;"))

data$post_y <- format(data$post_time, "%Y")
data$post_m <- format(data$post_time, "%m")
data$post_d <- format(data$post_time, "%d")

levels(data$neg) <- c(0:1)
levels(data$pos) <- c(0:1)

data2 = data
data3 = data

key = readRDS("keyword.rds")
key = iconv(key$V1, "utf-8", "big-5")
key = unique(key)
com = readRDS("ptt_stock_com.rds")
com = iconv(com, "utf-8", "big-5")
com = unique(com)

forum_key = read.table("word.txt", sep=" ",header=F, fileEncoding="utf-8")
forum_key = unique(forum_key)
forum_key = as.character(unlist(as.list(forum_key)))
news_key = read.table("news.txt", sep=" ",header=F, fileEncoding="utf-8")
news_key = unique(news_key)
news_key = as.character(unlist(as.list(news_key)))

#################################
### content matrix
for (i in 1:length(key)) {
	keyword = key[i]
	q1 = paste("select id from content where content.content like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data$temp = 0
	nonzero_idx = which(data$id %in% temp$id)
	data$temp[nonzero_idx] = 1
	colnames(data)[colnames(data) == "temp" ] = keyword
}
for (i in 1:length(com)) {
	keyword = com[i]
	q1 = paste("select id from content where content.content like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data$temp = 0
	nonzero_idx = which(data$id %in% temp$id)
	data$temp[nonzero_idx] = 1
	colnames(data)[colnames(data) == "temp" ] = keyword
}
# add forum_key col
for (i in 1:length(forum_key)) {
	keyword = forum_key[i]
	q1 = paste("select id from content where content.content like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data$temp = 0
	nonzero_idx = which(data$id %in% temp$id)
	data$temp[nonzero_idx] = 1
	colnames(data)[colnames(data) == "temp" ] = keyword
}
add news key col
for (i in 1:length(news_key)) {
	keyword = news_key[i]
	q1 = paste("select id from content where content.content like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data$temp = 0
	nonzero_idx = which(data$id %in% temp$id)
	data$temp[nonzero_idx] = 1
	colnames(data)[colnames(data) == "temp" ] = keyword
}


############################
# title matrix
for (i in 1:length(key)) {
	keyword = key[i]
	q1 = paste("select id from content where content.title like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data2$temp = 0
	nonzero_idx = which(data2$id %in% temp$id)
	data2$temp[nonzero_idx] = 1
	colnames(data2)[colnames(data2) == "temp" ] = keyword
}
for (i in 1:length(com)) {
	keyword = com[i]
	q1 = paste("select id from content where content.title like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data2$temp = 0
	nonzero_idx = which(data2$id %in% temp$id)
	data2$temp[nonzero_idx] = 1
	colnames(data2)[colnames(data2) == "temp" ] = keyword
}
add forum_key col
for (i in 1:length(forum_key)) {
	keyword = forum_key[i]
	q1 = paste("select id from content where content.title like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data2$temp = 0
	nonzero_idx = which(data2$id %in% temp$id)
	data2$temp[nonzero_idx] = 1
	colnames(data2)[colnames(data2) == "temp" ] = keyword
}
add news key col
for (i in 1:length(news_key)) {
	keyword = news_key[i]
	q1 = paste("select id from content where content.title like '%", keyword, "%';", sep="")
	temp = sqlQuery(channel, q1)

	data2$temp = 0
	nonzero_idx = which(data2$id %in% temp$id)
	data2$temp[nonzero_idx] = 1
	colnames(data2)[colnames(data2) == "temp" ] = keyword
}

######################
# for content + title matrix
for (i in 1:length(key)) {
	keyword = key[i]
	q1 = paste("select id from content where (content.title like '%", keyword, "%' Or content.content like'%", keyword, "%');", sep="")
	temp = sqlQuery(channel, q1)

	data3$temp = 0
	nonzero_idx = which(data3$id %in% temp$id)
	data3$temp[nonzero_idx] = 1
	colnames(data3)[colnames(data3) == "temp" ] = keyword
}
for (i in 1:length(com)) {
	keyword = com[i]
	q1 = paste("select id from content where (content.title like '%", keyword, "%' Or content.content like'%", keyword, "%');", sep="")
	temp = sqlQuery(channel, q1)

	data3$temp = 0
	nonzero_idx = which(data3$id %in% temp$id)
	data3$temp[nonzero_idx] = 1
	colnames(data3)[colnames(data3) == "temp" ] = keyword
}
add forum_key col
for (i in 1:length(forum_key)) {
	keyword = forum_key[i]
	q1 = paste("select id from content where (content.title like '%", keyword, "%' Or content.content like'%", keyword, "%');", sep="")
	temp = sqlQuery(channel, q1)

	data3$temp = 0
	nonzero_idx = which(data3$id %in% temp$id)
	data3$temp[nonzero_idx] = 1
	colnames(data3)[colnames(data3) == "temp" ] = keyword
}
add news key col
for (i in 1:length(news_key)) {
	keyword = news_key[i]
	q1 = paste("select id from content where (content.title like '%", keyword, "%' Or content.content like'%", keyword, "%');", sep="")
	
	temp = sqlQuery(channel, q1)

	data3$temp = 0
	nonzero_idx = which(data3$id %in% temp$id)
	data3$temp[nonzero_idx] = 1
	colnames(data3)[colnames(data3) == "temp" ] = keyword
}




# merge title and content table
temp = ifelse(data[,12:ncol(data)]==1 || data2[,12,ncol(data2)]==1) 
data3 = colbind(data3, temp)



# data = have_sub_string("聯發科", "聯發科", channel)

###########





















###
channel_1 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\forum_data.accdb")
data = sqlQuery(channel_1 , paste ("select title, content from content;"))
data$content <- gsub("\n", "", data$content)
data$cv <- apply(data, 1, function(x) paste(x[1], " ", x[2]))
temp <- data$cv
write(temp, file = "forum.txt",ncolumns =1,sep = "\n")

channel_1 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\forum_data.accdb")
top_t = sqlQuery(channel_1, paste("SELECT title, count(*) from content group by title order by count(*) DESC;"))
write.csv(top_t, "forum_top_title.csv", fileEncoding="UTF-8")



####
channel_2 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\ptt_stock_data.accdb")
data = sqlQuery(channel_2 , paste ("select title, content from content;"))
data$content <- gsub("\n", "", data$content)
data$cv <- apply(data, 1, function(x) paste(x[1], " ", x[2]))
temp <- data$cv
write(temp, file = "ptt.txt",ncolumns =1,sep = "\n")

channel_2 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\forum_data.accdb")
top_t = sqlQuery(channel_2, paste("SELECT title, count(*) from content group by title order by count(*) DESC;"))
write.csv(top_t, "ptt_top_title.csv", fileEncoding="UTF-8")






###
channel_3 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\news_data_part1.accdb")
data = sqlQuery(channel_3 , paste ("select title, content from content;"))
data$content <- gsub("\n", "", data$content)
data$cv <- apply(data, 1, function(x) paste(x[1], " ", x[2]))
temp <- data$cv
write(temp, file = "news1.txt",ncolumns =1,sep = "\n")


###
channel_4 = odbcConnectAccess2007("C:\\Users\\weich_000\\Desktop\\2016_stock\\news_data_part2.accdb")
data = sqlQuery(channel_4 , paste ("select title, content from content;"))
data$content <- gsub("\n", "", data$content)
data$cv <- apply(data, 1, function(x) paste(x[1], " ", x[2]))
temp <- data$cv
write(temp, file = "news2.txt",ncolumns =1,sep = "\n")




