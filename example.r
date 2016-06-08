ptt <- readRDS("ptt_mat_rds")

#看ptt這個matrix的特性
head(ptt)
nrow(ptt)
ncol(ptt)

#找出總作者數
length(unique(ptt$author))
#找出作者id及對應的發文次數
head(sort(table(ptt$author), decresing=T))

wong_idx <- which(ptt$王品 == 1, arr.ind=T) #找出王品為1的row index
#王品=1 的資料
wong <- ptt[wong_idx,]
head(wong)
nrow(wong)

#欄位總和
colSums(wong[,12:ncol(wong)])

#找出neg,pos都是1的row
idx <- which((wong$neg == 1) & (wong$pos == 1), arr.ind=T)

#做出date的column
wong$date <- paste(wong$post_y, wong$post_m, wong$psot_d, sep="/")
#統計date
count_date <- table(wong$date)
#plot
plot(count_date, type="l")


#畫出王品neg=1的發文頻率
temp <- wong[wong$neg==1,]
count_date <- table(temp$date)
plot(count_date, type="l")

