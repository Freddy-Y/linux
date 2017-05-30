#!/bin/bash
export cpp_num=0
export c_num=0
export java_num=0
export sum_num=0


function insert_num(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;	
	update subject set stu_c_num='$1',stu_cpp_num=$2,stu_java_num=$3,stu_sum=$4 where sub_id='$5' ;
	EOF

}

function ergodic(){
	for file in ` ls $1`
	do
		if [ -d $1"/"$file ]; then
			if [ $file != sen ]; then
				ergodic $1"/"$file
			
			else
				local stu_id=${file%%.*}			
				for file in ` ls $1/sen`
				do
					mysql -h123.206.16.190 -upt -p1438<<-EOF
					use pt;	
					insert into  sub_id_db(stu_id) values('$file');
					EOF
				done		
			
			fi
		else
			local stu_id=${file%%.*}
			if [ ${file##*.} = cpp ]; then
				let "cpp_num=cpp_num+1"
				let "sum_num=sum_num+1"
				cd $1 # 复杂性
				g++ $stu_id.cpp -o $stu_id.out>>$INIT_PATH/test/cr.txt 2>&1
				# g++ $stu_id.cpp -o $stu_id.out 2>&1 | tee -a $INIT_PATH/cr.txt >nul
				# 加上>nul 不显示输出
				# cr:compile sout
				# echo $stu_id $file $?
				if [ $? -eq 0 ]; then
					while read line
					do
						echo $line|$1/$stu_id.out >>$1/out.txt
					done < $INIT_PATH/test/s_in.txt
					cmp -s $1/out.txt $INIT_PATH/test/s_out.txt
					# -s 错误信息不提示
					# 0 ：文件是相同的
					# 1 ：文件是不同的
					# >1：发生错误
					if [ $? -eq 0 ]; then
						echo "$stu_id true!">>$INIT_PATH/test/show.txt
					else 
						echo "$stu_id false!">>$INIT_PATH/test/show.txt
					fi
				else
					echo -e "\n" >> $INIT_PATH/test/cr.txt
					echo "$stu_id Compile_Error!">>$INIT_PATH/test/show.txt
				fi
				cat /dev/null > $INIT_PATH/out.txt # 清空输出文件
			fi

			if [ ${file##*.} = 0c ]; then
				let "c_num=c_num+1"
				let "sum_num=sum_num+1"
				cd $1 # 复杂性
				gcc $stu_id.c -o $stu_id.out>>$INIT_PATH/test/cr.txt 2>&1
				# g++ $stu_id.cpp -o $stu_id.out 2>&1 | tee -a $INIT_PATH/cr.txt >nul
				# 加上>nul 不显示输出
				# cr:compile sout
				# echo $stu_id $file $?
				if [ $? -eq 0 ]; then
					while read line
					do
						echo $line|$1/$stu_id.out >>$1/out.txt
					done < $INIT_PATH/test/s_in.txt
					cmp -s $1/out.txt $INIT_PATH/test/s_out.txt
					# -s 错误信息不提示
					# 0 ：文件是相同的
					# 1 ：文件是不同的
					# >1：发生错误
					if [ $? -eq 0 ]; then
						echo "$stu_id true!">>$INIT_PATH/test/show.txt
					else 
						echo "$stu_id false!">>$INIT_PATH/test/show.txt
					fi
				else
					echo -e "\n" >> $INIT_PATH/test/cr.txt
					echo "$stu_id Compile_Error!">>$INIT_PATH/test/show.txt
				fi
				cat /dev/null > $INIT_PATH/out.txt # 清空输出文件
			fi

			if [ ${file##*.} = 0java ]; then
				let java_num++
				let "sum_num=sum_num+1"
				cd $1 # 复杂性
				javac $stu_id.java -encoding utf8 -0 $stu_id.out>>$INIT_PATH/test/cr.txt 2>&1
				if [ $? -eq 0 ]; then
					while read line
					do
						echo $line|$1/$stu_id.out >>$1/out.txt
					done < $INIT_PATH/test/s_in.txt
					cmp -s $1/out.txt $INIT_PATH/test/s_out.txt
					# -s 错误信息不提示
					# 0 ：文件是相同的
					# 1 ：文件是不同的
					# >1：发生错误
					if [ $? -eq 0 ]; then
						echo "$stu_id true!">>$INIT_PATH/test/show.txt
					else 
						echo "$stu_id false!">>$INIT_PATH/test/show.txt
					fi
				else
					echo -e "\n" >> $INIT_PATH/test/cr.txt
					echo "$stu_id Compile_Error!">>$INIT_PATH/test/show.txt
				fi
				cat /dev/null > $INIT_PATH/out.txt # 清空输出文件
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







function program_test(){
# echo -e "请输入你要读取的文件夹路径\n当前路径为${PWD}"
# read INIT_PATH 
# echo "你输入的文件夹路径为${INIT_PATH}" 
# INIT_PATH="/mnt/hgfs/PT/linux/2017043001"

	echo 当前路径为：$PWD
	echo 文件夹内容：
	ls
	echo -e "\n请输入你要测评的当前目录下的作业文件夹名称"
	read  sub_id
	export sub_id_n=$sub_id
	if [ -d $sub_id ]; then
		INIT_PATH=$PWD"/"$sub_id
		# echo $INIT_PATH
		cat /dev/null > $INIT_PATH/test/show.txt #清空文件
		cat /dev/null > $INIT_PATH/test/cr.txt
		cd $INIT_PATH
		ergodic $INIT_PATH
		cd ../
		export sub_id_db=w_$sub_id
		#echo $sub_id_db
		echo -e "\nshow.txt:" # 测评结果
		mysql -h123.206.16.190 -upt -p1438<<-EOF
		use pt;
		create table $sub_id_db(stu_id varchar(12) not null,status varchar(20),similar_stu varchar(200),primary key(stu_id));
		EOF
		#create_db '$sub_id'
		cat $INIT_PATH/test/show.txt
		cat $INIT_PATH/test/show.txt| while read line
		do
			insert_db $sub_id_db $line
		done
		
		insert_num $c_num $cpp_num $java_num $sum_num $sub_id
		echo -e "\ncr.txt:" # 编译错误信息
		cat $INIT_PATH/test/cr.txt
		cd $INIT_PATH
		cd ../
		find -name "*.out" -exec rm -f '{}' \; # 清理测评过程文件
		find -name "out.txt" -exec rm -f '{}' \;
		echo program test finish!
	else
		echo 无此文件夹，请确认后重试
	fi
}
#参数为测评结果路径







