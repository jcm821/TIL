-- 요청사항: customers테이블을 이용해 국가, 도시별 고객 수를 구하시오
USE classicmodels
SELECT country, city, COUNT(customerNumber) as N_customers
FROM customers
GROUP BY country, city;

-- 요청사항: customers 테이블을 이용해 USA 거주자의 수를 계산하고, 그 비중을 구하시오
SELECT SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) N_USA,
SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) / COUNT(*) USA_Portion
FROM customers;

-- 요청사항: customers, orders테이블을 결합하고 ordernumber와 country를 출력하세요
SELECT O.ordernumber, C.country
FROM orders O
LEFT JOIN customers C
ON O.customerNumber = C.customerNumber;

-- 요청사항: customers, orders 테이블을 이용해 USA거주자의 주문 번호, 국가를 출력하세요
SELECT O.ordernumber, C.country
FROM orders O
INNER JOIN customers C
ON O.customerNumber = C.customerNumber
WHERE C.country = 'USA';

-- 요청사항: customers의 country칼럼을 이용해 북미(Canada, USA), 비북미를 출력하는 컬럼을 생성하세요
SELECT country, CASE WHEN country IN ('Canada', 'USA') THEN 'North America'
ELSE 'Others' END as region
FROM customers;

-- 요청사항: customers의 country칼럼을 이용해 북미(Canada, USA), 비북미를 출력하는 컬럼을 생성하고,
-- 북미, 비북미 거주 고객의 수를 계산하세요
SELECT CASE WHEN country IN ('Canada', 'USA') THEN 'North America'
ELSE 'Others' END as region,
COUNT(customerNumber) N_customers
FROM customers
GROUP BY CASE WHEN country IN ('Canada', 'USA') THEN 'North America'
ELSE 'Others' END;

-- GROUP BY컬럼명을 숫자로 대체
SELECT CASE WHEN country IN ('Canada', 'USA') THEN 'North America'
ELSE 'Others' END as region,
COUNT(customerNumber) N_customers
FROM customers
GROUP BY 1;

-- 요청사항: products 테이블에서 buyprice 컬럼으로 순위를 매겨주세요(오름차순, row_number, rank, dense_rank사용)
SELECT *,
ROW_NUMBER() OVER(ORDER BY buyprice) RowNumber,
RANK() OVER(ORDER BY buyprice) Rank,
DENSE_RANK() OVER(ORDER BY buyprice) Dense_Rank
FROM products;







