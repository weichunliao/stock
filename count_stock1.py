#!/usr/bin/env python
# -*- coding:utf-8 -*-
import math
""" """
def term_doc_matrix(doc_list,sep=" ",specific_term=[]):
	vocalbulary={}
	doc_ind=1
	for doc in doc_list:
		print (doc_ind)
		for term in set(doc.strip("\n").split(sep)):
			if len(specific_term)>0 and term not in specific_term:
				continue
			if term in vocalbulary:
				vocalbulary[term]+=1 #df
			else:
				vocalbulary[term]=1 #df
		doc_ind+=1

	return vocalbulary		

if __name__ == '__main__':

	import sys
	import os.path


	#file_path="C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\ptt_stock_content.csv"
	file_path="C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\temp2.txt"
	#file_path="C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\ptt_content_seg.txt"
	#file_path="C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\temp.txt"
	file_name, file_extension = os.path.splitext(file_path)

	post=list()

	#是否使用斷過詞的文章
	is_seg=0

	if is_seg==1:
		file=open(file_path,'r',encoding='utf-8')
		post=file.readlines()
		file.close()
	else:	
		import jieba
		import jieba.posseg as pseg
		#切換成繁體詞庫
		jieba.set_dictionary('C:\\Python27\\Lib\\site-packages\\jieba-0.38-py2.7.egg\\jieba\\dict_big.txt')
		jieba.load_userdict("C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\stock_dict.txt")

		seg_output=open(file_name+"_seg"+file_extension,"w",encoding="utf-8")

		i=1
		with open(file_path,'r',encoding="utf-8") as data:
			for line in data:
				try:
					#print(line)
					#content=line.split("\t")[14]
					content=line.strip()
					seg_list = jieba.cut(content, cut_all=False)
					seg_list_parse = " ".join(seg_list)  # 全模式
					post.append(seg_list_parse)
				
					seg_output.write(seg_list_parse)
					seg_output.write("\n")
				except:
					print("Unexpected error:", sys.exc_info()[0])
					print("error line {0} \n".format(i))

				i+=1
				# if i==10:
				# 	break
		seg_output.close()		
	
	print ("read data")

	company_list=list()
	company_file="C:\\Users\\Can\\Documents\\NTU\\大數據與商業分析\\stock\\company_name.csv"	
	with open(company_file,'r',encoding="utf-8") as company:
		for line in company:
			name=line.strip().split(" ")[1]
			company_list.append(name)
	print("load company list")
	print(" ".join(company_list))

	vol=term_doc_matrix(post,sep=" ",specific_term=company_list)
	print("finish df counting")

	cc=list()

	for stock in company_list:
		if stock in vol:
			cc.append((stock,vol[stock]))

	#sort by df
	cc.sort(key=lambda x: x[1],reverse=True)
	print("sort df")

	#output the result
	output=open(file_name+"_df"+file_extension,'w',encoding="utf-8")
	for stock in cc:
		output.write("{0} {1}\n".format(stock[0],stock[1]))	
	output.close()






