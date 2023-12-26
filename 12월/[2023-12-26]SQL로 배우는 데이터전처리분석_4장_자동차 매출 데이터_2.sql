-- 재구매율 예시 코드
USE classicmodels
SELECT A.customerNumber, A.orderDate, B.customerNumber, B.orderDate
FROM orders A
LEFT JOIN orders B
ON A.customerNumber = B.customerNumber AND SUBSTR(A.orderDate, 1, 4) = SUBSTR(B.orderDate, 1, 4) -1;

-- 국가별 2004, 2005 재구매율
SELECT C.country, SUBSTR(A.orderDate, 1, 4) YY,
COUNT(DISTINCT A.customerNumber) BU_1,
COUNT(DISTINCT B.customerNumber) BU_2,
COUNT(DISTINCT B.customerNumber) / COUNT(DISTINCT A.customerNumber) Retention_Rate
FROM orders A
LEFT JOIN orders B
ON A.customerNumber = B.customerNumber AND SUBSTR(A.orderDate, 1, 4) = SUBSTR(B.orderDate, 1, 4) -1
LEFT JOIN customers C
ON A.customerNumber = C.customerNumber
GROUP BY 1, 2;

-- 미국의 연도별 Top5 차량 모델 추출
CREATE TABLE product_sales AS
SELECT D.productName, SUM(quantityOrdered * priceEach) Sales
FROM orders A
LEFT JOIN customers B
ON A.customerNumber = B.customerNumber
LEFT JOIN orderdetails c
ON A.orderNumber = C.orderNumber
LEFT JOIN products D
ON C.productCode = D.productCode
WHERE B.country = 'USA'
GROUP BY 1;

SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY Sales DESC) RNK
FROM product_sales) A
WHERE RNK <= 5
ORDER BY RNK;

-- order 테이블에서 마지막 구매일 확인
SELECT MAX(orderDate) MX_Order
FROM orders;

-- 각 고객의 마지막 구매일 구하기
SELECT customerNumber, MAX(orderDate) MX_Order
FROM orders
GROUP BY 1;

-- 2005-06-01 기준으로 며칠이 소요되었는지 계산, DATEDIFF() 이용
SELECT customerNumber, MX_Order, '2005-06-01', DATEDIFF('2005-06-01', MX_Order) DIFF
FROM
(SELECT customerNumber, MAX(orderDate) MX_Order
FROM orders
GROUP BY 1) BASE;

-- DIFF가 90일 이상인 경우를 Churn이라 가정
SELECT *,
CASE WHEN DIFF >= 90 THEN 'CHURN' ELSE 'NON-CHURN' END CHURN_TYPE
FROM
(SELECT customerNumber, MX_Order, '2005-06-01' END_POINT,
DATEDIFF('2005-06-01', MX_Order) DIFF
FROM
(SELECT customerNumber, MAX(orderDate) MX_Order
FROM orders
GROUP BY 1) BASE) BASE;

-- churn rate(%)
SELECT CASE WHEN DIFF >= 90 THEN 'CHURN' ELSE 'NON-CHURN' END CHURN_TYPE,
COUNT(DISTINCT customerNumber) N_CUS
FROM
(SELECT customerNumber, MX_Order, '2005-06-01' END_POINT,
DATEDIFF('2005-06-01', MX_Order) DIFF
FROM
(SELECT customerNumber, MAX(orderDate) MX_Order
FROM orders
GROUP BY 1) BASE) BASE
GROUP BY 1;

-- Churn고객이 어떤 카테고리 상품을 많이 구매했는지 파악하기 위해 Churn_list 테이블 생성
CREATE TABLE Churn_list AS
SELECT CASE WHEN DIFF >= 90 THEN 'CHURN' ELSE 'NON-CHURN' END CHURN_TYPE,
customerNumber
FROM
(SELECT customerNumber, MX_Order, '2005-06-01' END_Point,
DATEDIFF('2005-06-01', MX_Order) DIFF
FROM
(SELECT customerNumber, MAX(orderDate) MX_Order
FROM orders
GROUP BY 1) BASE) BASE;

-- productline별 구매자 수
SELECT C.productLine, COUNT(DISTINCT B.customerNumber) BU
FROM orderdetails A
LEFT JOIN orders B
ON A.orderNumber = B.orderNumber
LEFT JOIN products C
ON A.productCode = C.productCode
GROUP BY 1;

-- 위의 결과에 앞에서 생성한 Churn_list를 결합해 Churn Type으로 데이터를 분할
SELECT D.CHURN_TYPE, C.productline, COUNT(DISTINCT B.customerNumber) BU
FROM orderdetails A
LEFT JOIN orders B
ON A.orderNumber = B.orderNumber
LEFT JOIN products C
ON A.productCode = C.productCode
LEFT JOIN churn_list D
ON B.customerNumber = D.customerNumber
GROUP BY 1, 2
ORDER BY 1, 3 DESC;








