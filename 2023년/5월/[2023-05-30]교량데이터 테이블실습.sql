--교량명 테이블 생성
Create table BRIDGE_NM(
	Bridge_id char(4) not null,
	Bridge_nm varchar(50) not null,
	Constraint BRIDGE_NM_PK PRIMARY KEY(Bridge_id)
);

--교량위치코드 테이블 생성
Create table BRIDGE_PL(
	Bridge_pl char(5) not null,
	sido varchar(10) not null,
	sgg varchar(10) not null,
	Constraint BRIDGE_PL_PK PRIMARY KEY(Bridge_pl)
);

--담당자 테이블 생성
Create table WORKER(
	Worker_id char(5) not null,
	Worker_nm varchar(10) not null,
	Worker_idx char(4) not null,
	Constraint WORKER_PK PRIMARY KEY(Worker_id)
);


--점검이력 테이블 생성
Create table CHECK_tb(
	Check_time date not null,
	Bridge_id char(4) not null,
	Worker_id char(5) not null,
	Safe_grade char(1) not null,
	faulty varchar(50),
	Constraint CHECK_tb_PK PRIMARY KEY(Check_time, Bridge_id),
	--Constraint FK FOREIGN KEY(Worker_id) REFERENCES WORKER(Worker_id)
);

--교량 테이블 생성
Create table BRIDGE(
	Bridge_id char(4) not null,
	Bridge_pl char(5) not null,
	Passed_year int not null,
	Check_time date not null,
	Safe_grade char(1) not null,
	Constraint BRIDGE_PK PRIMARY KEY(Bridge_id),
	Constraint FK FOREIGN KEY(Bridge_pl) REFERENCES BRIDGE_PL(Bridge_pl)
);

select * from BRIDGE_NM
select * from BRIDGE_PL
select * from WORKER
select * from CHECK_tb
select * from BRIDGE

--교량명 테이블에 행 추가
insert into BRIDGE_NM
values ('S001', '홍제교');
insert into BRIDGE_NM
values ('K001', '연무교');
insert into BRIDGE_NM
values ('S002', '올림픽대교');
insert into BRIDGE_NM
values ('K002', '진위교');
insert into BRIDGE_NM
values ('S003', '석천교');

--교량위치 테이블에 행 추가
insert into BRIDGE_PL
values (11100, '서울', '서대문구');
insert into BRIDGE_PL
values (41000, '경기도', '성남시');
insert into BRIDGE_PL
values (11105, '서울', '광진구');
insert into BRIDGE_PL
values (41001, '경기도', '평택시');
insert into BRIDGE_PL
values (11103, '서울', '영등포구');

--담당자 테이블에 행 추가
insert into WORKER
values ('DS001', '김민지', 'B001');
insert into WORKER
values ('DK002', '김멀티', 'B002');
insert into WORKER
values ('DS003', '김세종', 'B001');

--점검이력 테이블에 행 추가
insert into CHECK_tb
values ('2018-12-31', 'K002', 'DK002','B', NULL);
insert into CHECK_tb
values ('2018-12-31', 'S001', 'DS003','A', NULL);
insert into CHECK_tb
values ('2019-12-27', 'K001', 'DK002','D', '콘크리트 균열');
insert into CHECK_tb
values ('2021-05-31', 'S002', 'DS001','B', '기둥 스크래치');
insert into CHECK_tb
values ('2021-11-16', 'S001', 'DS001','C', '볼트 깨짐');

--교량 테이블에 행 추가
insert into BRIDGE
values ('S001', 11100, 43, '2021-11-16', 'C');
insert into BRIDGE
values ('K001', 41000, 33, '2021-11-16', 'D');
insert into BRIDGE
values ('S002', 41000, 33, '2021-11-16', 'B');
insert into BRIDGE
values ('K002', 41000, 37, '2021-11-16', 'B');
insert into BRIDGE
values ('S003', 11100, 16, '2021-11-16', 'A');


select * from BRIDGE_NM
select * from BRIDGE_PL
select * from WORKER
select * from CHECK_tb
select * from BRIDGE


-- 외래키 시도를 위한 삭제구문
ALTER TABLE CHECK_tb
DROP CONSTRAINT FK;

ALTER TABLE BRIDGE
DROP CONSTRAINT FK;


drop table BRIDGE_NM;
drop table BRIDGE_PL;
drop table WORKER;
drop table CHECK_tb;
drop table BRIDGE;