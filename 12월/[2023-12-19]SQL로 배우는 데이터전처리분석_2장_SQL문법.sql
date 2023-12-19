-- SQL문법
-- 요청사항: classicmodels.customers의 customerNumber를 조회하세요
USE classicmodels
SELECT customerNumber FROM customers;

-- 요청사항: 상품 개수도 조회가능할까요?
SELECT COUNT(productCode) FROM products;

-- 요청사항: classicmodels.payments의 amount의 총합과 checknumber 개수를 구하시오
SELECT SUM(amount), COUNT(checknumber)
FROM payments;

-- 요청사항: classicmodels.products의 productName, productLine을 조회하세요
SELECT productName, productLine
FROM products;

-- 요청사항: products의 productCode의 개수를 구하고, 컬럼 명을 n_products로 변경하세요
SELECT COUNT(productCode) as n_products
FROM products;

-- 요청사항: orderdetails의 ordernumber의 중복을 제거하고 조회하세요
SELECT DISTINCT ordernumber
FROM orderdetails;

-- 요청사항: orderdetails의 priceeach가 30에서 50사이인 데이터를 조회하시오
SELECT *
FROM orderdetails
WHERE priceeach BETWEEN 30 AND 50;

-- 요청사항: orderdetails의 priceeach가 30이상인 데이터를 조회하세요
SELECT *
FROM orderdetails
WHERE priceeach >= 30;

-- 요청사항: customers의 country가 USA 또는 Canada인 customernumber를 조회하세요
SELECT customernumber
FROM customers
WHERE country IN ('USA', 'Canada');

-- 요청사항: customers의 country가 USA, Canada가 아닌 customernumber를 조회하세요
SELECT customernumber
FROM customers
WHERE country NOT IN ('USA', 'Canada');

-- 요청사항: employees의 reportsTo 값이 NULL인 employeenumber를 조회하세요
SELECT employeenumber
FROM employees
WHERE reportsTo IS NULL;

-- 요청사항: customers의 addressline1에 ST가 포함된 addressline1을 출력하세요
SELECT addressline1
FROM customers
WHERE addressline1 LIKE '%ST%';










