--STUDENT ���̺� ����
Create table STUDENT(
	Sno int not null,
	SName varchar(50) not null,
	Year char(1) not null,
	Dept varchar(50),
	Addr varchar(10),
	Constraint Student_PK PRIMARY KEY(Sno)
);

--GRADE ���̺� ����
Create table GRADE(
Sno int not null
, Cno char(5) not null
, Cname varchar(50) not null
, Grade char(2) not null
, Score int not null
, Constraint GRADE_PK PRIMARY KEY(Sno, Cno)
, Constraint FK FOREIGN KEY(Sno) REFERENCES STUDENT(Sno)
);

--��ȸ�ϰ� �Ǹ� �� ���̺��̶� �÷��� ����� �ȴ�
select * from STUDENT;
select * from GRADE;

--�� ����(STUDENT)
insert into STUDENT
values('2001', 'ȫ�浿', '1', '��ǻ��', '����');
insert into STUDENT
values('2002', '��ö��', '1', '���', '���');
insert into STUDENT
values('2003', '�缺��', '2', '����', '���');
insert into STUDENT
values('2004', '�ּ���', '2', '������', '���');
insert into STUDENT
values('2005', '��ȣ��', '3', '����', '����');

--�� ����(GRADE)
insert into GRADE
values('2001', 'A1000', '�ڷᱸ��', 'A', '91');
insert into GRADE
values('2002', 'A2000', '�����ͺ��̽�', 'A+', '99');
insert into GRADE
values('2003', 'A1000', '�ڷᱸ��', 'B+', '88');
insert into GRADE
values('2003', 'A2000', '�����ͺ��̽�', 'B', '85');
insert into GRADE
values('2004', 'A2000', '�����ͺ��̽�', 'A', '94');
insert into GRADE
values('2004', 'A3000', '�ü��', 'B+', '89');
insert into GRADE
values('2005', 'A3000', '�ü��', 'B', '88');

--�ٽ� ��ȸ
select * from STUDENT;
select * from GRADE;


--����
update STUDENT
set Dept = '�����Ϳ����Ͼ'
where Sno = '2004'

--�� ����
delete from GRADE where Sno = '2004'

--���̺� ����
--drop table GRADE;
--drop table STUDENT;


--inner join: ���̺� �� �÷������� ��Ȯ�ϰ� ��ġ�ϴ� ��� ���
--���1
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT, GRADE
where STUDENT.Sno = GRADE.Sno;

--���2
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT inner join GRADE
on STUDENT.Sno = GRADE.Sno;

--3�� �̻��� ���̺� ����
--���ο� ���̺� XXX ����
create table XXX(
	Cno char(5) not null,
	xxx varchar(50) not null,
	Constraint XXX_PK PRIMARY KEY(Cno)
);

insert into XXX
values('A1000', 'XX1')
insert into XXX
values('A2000', 'XX2')

select * from XXX;

--3�� �̻��� ���̺� ����
select * from STUDENT, GRADE, XXX
where STUDENT.Sno = GRADE.Sno and GRADE.Cno = XXX.Cno;

--outer join
ALTER TABLE Grade
DROP CONSTRAINT FK;

insert into STUDENT
values('2000', '��μ�', '1', '��ǻ��', '����');
insert into STUDENT
values('2007', '�̱ټ�', '1', '���', '���');

insert into GRADE
values('2008', 'A1000', '�ڷᱸ��', 'A', '93');
insert into GRADE
values('2009', 'A2000', '�����ͺ��̽�', 'A', '94');


--left outer join
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT left outer join GRADE
on STUDENT.Sno = GRADE.Sno;

--right outer join
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT right outer join GRADE
on STUDENT.Sno = GRADE.Sno;

--full outer join
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT full outer join GRADE
on STUDENT.Sno = GRADE.Sno;

--���� ����
select S.Sno, G.Sno, G.Cname
from (select GRADE.Sno, GRADE.Cno, GRADE.Cname from GRADE where Cname = '�ڷᱸ��')G, STUDENT S
where S.Sno = G.Sno;

--���� ���� �����ϰ� �ۼ��ϸ� ������ ����
select S.Sno, G.Sno, G.Cname
from STUDENT S, GRADE G
where S.Sno = G.Sno;