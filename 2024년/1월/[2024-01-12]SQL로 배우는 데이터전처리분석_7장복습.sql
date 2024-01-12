use mydata;
select Country, StockCode, count(distinct CustomerID) BU, sum(Quantity*UnitPrice) Sales
from dataset3
group by 1, 2
order by 3 desc, 4 desc;

select StockCode, sum(Quantity) QTY
from dataset3
group by StockCode;

select *,
row_number() over(order by QTY desc) RNK
from
(select StockCode, sum(Quantity) QTY
from dataset3
group by StockCode) A;

select StockCode
from
(select *,
row_number() over(order by QTY desc) RNK
from
(select StockCode, sum(Quantity) QTY
from dataset3
group by StockCode) A) A
where RNK between 1 and 2;

create table bu_list as
select CustomerID
from dataset3
group by 1
having max(case when StockCode = '84077' then 1 else 0 end) = 1
and max(case when StockCode = '85123A' then 1 else 0 end) = 1;

select distinct StockCode
from dataset3
where CustomerID in(select CustomerID from bu_list)
and StockCode not in('84077', '85123A');

select A.Country, substr(A.InvoiceDate, 1, 4) YY, count(distinct B.CustomerID)/count(distinct A.CustomerID) Retention_Rate
from (select distinct Country, InvoiceDate, CustomerID from dataset3) A
left join (select distinct Country, InvoiceDate, CustomerID from dataset3) B
on substr(A.InvoiceDate, 1, 4) = substr(B.InvoiceDate, 1, 4) - 1
and A.Country = B.Country
and A.CustomerID = B.CustomerID
group by 1, 2
order by 1, 2;

select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1;

select CustomerID, InvoiceDate, UnitPrice*Quantity Sales
from dataset3;

select *
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1) A
left join (select CustomerID, InvoiceDate, UnitPrice*Quantity Sales 
from dataset3) B
on A.CustomerID = B.CustomerID;

select substr(MNDT, 1, 7) MM, timestampdiff(month, MNDT, InvoiceDate) datediff,
count(distinct A.CustomerID) BU, sum(Sales) Sales
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1) A
left join (select CustomerID, InvoiceDate, UnitPrice*Quantity Sales 
from dataset3) B
on A.CustomerID = B.CustomerID
group by 1, 2;

select CustomerID, max(InvoiceDate) mxdt
from dataset3
group by 1;

select CustomerID, datediff('2011-12-02', mxdt) recency
from
(select CustomerID, max(InvoiceDate) mxdt
from dataset3
group by 1) A;

select CustomerID, count(distinct InvoiceNo) frequency,
sum(Quantity*UnitPrice) Monetary
from dataset3
group by 1;

select CustomerID, datediff('2011-12-02', mxdt) Recency, Frequency, Monetary
from
(select CustomerID, max(InvoiceDate) mxdt, count(distinct InvoiceNo) Frequency,
sum(Quantity*UnitPrice) Monetary
from dataset3
group by 1) A;

select CustomerID, StockCode, count(distinct substr(InvoiceDate, 1, 4)) unique_yy
from dataset3
group by 1, 2;

select CustomerID, max(unique_yy) mx_unique_yy
from
(select CustomerID, StockCode, count(distinct substr(InvoiceDate, 1, 4)) unique_yy
from dataset3
group by 1, 2) A
group by 1;

select CustomerID, case when mx_unique_yy >= 2 then 1 else 0 end repurchase_segment
from
(select CustomerID, max(unique_yy) mx_unique_yy
from
(select CustomerID, StockCode, count(distinct substr(invoiceDate, 1, 4)) unique_yy
from dataset3
group by 1, 2) A
group by 1) A
group by 1;

select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by CustomerID;

select MNDT, count(distinct CustomerID) BU
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by CustomerID) A
group by MNDT;

select CustomerID, StockCode, min(InvoiceDate) MNDT
from dataset3
group by CustomerID, StockCode;

select *,
row_number() over(partition by CustomerID order by MNDT) RNK
from
(select CustomerID, StockCode, min(InvoiceDate) MNDT
from dataset3
group by CustomerID, StockCode) A;

select *
from
(select *,
row_number() over(partition by CustomerID order by MNDT) RNK
from
(select CustomerID, StockCode, min(InvoiceDate) MNDT
from dataset3
group by CustomerID, StockCode) A) A
where RNK = 1;

select StockCode, count(distinct CustomerID) First_BU
from
(select *
from
(select *,
row_number() over(partition by CustomerID order by MNDT) RNK
from
(select CustomerID, StockCode, min(InvoiceDate) MNDT
from dataset3
group by CustomerID, StockCode) A) A
where RNK = 1) A
group by StockCode
order by 2 desc;

