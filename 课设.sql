
USE MySchool;
DROP TABLE IF EXISTS SC       /*�ɼ�*/
DROP TABLE IF EXISTS Student  /*ѧ����Ϣ*/
DROP TABLE IF EXISTS Course   /*�γ�*/
DROP TABLE IF EXISTS StudentUser  /*ѧ���û���Ϣ*/
DROP TABLE IF EXISTS Administrator  /*����Ա�û���Ϣ*/
DROP TABLE IF EXISTS SysLog   /*ע����־*/
DROP TABLE IF EXISTS SysLog1   /*��½��־*/
DROP TABLE IF EXISTS AVG1   /*ƽ���ɼ�*/

Create table StudentUser  --ѧ��ע����Ϣ���
(ID nchar(20) primary key,
 PassWord nchar(32),
 Name nchar(20),
 Sex nchar(2),
 );

 Create table Administrator  --����Աע����Ϣ���
 (
 ID char(20) primary key,
 PassWord nchar(32),
 Name nchar(20),
 Sex char(2),
-- Birthday datetime ,
 --UserMobile nchar(11),
 );

Create table Student      --ѧ����Ϣ���
(
Sno char(9) primary key,  --�м�������Լ������,Sno������
Sname char(20) Unique,    --����Ψһ
Ssex char(2),
Sage int,
Sdept char(20),
);

Create table Course
(
Cno char(9) primary key,  --�м�������Լ������,Cno������
Cname char(40),
cpno char(4),
Credit int,
);

 
create table  SC
 (
 Sno char(9), 
 Cno char(9),  
 Grade int,
 primary key (Sno,Cno),                     --�������������Թ��ɣ�������Ϊ�������Խ��ж���
 foreign key (Sno) references Student(Sno),  --��������Լ��������Sno�����룬�����ձ���Student 
 foreign key (Cno) references Course(Cno)     --��������Լ�������� Cno�����룬�����ձ���Course
 ); 
 /*
create table SysLog
(
UserID nchar(20),
dentify char(20),     /*ѧ�������Ա*/
Dateandtime datetime,
UserOperation nchar(200),/*������ʽ*/
);

create table SysLog1
(
UserID nchar(20),
dentify char(20),     /*ѧ�������Ա*/
Dateandtime datetime,
UserOperation nchar(200),/*������ʽ*/
);
*/
INSERT  INTO  StudentUser VALUES ('2023123','123456','����','��');
INSERT  INTO  Administrator VALUES ('2023124','123456','����','��');
INSERT  INTO  Administrator VALUES ('2023125','123456','����','��');
 
 
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215121','����','��','CS',20);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215122','����','Ů','CS',19);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215123','����','Ů','MA',18);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215125','����','��','IS',19);
INSERT  INTO  Student (Sno,Sname,Ssex,Sdept,Sage) VALUES ('201215128','�¶�','��','IS',20);
 
SELECT * FROM Student
 
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('1','���ݿ�',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('2','��ѧ',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('3','��Ϣϵͳ',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('4','����ϵͳ',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('5','���ݽṹ',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('6','���ݴ���',NULL,4);
INSERT  INTO Course(Cno,Cname,Cpno,Credit)	VALUES ('7','Pascal����',NULL,4);
 
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
--ѧ����Ϣ���£����ݴ���ע����־
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

--����Ա��Ϣ���£����ݴ���ע����־
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
		Cname CHAR(10),   /* ��Ŀ*/	
		avg1 INT
	);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('���ݿ�',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('��ѧ',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('��Ϣϵͳ',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('����ϵͳ',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('���ݽṹ',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('���ݴ���',NULL);
INSERT  INTO AVG1(Cname,avg1)	VALUES ('Pascal����',NULL);
 /*
--���ɼ���Ϣͨ�����д洢�����������ƽ���ֲ��洢��AVG��
if( OBJECT_ID('COURSE_AVG1') is not null)
drop PROCEDURE COURSE_AVG1
--IF (exists (select * from sys.objects where name = 'COURSE_AVG1'))
--	DROP PROCEDURE COURSE_AVG1
	GO
	CREATE  PROCEDURE COURSE_AVG1
	AS
	BEGIN TRANSACTION TRANS  
	DECLARE 
	    @SX INT,    /* ��ѧ�ܷ� */
	    @XXXT INT,    /* ��Ϣϵͳ�ܷ� */
	    @CZXT INT,    /* ����ϵͳ�ܷ� */
		@SJJG INT,    /* ���ݽṹ�ܷ� */
		@SJK_C INT,   /* ���ݿ��ܷ� */
		@SJCL INT,   /*���ݴ����ܷ�*/
		@P INT       /*Pascal����*/
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
	UPDATE AVG1 SET avg1=@SJK_C WHERE Cname='���ݿ�'
	UPDATE AVG1 SET avg1=@SX WHERE Cname='��ѧ'
	UPDATE AVG1 SET avg1=@XXXT WHERE Cname='��Ϣϵͳ'
	UPDATE AVG1 SET avg1=@CZXT WHERE Cname='����ϵͳ'
	UPDATE AVG1 SET avg1=@SJJG WHERE Cname='���ݽṹ'
	UPDATE AVG1 SET avg1=@SJCL WHERE Cname='���ݴ���'
	UPDATE AVG1 SET avg1=@P WHERE Cname='Pascal����'
	COMMIT TRANSACTION TRANS; 
	END
	*/

