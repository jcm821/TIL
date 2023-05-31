--������ ���̺� ����
Create table BRIDGE_NM(
	Bridge_id char(4) not null,
	Bridge_nm varchar(50) not null,
	Constraint BRIDGE_NM_PK PRIMARY KEY(Bridge_id)
);

--������ġ�ڵ� ���̺� ����
Create table BRIDGE_PL(
	Bridge_pl char(5) not null,
	sido varchar(10) not null,
	sgg varchar(10) not null,
	Constraint BRIDGE_PL_PK PRIMARY KEY(Bridge_pl)
);

--����� ���̺� ����
Create table WORKER(
	Worker_id char(5) not null,
	Worker_nm varchar(10) not null,
	Worker_idx char(4) not null,
	Constraint WORKER_PK PRIMARY KEY(Worker_id)
);


--�����̷� ���̺� ����
Create table CHECK_tb(
	Check_time date not null,
	Bridge_id char(4) not null,
	Worker_id char(5) not null,
	Safe_grade char(1) not null,
	faulty varchar(50),
	Constraint CHECK_tb_PK PRIMARY KEY(Check_time, Bridge_id),
	--Constraint FK FOREIGN KEY(Worker_id) REFERENCES WORKER(Worker_id)
);

--���� ���̺� ����
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

--������ ���̺� �� �߰�
insert into BRIDGE_NM
values ('S001', 'ȫ����');
insert into BRIDGE_NM
values ('K001', '������');
insert into BRIDGE_NM
values ('S002', '�ø��ȴ뱳');
insert into BRIDGE_NM
values ('K002', '������');
insert into BRIDGE_NM
values ('S003', '��õ��');

--������ġ ���̺� �� �߰�
insert into BRIDGE_PL
values (11100, '����', '���빮��');
insert into BRIDGE_PL
values (41000, '��⵵', '������');
insert into BRIDGE_PL
values (11105, '����', '������');
insert into BRIDGE_PL
values (41001, '��⵵', '���ý�');
insert into BRIDGE_PL
values (11103, '����', '��������');

--����� ���̺� �� �߰�
insert into WORKER
values ('DS001', '�����', 'B001');
insert into WORKER
values ('DK002', '���Ƽ', 'B002');
insert into WORKER
values ('DS003', '�輼��', 'B001');

--�����̷� ���̺� �� �߰�
insert into CHECK_tb
values ('2018-12-31', 'K002', 'DK002','B', NULL);
insert into CHECK_tb
values ('2018-12-31', 'S001', 'DS003','A', NULL);
insert into CHECK_tb
values ('2019-12-27', 'K001', 'DK002','D', '��ũ��Ʈ �տ�');
insert into CHECK_tb
values ('2021-05-31', 'S002', 'DS001','B', '��� ��ũ��ġ');
insert into CHECK_tb
values ('2021-11-16', 'S001', 'DS001','C', '��Ʈ ����');

--���� ���̺� �� �߰�
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


-- �ܷ�Ű �õ��� ���� ��������
ALTER TABLE CHECK_tb
DROP CONSTRAINT FK;

ALTER TABLE BRIDGE
DROP CONSTRAINT FK;


drop table BRIDGE_NM;
drop table BRIDGE_PL;
drop table WORKER;
drop table CHECK_tb;
drop table BRIDGE;