-- 테이블 결합 후, 일별 매출액을 조회
USE classicmodels
SELECT A.orderDate, (priceEach * quantityOrdered) as totalPrice
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
;

-- orderdate로 그루핑한 뒤 매출액의 합을 집계하여 일별 매출액 계산
SELECT A.orderDate, SUM(priceEach * quantityOrdered) as Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY A.orderDate
ORDER BY 1
;

-- SUBSTR()을 이용해 월별 매출을 구하는 방법
SELECT SUBSTR(A.orderDate, 1, 7) MM, SUM(priceEach * quantityOrdered) as Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY SUBSTR(A.orderDate, 1, 7)
ORDER BY 1
;

-- 연도별 매출액
SELECT SUBSTR(A.orderDate, 1, 4) YY, SUM(priceEach * quantityOrdered) as Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY 1
ORDER BY 1
;


-- 판매일로 그루핑한 후 고객 번호를 COUNT
SELECT orderDate, customerNumber, orderNumber
FROM orders;

-- 데이터의 구조를 파악하지 못한 상태에서 분석을 시작해야 하는 경우, 컬럼에 중복된 값이 있는지 확인
SELECT COUNT(orderNumber) N_Orders, COUNT(DISTINCT orderNumber) N_Orders_Distinct
FROM orders;

--  PK로 중복을 허용하지 않는지 확인
SELECT orderDate, COUNT(DISTINCT customerNumber) N_Purchaser, COUNT(orderNumber) N_Orders
FROM orders
GROUP BY 1
ORDER BY 1;

-- 월별 구매자 수, 구매 건수
SELECT SUBSTR(orderDate, 1, 7) MM, COUNT(DISTINCT customerNumber) N_Purchaser, COUNT(orderNumber) N_Orders
FROM orders
GROUP BY 1
ORDER BY 1;

-- 연도별 구매자 수, 구매 건수
SELECT SUBSTR(orderDate, 1, 4) YY, COUNT(DISTINCT customerNumber) N_Purchaser, COUNT(orderNumber) N_Orders
FROM orders
GROUP BY 1
ORDER BY 1;

-- 연도별 매출액과 구매자 수 구하기
SELECT SUBSTR(A.orderDate, 1, 4) YY, COUNT(DISTINCT A.customerNumber) N_Purchaser, SUM(priceEach * quantityOrdered) as Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY 1
ORDER BY 1;

-- 평균 인당 매출액 추가하기(AMV)
SELECT SUBSTR(A.orderDate, 1, 4) YY, COUNT(DISTINCT A.customerNumber) N_Purchaser, SUM(priceEach * quantityOrdered) as Sales,
SUM(priceEach * quantityOrdered)/COUNT(DISTINCT A.customerNumber) AMV
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY 1
ORDER BY 1;

-- 건당 구매 금액(ATV)
SELECT SUBSTR(A.orderDate, 1, 4) YY, COUNT(DISTINCT A.customerNumber) N_Purchaser, SUM(priceEach * quantityOrdered) as Sales,
SUM(priceEach * quantityOrdered)/COUNT(DISTINCT A.orderNumber) ATV
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
GROUP BY 1
ORDER BY 1;

-- orders, customers, orderdetails 3가지 테이블을 결합
SELECT * FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber;


-- country, city, priceEach * quantityOrdered만 조회
SELECT C.country, C.city, priceEach * quantityOrdered FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber;

-- country, city로 그루핑한 뒤 매출액을 합하기
SELECT C.country, C.city, SUM(priceEach * quantityOrdered) Sales FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1, 2;

-- 그루핑 후 country, city로 정렬
SELECT C.country, C.city, SUM(priceEach * quantityOrdered) Sales FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1, 2
ORDER BY 1, 2;

-- case when구문 사용하여 북미,비북미 구분
SELECT CASE WHEN country IN('USA', 'Canada') THEN 'North America' ELSE 'Ohers' END Country_GRP
FROM customers;

-- 국가별, 도시별 매출액
SELECT C.country, C.city, SUM(priceEach * quantityOrdered) Sales FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 북미, 비북미 매출액
SELECT CASE WHEN country IN('USA', 'Canada') THEN 'North America' ELSE 'Ohers' END Country_GRP,
SUM(priceEach * quantityOrdered) Sales FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1
ORDER BY 2 DESC;

-- 새로운 테이블 생성 후 rank를 이용하여 매출Top 5국가 산출
CREATE TABLE stat as
SELECT C.country, SUM(priceEach * quantityOrdered) Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1
ORDER BY 2 DESC;

-- stat테이블 조회
SELECT * FROM stat;

-- DENSE_RANK를 이용하여 매출액 등수를 확인
SELECT country, sales,
DENSE_RANK() OVER(ORDER BY sales DESC) RNK
FROM stat;

CREATE TABLE stat_rnk AS
SELECT country, sales,
DENSE_RANK() OVER(ORDER BY sales DESC) RNK
FROM stat;
SELECT * FROM stat_rnk;

-- 상위 5개 국가를 추출
SELECT * FROM stat_rnk
WHERE RNK BETWEEN 1 AND 5;

-- 서브쿼리를 사용하여 데이터 조회
SELECT * FROM
(SELECT country, sales,
DENSE_RANK() OVER(ORDER BY sales DESC) RNK
FROM
(SELECT C.country, SUM(priceEach * quantityOrdered) Sales
FROM orders A
LEFT JOIN orderdetails B
ON A.orderNumber = B.orderNumber
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1) A) A
WHERE RNK <=5;



