#!/bash/sh


#为学生信息的添加，删除，查询，修改
#
#
#
#
#

#参数依次为学生学号 姓名 班级
function insert_one(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	insert into student values('$1','$2','$3')
	EOF
	echo "插入成功！"
}


function insert(){

	echo "请输入插入的方式："
	echo "I1：单个学生信息插入："
	echo "I2：班级学生信息插入"
	echo "I3：批量学生信息插入"
	read menu
	case $menu in
	I1)
		echo "请输入学生的学号，姓名，班级（中间以空格隔开）"
		read s_id s_name s_class
		insert_one $s_id $s_name $s_class;;
	I2)
		echo "请输入插入的班级名称:"
		read class
		echo "确认请按1"
		read flag
		while [ $flag = '1' ]
		do
			echo "请输入学生的学号，姓名（中间以空格隔开）"
			read s_id s_name
			insert_one s_id s_name class;
			echo "继续插入请输入1,退出插入请按0"
			read flag			
		done;;
		
	I3)
		echo "请输入要添加学生信息文件的绝对路径（包含文件名）"
		read path
		cat $path| while read line
		do
			insert_one $line
		done;;
	esac	
}


#参数为要删除的学生学号
function delete_one(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	delete from student where stu_id='$1';
	EOF
	echo "删除成功！"	
}

#参数为要删除的班级
function delete_class(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	delete from student where class='$1';
	EOF
	echo "删除成功！"	
}

function delete(){
	echo "请输入删除的方式："
	echo "D1):按单个学生删除"
	echo "D2):按班级批量删除"
	echo "----------------------------"
	read menu
	case $menu in
	D1)echo "请输入要删除学生的学号"
	read s_id
	delete_one $s_id;;
	D2)echo "请输入要删除班级的名称"
	read class
	delete_class $class;;
	D*)echo "输入不合法";;
	esac
}


function select_all(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	select * from student;
	EOF
}
#按班级查询，参数为班级名称
function select_class(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	select * from student where stu_class='$1';
	EOF
}

#参数为保存的路径名及文件名
function select_tofile(){
	
	mysql -h123.206.16.190 -upt -p1438>>$1<<-EOF
	use pt;
	select * from student;
	EOF
	echo "导出成功！"
}
function select_i(){
	echo "请输入查询的方式："
	echo "S1):查询所有学生"
	echo "S2):查询某班级学生"
	echo "S3):将所有学生导出到文件"
	echo "----------------------------"
	read menu
	case $menu in
	S1)select_all;;
	S2)echo "请输入要查询班级的名称"
	read class
	select_class $class;;
	S3)echo "请输入要将学生信息保存的路径名及文件名"
	read path
	select_tofile $path;;
	S*)echo "输入不合法";;
	esac 
}



function update()
{
	echo "请输入要修改学生的学号："
	read s_id
	echo "请输入要修改学生的新信息（学号 姓名 班级）"
	read s_newid s_newname s_newclass
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	update student set stu_id='$s_newid',stu_name='$s_newname',stu_class='$s_newclass' where stu_id='$s_id';
	EOF
	echo "更新成功！"
}

#
#
#
#为题目信息的添加，查询，修改，删除
#
#
#############################           添加            ###########3######################
function insert_one_sub(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	insert into subject values('$1','$2')
	EOF
	echo "插入成功！"
}


function insert_sub(){

	echo "请输入插入的方式："
	echo "I1：单个题目插入："
	echo "I2：批量题目信息插入"
	read menu
	case $menu in
	I1)
		echo "请输入题目的编号（日期+编号） 内容（中间以空格隔开）"
		read sub_date sub_exp
		insert_one_sub $sub_date $sub_exp;;
	
	
	I2)
		echo "请输入要添加题目信息文件的绝对路径（包含文件名）"
		read path
		cat $path| while read line
		do
			insert_one_sub $line
		done;;
	esac	
}

