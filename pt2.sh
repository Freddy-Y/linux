#!/bin/bash 
# 敏感词检测

function insert_db(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;	
	insert into $1(stu_id,status) values('$2','$3');
	EOF
}


function check_Sensitivity(){
	for file in ` ls $1`
	do
		if [ -d $1"/"$file ]; then
			if [ $file != sen -a $file != dissen ]; then
				check_Sensitivity $1"/"$file
			fi
		else
			cd $1
			# local fileName=${file%%.*}
			# 取文件名部分
			# cat $INIT_PATH/sen_word.txt
			if [ ${file##*.} = cpp ]; then
				while read line1
				do
					grep -inw $line1 $file>>$INIT_PATH/test/sen_result.txt
					# -w 匹配整个单词
					# -i 不区分大小写
					# -n 输出行号
					if [ $? -eq 0 ]; then
						echo $file>>$INIT_PATH/test/sen_result.txt
						mv $file $INIT_PATH/sen
						break;
					fi
				done < $INIT_PATH/test/sen_word.txt
			fi
			if [ ${file##*.} = 0c ]; then
				while read line1
				do
					grep -inw $line1 $file>>$INIT_PATH/test/sen_result.txt
					# -w 匹配整个单词
					# -i 不区分大小写
					# -n 输出行号
					if [ $? -eq 0 ]; then
						echo $file>>$INIT_PATH/test/sen_result.txt
						mv $file $INIT_PATH/sen
						break;
					fi
				done < $INIT_PATH/test/sen_word.txt
			fi
			if [ ${file##*.} = 0java ]; then
				while read line1
				do
					grep -inw $line1 $file>>$INIT_PATH/test/sen_result.txt
					# -w 匹配整个单词
					# -i 不区分大小写
					# -n 输出行号
					if [ $? -eq 0 ]; then
						echo $file>>$INIT_PATH/test/sen_result.txt
						mv $file $INIT_PATH/sen
						break;
					fi
				done < $INIT_PATH/test/sen_word.txt
			fi
		fi
	done
}

function insert_db(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;	
	insert into $1(stu_id,status) values('$2','$3');
	EOF
}


function sensitivity_test(){
	# echo -e "请输入你要读取的文件夹路径\n当前路径为${PWD}"
	# read INIT_PATH 
	# echo "你输入的文件夹路径为${INIT_PATH}" 
	# INIT_PATH="/mnt/hgfs/PT/linux/2017043001"
	echo 当前路径为：$PWD
	echo 文件夹内容：
	ls
	echo -e "\n请输入你要测评的当前目录下的作业文件夹名称"
	read sub_id
	if [ -d $sub_id ]; then
		INIT_PATH=$PWD"/"$sub_id
		# echo $INIT_PATH
		cat /dev/null > $INIT_PATH/test/sen_result.txt
		cd $INIT_PATH
		check_Sensitivity $INIT_PATH
		cd $INIT_PATH
		cd ../
		echo -e "\nsen_result.txt:" # 测评结果
		cat $INIT_PATH/test/sen_result.txt
		echo "敏感词测评完成!"

	else
		echo 无此文件夹，请确认后重试
	fi
}