select CustomerID, count(distinct InvoiceDate) F_Date
from dataset3
group by 1;

select sum(case when F_Date = 1 then 1 else 0 end)/sum(1) Bounc_Rate
from
(select CustomerID, count(distinct InvoiceDate) F_Date
from dataset3
group by 1) A;

select Country, sum(case when F_Date = 1 then 1 else 0 end)/sum(1) Bounc_Rate
from
(select CustomerID, Country, count(distinct InvoiceDate) F_Date
from dataset3
group by 1, 2) A
group by 1
order by Country;

select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2011'
group by 1;

select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2010'
group by 1;

select *
from
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2011'
group by 1) A
left join
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2010'
group by 1) B
on A.StockCode = B.StockCode;

select A.StockCode, A.QTY, B.QTY, A.QTY/B.QTY - 1 QTY_Increase_Rate
from
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2011'
group by 1) A
left join
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2010'
group by 1) B
on A.StockCode = B.StockCode;

select *
from
(select A.StockCode, A.QTY QTY_2011, B.QTY QTY_2010, A.QTY/B.QTY - 1 QTY_Increase_Rate
from
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2011'
group by 1) A
left join
(select StockCode, sum(quantity) QTY
from dataset3
where substr(InvoiceDate, 1, 4) = '2010'
group by 1) B
on A.StockCode = B.StockCode) BASE
where QTY_Increase_Rate >= 1.2;

select weekofyear(InvoiceDate) WK, sum(Quantity*UnitPrice) Sales
from dataset3
where substr(InvoiceDate, 1, 4) = '2011'
group by 1
order by 1;

select case when substr(MNDT, 1, 4) = '2011' then 'New' else 'Ex1' end New_Ex1, CustomerID
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1) A;

select A.CustomerID, B.New_Ex1, A.InvoiceDate, A.UnitPrice, A.Quantity
from dataset3 A
left join
(select case when substr(MNDT, 1, 4) = '2011' then 'New' else 'Ex1' end New_Ex1, CustomerID
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1) A) B
on A.CustomerID = B.CustomerID
where substr(A.InvoiceDate, 1, 4) = '2011';

select B.New_Ex1, substr(A.InvoiceDate, 1, 7) MM, sum(A.UnitPrice*A.Quantity) Sales
from dataset3 A
left join
(select case when substr(MNDT, 1, 4) = '2011' then 'New' else 'Ex1' end New_Ex1, CustomerID
from
(select CustomerID, min(InvoiceDate) MNDT
from dataset3
group by 1) A) B
on A.CustomerID = B.CustomerID
where substr(A.InvoiceDate, 1, 4) = '2011'
group by 1, 2;

select CustomerID
from dataset3
group by 1
having min(substr(InvoiceDate, 1, 4)) = '2010';

select *
from dataset3
where CustomerID in
(select CustomerID
from dataset3
group by 1
having min(substr(InvoiceDate, 1, 4)) = '2010')
and substr(InvoiceDate, 1, 4) = '2011';

select CustomerID, substr(InvoiceDate, 1, 7) MM
from
(select * from dataset3
where CustomerID in
(select CustomerID
from dataset3
group by 1
having min(substr(InvoiceDate, 1, 4)) = '2010')
and substr(InvoiceDate, 1, 4) = '2011') A
group by 1;

select MM, count(CustomerID) N_Customers
from
(select CustomerID, substr(InvoiceDate, 1, 7) MM
from
(select *
from dataset3
where CustomerID in
(select CustomerID
from dataset3
group by 1
having min(substr(InvoiceDate, 1, 4)) = '2010')
and substr(InvoiceDate, 1, 4) = '2011') A
group by 1, 2) A
group by 1
order by 1;

select count(B.CustomerID)/count(A.CustomerID) Retention_Rate
from
(select distinct CustomerID
from dataset3
where substr(InvoiceDate, 1, 4) = '2010') A
left join
(select distinct CustomerID
from dataset3
where substr(InvoiceDate, 1, 4) = '2011') B
on A.CustomerID = B.CustomerID;

select sum(UnitPrice*Quantity)/count(distinct CustomerID) AMV
from dataset3
where substr(InvoiceDate, 1, 4) = '2011';

select count(distinct CustomerID) N_BU
from dataset3
where substr(InvoiceDate, 1, 4) = '2011';

select sum(UnitPrice*Quantity) Sales_2011
from dataset3
where substr(InvoiceDate, 1, 4) = '2011';










