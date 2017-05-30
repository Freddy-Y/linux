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



echo "**********************************************************************"
echo "*                       燕山大学程序测评系统                       *"
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
esac
