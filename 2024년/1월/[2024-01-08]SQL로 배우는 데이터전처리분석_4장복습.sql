USE classicmodels;
select A.orderDate, priceEach*quantityOrdered
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber;

select A.orderDate, sum(priceEach*quantityOrdered)
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1;

select substr(A.orderDate,1,7) MM, sum(priceEach*quantityOrdered)
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1
order by 1;

select substr(A.orderDate,1,4) YY, sum(priceEach*quantityOrdered)
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1
order by 1;

select orderDate, customerNumber, orderNumber
from orders;

select count(orderNumber) N_orders, count(distinct orderNumber) N_orders_distinct
from orders;

select orderDate, count(distinct customerNumber) N_purchase, count(orderNumber) N_orders
from orders
group by 1
order by 1;

select substr(orderDate, 1, 7) MM, count(distinct customerNumber) N_purchase, count(orderNumber) N_orders
from orders
group by 1
order by 1;


select substr(orderDate, 1, 4) YY, count(distinct customerNumber) N_purchase, count(orderNumber) N_orders
from orders
group by 1
order by 1;

select substr(A.orderDate, 1, 4) YY, count(distinct A.customerNumber) N_Purchaser,
sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1
order by 1;

select substr(A.orderDate, 1, 4) YY, count(distinct A.customerNumber) N_Purchaser,
sum(priceEach*quantityOrdered) as Sales,
sum(priceEach*quantityOrdered)/count(distinct A.customerNumber) AMV
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1
order by 1;

select substr(A.orderDate, 1, 4) YY, count(distinct A.customerNumber) N_Purchaser,
sum(priceEach*quantityOrdered) as Sales,
sum(priceEach*quantityOrdered)/count(distinct A.orderNumber) ATV
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
group by 1
order by 1;

select *
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber;

select C.country, C.city, priceEach*quantityOrdered
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber;

select C.country, C.city, sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1, 2;

select C.country, C.city, sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1, 2
order by 1, 2;

select case when country in('USA', 'Canada') then 'North America' else 'Others' end Country_GRP
from customers;

select C.country, C.city, sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1, 2
order by 3 desc;

select case when country in('USA', 'Canada') then 'North America' else 'Others' end Country_GRP,
sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1
order by 2 desc;

create table stat as
select C.country, sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1
order by 2 desc;

select * from stat;

select country, Sales,
dense_rank() over(order by Sales desc) RNK
from stat;

create table stat_rnk as
select country, Sales,
dense_rank() over(order by Sales desc) RNK
from stat;

select * from stat_rnk;

select * from stat_rnk
where RNK between 1 and 5;

select *
from
(select country, Sales,
dense_rank() over(order by Sales desc) RNK
from
(select C.country, sum(priceEach*quantityOrdered) as Sales
from orders A
left join orderdetails B
on A.orderNumber = B.orderNumber
left join customers C
on A.customerNumber = C.customerNumber
group by 1) A) A
where RNK <= 5;

select A.customerNumber, A.orderDate, B.customerNumber, B.orderDate
from orders A
left join orders B
on A.customerNumber = B.customerNumber and substr(A.orderDate,1,4) = substr(B.orderDate,1,4)-1;

select C.country, substr(A.orderDate,1,4) YY,
count(distinct A.customerNumber) BU_1, count(distinct B.customerNumber) BU_2,
count(distinct B.customerNumber)/count(distinct A.customerNumber) Retention_Rate
from orders A
left join orders B
on A.customerNumber = B.customerNumber and substr(A.orderDate,1,4) = substr(B.orderDate,1,4)-1
left join customers C
on A.customerNumber = C.customerNumber
group by 1, 2;

create table product_sales as
select D.productName, sum(quantityordered*priceEach) Sales
from orders A
left join customers B
on A.customerNumber = B.customerNumber
left join orderdetails C
on A.orderNumber = C.orderNumber
left join products D
on C.productCode = D.productCode
where B.country = 'USA'
group by 1;

select *
from
(select *,
row_number() over(order by Sales desc) RNK
from product_sales) A
where RNK <= 5
order by RNK;

select max(orderDate) MX_Order
from orders;

select customerNumber, max(orderDate) MX_Order
from orders
group by 1;

select customerNumber, MX_Order, '2005-06-01',
datediff('2005-06-01', MX_Order) DIFF
from
(select customerNumber, max(orderDate) MX_Order
from orders
group by 1) base;

select *,
case when DIFF >= 90 then 'Churn' else 'Non-Churn' end Churn_Type
from
(select customerNumber, MX_Order, '2005-06-01',
datediff('2005-06-01', MX_Order) DIFF
from
(select customerNumber, max(orderDate) MX_Order
from orders
group by 1) base) base;

select case when DIFF >= 90 then 'Churn' else 'Non-Churn' end Churn_Type,
count(distinct customerNumber) N_Cus
from
(select customerNumber, MX_Order, '2005-06-01',
datediff('2005-06-01', MX_Order) DIFF
from
(select customerNumber, max(orderDate) MX_Order
from orders
group by 1) base) base
group by 1;

create table churn_list as
select case when DIFF >= 90 then 'Churn' else 'Non-Churn' end Churn_Type,
customerNumber
from
(select customerNumber, MX_Order, '2005-06-01',
datediff('2005-06-01', MX_Order) DIFF
from
(select customerNumber, max(orderDate) MX_Order
from orders
group by 1) base) base;

select C.productLine, count(distinct B.customerNumber) BU
from orderdetails A
left join orders B
on A.orderNumber = B.orderNumber
left join products C
on A.productCode = C.productCode
group by 1;

select D.Churn_Type, C.productLine, count(distinct B.customerNumber) BU
from orderdetails A
left join orders B
on A.orderNumber = B.orderNumber
left join products C
on A.productCode = C.productCode
left join churn_list D
on B.customerNumber = D.customerNumber
group by 1,2
order by 1,3 desc;





















