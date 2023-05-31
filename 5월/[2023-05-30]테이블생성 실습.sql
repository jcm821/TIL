--#1. ���̺� ����, �� �߰�
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
values('A0001', '�����');
insert into Service_tb
values('A0002', '�������');
insert into Service_tb
values('A0003', '���ó��');


insert into Customer_tb
values('U211', 'A0001', '����');
insert into Customer_tb
values('U314', 'A0001', '���');
insert into Customer_tb
values('U416', 'A0002', '���');
insert into Customer_tb
values('U533', 'A0003', '����');

select * from Customer_tb;
select * from Service_tb;


--#2. ��-���� ���̺��� u211���� ���� ������ '����'���� ����
update Customer_tb
set Region = '����'
where CUST_ID = 'U211'

select * from Customer_tb;

--#3. ��-���� ���̺� [U577, A001, ��õ] �� �߰�
ALTER TABLE Customer_tb
DROP CONSTRAINT FK;

insert into Customer_tb
values('U577', 'A001', '��õ');

--#4. ����ȣ�� U314�� ���� ������ �����Ͻÿ�
delete from Customer_tb where CUST_ID = 'U314'

select * from Customer_tb