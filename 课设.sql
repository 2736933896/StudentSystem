
USE MySchool;
DROP TABLE IF EXISTS SC       /*成绩*/
DROP TABLE IF EXISTS Student  /*学生信息*/
DROP TABLE IF EXISTS Course   /*课程*/
DROP TABLE IF EXISTS StudentUser  /*学生用户信息*/
DROP TABLE IF EXISTS Administrator  /*管理员用户信息*/
DROP TABLE IF EXISTS SysLog   /*注册日志*/
DROP TABLE IF EXISTS SysLog1   /*登陆日志*/
DROP TABLE IF EXISTS AVG1   /*平均成绩*/

Create table StudentUser  --学生注册信息表格
(ID nchar(20) primary key,
 PassWord nchar(32),
 Name nchar(20),
 Sex nchar(2),
 );

 Create table Administrator  --管理员注册信息表格
 (
 ID char(20) primary key,
 PassWord nchar(32),
 Name nchar(20),
 Sex char(2),
-- Birthday datetime ,
 --UserMobile nchar(11),
 );

Create table Student      --学生信息表格
(
Sno char(9) primary key,  --列级完整性约束条件,Sno是主码
Sname char(20) Unique,    --名字唯一
Ssex char(2),
Sage int,
Sdept char(20),
);

Create table Course
(
Cno char(9) primary key,  --列级完整性约束条件,Cno是主码
Cname char(40),
cpno char(4),
Credit int,
);

 
create table  SC
 (
 Sno char(9), 
 Cno char(9),  
 Grade int,
 primary key (Sno,Cno),                     --主码由两个属性构成，必须作为表级完整性进行定义
 foreign key (Sno) references Student(Sno),  --表级完整性约束条件，Sno是外码，被参照表是Student 
 foreign key (Cno) references Course(Cno)     --表级完整性约束条件， Cno是外码，被参照表是Course
 ); 
 /*
create table SysLog
(
UserID nchar(20),
dentify char(20),     /*学生或管理员*/
Dateandtime datetime,
UserOperation nchar(200),/*操作方式*/
);

create table SysLog1
(
UserID nchar(20),
dentify char(20),     /*学生或管理员*/
Dateandtime datetime,
UserOperation nchar(200),/*操作方式*/
);
*/
INSERT  INTO  StudentUser VALUES ('2023123','123456','张三','男');
INSERT  INTO  Administrator VALUES ('2023124','123456','张三','男');
INSERT  INTO  Administrator VALUES ('2023125','123456','张三','男');
 
 
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215121','李勇','男','CS',20);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215122','刘晨','女','CS',19);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215123','王敏','女','MA',18);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215125','张立','男','IS',19);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215128','陈冬','男','IS',20);
 
