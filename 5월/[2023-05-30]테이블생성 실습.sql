--#1. 테이블 생성, 행 추가
Create table Service_tb (
    Service_CD char(5) not null,
    Service_IDX varchar(50) not null,
    Constraint Service_tb_PK PRIMARY KEY (Service_CD),
);

Create table Customer_tb(
	Cust_ID char(4) not null,
	Service_CD char(5) not null,
	Region varchar(10) not null,
	Constraint Customer_PK PRIMARY KEY(Cust_ID, Service_CD),
	Constraint FK FOREIGN KEY(Service_CD) REFERENCES Service_tb(Service_CD)
);

drop table Service_tb;
drop table Customer_tb;



insert into Service_tb
values('A0001', '고객상담');
insert into Service_tb
values('A0002', '기술지원');
insert into Service_tb
values('A0003', '장애처리');


insert into Customer_tb
values('U211', 'A0001', '서울');
insert into Customer_tb
values('U314', 'A0001', '경기');
insert into Customer_tb
values('U416', 'A0002', '경기');
insert into Customer_tb
values('U533', 'A0003', '서울');

select * from Customer_tb;
select * from Service_tb;


--#2. 고객-서비스 테이블의 u211고객의 서비스 지역을 '대전'으로 수정
update Customer_tb
set Region = '대전'
where CUST_ID = 'U211'

select * from Customer_tb;

--#3. 고객-서비스 테이블에 [U577, A001, 인천] 행 추가
ALTER TABLE Customer_tb
DROP CONSTRAINT FK;

insert into Customer_tb
values('U577', 'A001', '인천');

--#4. 고객번호가 U314인 고객의 정보를 삭제하시오
delete from Customer_tb where CUST_ID = 'U314'

select * from Customer_tb