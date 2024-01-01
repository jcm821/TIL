--STUDENT 테이블 생성
Create table STUDENT(
	Sno int not null,
	SName varchar(50) not null,
	Year char(1) not null,
	Dept varchar(50),
	Addr varchar(10),
	Constraint Student_PK PRIMARY KEY(Sno)
);

--GRADE 테이블 생성
Create table GRADE(
Sno int not null
, Cno char(5) not null
, Cname varchar(50) not null
, Grade char(2) not null
, Score int not null
, Constraint GRADE_PK PRIMARY KEY(Sno, Cno)
, Constraint FK FOREIGN KEY(Sno) REFERENCES STUDENT(Sno)
);

--조회하게 되면 빈 테이블이라 컬럼명만 출력이 된다
select * from STUDENT;
select * from GRADE;

--행 삽입(STUDENT)
insert into STUDENT
values('2001', '홍길동', '1', '컴퓨터', '서울');
insert into STUDENT
values('2002', '김철수', '1', '토목', '경기');
insert into STUDENT
values('2003', '양성희', '2', '전자', '경기');
insert into STUDENT
values('2004', '최수훈', '2', '디자인', '경기');
insert into STUDENT
values('2005', '송호근', '3', '전자', '서울');

--행 삽입(GRADE)
insert into GRADE
values('2001', 'A1000', '자료구조', 'A', '91');
insert into GRADE
values('2002', 'A2000', '데이터베이스', 'A+', '99');
insert into GRADE
values('2003', 'A1000', '자료구조', 'B+', '88');
insert into GRADE
values('2003', 'A2000', '데이터베이스', 'B', '85');
insert into GRADE
values('2004', 'A2000', '데이터베이스', 'A', '94');
insert into GRADE
values('2004', 'A3000', '운영체제', 'B+', '89');
insert into GRADE
values('2005', 'A3000', '운영체제', 'B', '88');

--다시 조회
select * from STUDENT;
select * from GRADE;


--갱신
update STUDENT
set Dept = '데이터엔지니어링'
where Sno = '2004'

--행 삭제
delete from GRADE where Sno = '2004'

--테이블 삭제
--drop table GRADE;
--drop table STUDENT;


--inner join: 테이블 간 컬럼값들이 정확하게 일치하는 경우 사용
--방법1
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT, GRADE
where STUDENT.Sno = GRADE.Sno;

--방법2
select STUDENT.Sno, GRADE.Cno, GRADE.Cname
from STUDENT inner join GRADE
on STUDENT.Sno = GRADE.Sno;

--3개 이상의 테이블 조인
--새로운 테이블 XXX 생성
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

--3개 이상의 테이블 조인
select * from STUDENT, GRADE, XXX
where STUDENT.Sno = GRADE.Sno and GRADE.Cno = XXX.Cno;

--outer join
ALTER TABLE Grade
DROP CONSTRAINT FK;

insert into STUDENT
values('2000', '허민수', '1', '컴퓨터', '서울');
insert into STUDENT
values('2007', '이근수', '1', '토목', '경기');

insert into GRADE
values('2008', 'A1000', '자료구조', 'A', '93');
insert into GRADE
values('2009', 'A2000', '데이터베이스', 'A', '94');


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

--서브 쿼리
select S.Sno, G.Sno, G.Cname
from (select GRADE.Sno, GRADE.Cno, GRADE.Cname from GRADE where Cname = '자료구조')G, STUDENT S
where S.Sno = G.Sno;

--위의 식을 간단하게 작성하면 다음과 같다
select S.Sno, G.Sno, G.Cname
from STUDENT S, GRADE G
where S.Sno = G.Sno;