#############################           删除             ###################################33333
#参数为要删除的题目编号（日期+当日编号）
function delete_one_sub(){
	echo "请输入要删除题目的编号"
	read sub_date
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	delete from subject where sub_id='$sub_date';
	EOF
	echo "删除成功！"	
}

################################                 查询           ###################33###################
#查询所有的题目信息并输出
function select_all_sub(){
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	select * from subject;
	EOF
}

#参数为保存的路径名及文件名
function select_tofile_sub(){
	
	mysql -h123.206.16.190 -upt -p1438>>$1<<-EOF
	use pt;
	select * from subject;
	EOF
	echo "导出成功！"
}
#查询题目信息的目录
function select_sub(){
	echo "请输入查询的方式："
	echo "S1):查询所有题目"
	echo "S3):将所有题目信息导出到文件"
	echo "----------------------------"
	read menu
	case $menu in
	S1)select_all_sub;;
	S2)echo "请输入要将题目信息保存的路径名及文件名"
	read path
	select_tofile_sub $path;;
	S*)echo "输入不合法";;
	esac 
}


##########################                  更新               ####################################
function update_sub()
{
	echo "请输入要修改题目的编号："
	read sub_date
	echo "请输入要修改题目的新信息（题目编号 介绍）"
	read sub_new_date sub_new_exp
	mysql -h123.206.16.190 -upt -p1438<<-EOF
	use pt;
	update subject set sub_id='$sub_new_date',sub_name='$sub_new_exp' where sub_id='$sub_date';
	EOF
	echo "更新成功！"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# 
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
		echo "测评结果为:"
		echo -e "\nshow.txt:" # 测评结果
		cat $INIT_PATH/test/show.txt
		echo "插入数据库信息:"
		mysql -h123.206.16.190 -upt -p1438<<-EOF
		use pt;
		create table $sub_id_db(stu_id varchar(12) not null,status varchar(20),similar_stu varchar(200),primary key(stu_id));
		EOF
		#create_db '$sub_id'
		cat $INIT_PATH/test/show.txt| while read line
		do
			insert_db $sub_id_db $line
		done
		
		insert_num $c_num $cpp_num $java_num $sum_num $sub_id
		echo "编译错误信息:"
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
#参数为测评结果路径program_test()









# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #!/bin/bash 
# 敏感词检测

#function insert_db(){
#	mysql -h123.206.16.190 -upt -p1438<<-EOF
#	use pt;	
#	insert into $1(stu_id,status) values('$2','$3');
#	EOF
#}


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

#function insert_db(){
#	mysql -h123.206.16.190 -upt -p1438<<-EOF
#	use pt;	
#	insert into $1(stu_id,status) values('$2','$3');
#	EOF
#}


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

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# 
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




echo "**********************************************************************"
echo "*					燕山大学程序测评系统								*"
echo "*				输入1, 学生信息管理			*"
echo "*				输入2，题目信息管理			*"
echo "*				输入3，敏感词语检测			*"
echo "*				输入4，程序测评功能			*"
echo "*				输入5，抄袭检测功能			*"
echo "**********************************************************************"
read menu
case $menu in
1)
	echo "**************************************************"
	echo "			I:添加学生信息			"
	echo "			U:修改学生信息			"
	echo "			D:删除学生信息			"
	echo "			S:查询学生信息			"
	echo "**************************************************"
	read choose
	case $choose in
		I)insert;;
		U)update;;
		D)delete;;
		S)select_i;;
	esac;;
2)
	echo "**************************************************"
	echo "			I:添加题目信息			"
	echo "			U:修改题目信息			"
	echo "			D:删除题目信息			"
	echo "			S:查询题目信息			"
	echo "**************************************************"
	read choose_1
	case $choose_1 in
		I)insert_sub;;
		U)update_sub;;
		D)delete_one_sub;;
		S)select_sub;;
	esac;;
3)
	sensitivity_test;;
4)
	program_test;;
esac


