SELECT * FROM Student
 
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('1','数据库',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('2','数学',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('3','信息系统',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('4','操作系统',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('5','数据结构',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('6','数据处理',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('7','Pascal语言',NULL,4);
 
UPDATE Course SET Cpno = '5' WHERE Cno = '1' 
UPDATE Course SET Cpno = '1' WHERE Cno = '3' 
UPDATE Course SET Cpno = '6' WHERE Cno = '4' 
UPDATE Course SET Cpno = '7' WHERE Cno = '5' 
UPDATE Course SET Cpno = '6' WHERE Cno = '7' 
 
SELECT * FROM Course
 
INSERT  INTO SC(Sno,Cno,Grade) VALUES ('201215121 ','1',92);
INSERT  INTO SC(Sno,Cno,Grade) VALUES ('201215121 ','2',85);
INSERT  INTO SC(Sno,Cno,Grade) VALUES ('201215121 ','3',88);
INSERT  INTO SC(Sno,Cno,Grade) VALUES ('201215122 ','2',90);
INSERT  INTO SC(Sno,Cno,Grade) VALUES ('201215122 ','3',80);
 
SELECT * FROM SC
/*
--学生信息更新，内容存在注册日志
if( OBJECT_ID('regist_recorder1') is not null)
drop trigger regist_recorder1
go
create trigger regist_recorder1 on StudentUser
after insert as
declare @Username nchar(20)
declare @Datetime datetime
declare @UserOption nchar(200)
declare @dentity char(20)

select @Username = ID from StudentUser
select @Datetime = CONVERT(datetime,getdate(),120)
select @dentity = 'StudentUser'

declare @op varchar(10)
select @op=case when exists (select 1 from inserted) and exists(select 1 from deleted)
           then 'Update'
		   when exists (select 1 from inserted) and not exists(select 1 from deleted)
           then 'Insert'
		   when not exists (select 1 from inserted) and not exists(select 1 from deleted)
           then 'Delete' end
select @Username = @op
insert into SysLog(UserID,dentify,Dateandtime,UserOperation)
values(@Username,@dentity,@Datetime,@UserOption)

--管理员信息更新，内容存在注册日志
if( OBJECT_ID('regist_recorder2') is not null)
drop trigger regist_recorder2
go
create trigger regist_recorder2 on Administrator
after insert as
declare @Username nchar(20)
declare @Datetime datetime
declare @UserOption nchar(200)
declare @dentity char(20)

select @Username = ID from StudentUser
select @Datetime = CONVERT(datetime,getdate(),120)
select @dentity = 'Administration'

declare @op varchar(10)
select @op=case when exists (select 1 from inserted) and exists(select 1 from deleted)
           then 'Update'
		   when exists (select 1 from inserted) and not exists(select 1 from deleted)
           then 'Insert'
		   when not exists (select 1 from inserted) and not exists(select 1 from deleted)
           then 'Delete' end
select @Username = @op
insert into SysLog(UserID,dentify,Dateandtime,UserOperation)
values(@Username,@dentity,@Datetime,@UserOption)

*/
CREATE TABLE AVG1
	(
		Cname CHAR(10),   /* 科目*/	
		avg1 INT
	);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('数据库',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('数学',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('信息系统',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('操作系统',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('数据结构',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('数据处理',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('Pascal语言',NULL);
 /*
--将成绩信息通过下列存储过程算出各科平均分并存储至AVG表
if( OBJECT_ID('COURSE_AVG1') is not null)
drop PROCEDURE COURSE_AVG1
--IF (exists (select * from sys.objects where name = 'COURSE_AVG1'))
--	DROP PROCEDURE COURSE_AVG1
	GO
	CREATE  PROCEDURE COURSE_AVG1
	AS
	BEGIN TRANSACTION TRANS  
	DECLARE 
	    @SX INT,    /* 数学总分 */
	    @XXXT INT,    /* 信息系统总分 */
	    @CZXT INT,    /* 操作系统总分 */
		@SJJG INT,    /* 数据结构总分 */
		@SJK_C INT,   /* 数据库总分 */
		@SJCL INT,   /*数据处理总分*/
		@P INT       /*Pascal语言*/
	SELECT @SX=AVG(Grade) FROM SC
						WHERE  Cno='2 '
 
	SELECT @XXXT=AVG(Grade) FROM SC
						WHERE  Cno='3'
 
	SELECT @CZXT=AVG(Grade) FROM SC
						WHERE  Cno='4'
 
	SELECT @SJJG=AVG(Grade) FROM SC
						WHERE  Cno='5'
 
	SELECT @SJK_C=AVG(Grade) FROM SC
						WHERE  Cno='1'
	SELECT @SJCL=AVG(Grade) FROM SC
						WHERE  Cno='6'
	SELECT @P=AVG(Grade) FROM SC
						WHERE  Cno='7'
	
	BEGIN 
	UPDATE AVG1 SET avg1=@SJK_C WHERE Cname='数据库'
	UPDATE AVG1 SET avg1=@SX WHERE Cname='数学'
	UPDATE AVG1 SET avg1=@XXXT WHERE Cname='信息系统'
	UPDATE AVG1 SET avg1=@CZXT WHERE Cname='操作系统'
	UPDATE AVG1 SET avg1=@SJJG WHERE Cname='数据结构'
	UPDATE AVG1 SET avg1=@SJCL WHERE Cname='数据处理'
	UPDATE AVG1 SET avg1=@P WHERE Cname='Pascal语言'
	COMMIT TRANSACTION TRANS; 
	END
	*/

