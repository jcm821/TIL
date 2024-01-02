USE mydata;
-- 국가별, 상품별 구매자 수 및 매출액
SELECT Country, StockCode, COUNT(DISTINCT CustomerID) BU,
SUM(Quantity * UnitPrice) Sales
FROM dataset3
GROUP BY 1, 2
ORDER BY 3 DESC, 4 DESC;

-- 상품별로 판매된 개수
SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
GROUP BY 1;

-- 상품 수 기준으로 랭크를 생성
SELECT *,
ROW_NUMBER() OVER(ORDER BY QTY DESC) RNK
FROM
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
GROUP BY 1) A;

-- 랭크가 1, 2인 데이터를 조회
SELECT StockCode
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY QTY DESC) RNK
FROM
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
GROUP BY 1) A) A
WHERE RNK BETWEEN 1 AND 2;

-- 2개 상품을 모두 구매한 고객이 구매한 상품별 주문 건수 계산
CREATE TABLE BU_List AS
SELECT CustomerID
FROM dataset3
GROUP BY 1
HAVING MAX(CASE WHEN StockCode = '84077' THEN 1 ELSE 0 END) = 1
AND MAX(CASE WHEN StockCode = '85123A' THEN 1 ELSE 0 END) = 1;

-- 해당 고객들이 구매한 상품 출력
SELECT DISTINCT StockCode
FROM dataset3
WHERE CustomerID IN(SELECT CustomerID FROM BU_List)
AND StockCode NOT IN ('84077', '85123A');

-- 국가별 재구매율 계산
SELECT A.Country, SUBSTR(A.InvoiceDate, 1, 4) YY, COUNT(DISTINCT B.CustomerID)/COUNT(DISTINCT A.CustomerID) Retention_Rate
FROM
(SELECT DISTINCT Country, InvoiceDate, CustomerID FROM dataset3) A
LEFT JOIN (SELECT DISTINCT Country, InvoiceDate, CustomerID
FROM dataset3) B
ON SUBSTR(A.InvoiceDate, 1, 4) = SUBSTR(B.InvoiceDate, 1, 4) -1
AND A.Country = B.Country
AND A.CustomerID = B.CustomerID
GROUP BY 1, 2
ORDER BY 1, 2;

-- 고객별로 첫 구매일 조회
SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1;

-- 각 고객의 주문 일자, 구매액 조회
SELECT CustomerID, InvoiceDate, UnitPrice*Quantity Sales
FROM dataset3;

-- 첫 번째로 구매했던 고객별 첫 구매일 테이블에 고객의 구매 내역 join
SELECT *
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1) A
LEFT JOIN
(SELECT CustomerID, InvoiceDate, UnitPrice*Quantity Sales
FROM dataset3) B
ON A.CustomerID = B.CustomerID;

-- 분석을 위한 데이터 컬럼 계산
SELECT SUBSTR(MNDT, 1, 7) MM, TIMESTAMPDIFF(MONTH, MNDT, InvoiceDate) DATEDIFF,
COUNT(DISTINCT A.CustomerID) BU, SUM(Sales) Sales
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1) A
LEFT JOIN
(SELECT CustomerID, InvoiceDate, UnitPrice*Quantity Sales
FROM dataset3) B
ON A.CustomerID = B.CustomerID
GROUP BY 1, 2;

-- 고객의 마지막 구매일 조회
SELECT CustomerID, MAX(InvoiceDate) MXDT
FROM dataset3
GROUP BY 1;

-- 2011-12-02로부터의 Timer Interval 계산
SELECT CustomerID, DATEDIFF('2011-12-02', MXDT) Recency
FROM
(SELECT CustomerID, MAX(InvoiceDate) MXDT
FROM dataset3
GROUP BY 1) A;

-- Frequency와 Monetary를 계산
SELECT CustomerID, COUNT(DISTINCT InvoiceNo) Frequency,
SUM(Quantity*UnitPrice) Monetary
FROM dataset3
GROUP BY 1;

-- Recency, Frequency, Monetary를 하나의 쿼리로 구현
SELECT CustomerID, DATEDIFF('2011-12-02', MXDT) Recency,
Frequency, Monetary
FROM
(SELECT CustomerID, MAX(InvoiceDate) MXDT, COUNT(DISTINCT InvoiceNo) Frequency,
SUM(Quantity*UnitPrice) Monetary
FROM dataset3
GROUP BY 1) A;

-- 고객별, 상품별 구매 연도를 Unique하게 카운트
SELECT CustomerID, StockCode, COUNT(DISTINCT SUBSTR(InvoiceDate, 1, 4)) Unique_YY
FROM dataset3
GROUP BY 1, 2;
-- 고객별로 Unique_YY의 최댓값을 계산
SELECT CustomerID, MAX(Unique_YY) MX_Unique_YY
FROM
(SELECT CustomerID, StockCode, COUNT(DISTINCT SUBSTR(InvoiceDate, 1, 4)) Unique_YY
FROM dataset3
GROUP BY 1, 2) A
GROUP BY 1;

-- MX_Unique_YY가 2 이상인 경우는 1로, 그렇지 않은 경우는 0으로 설정해 repurchase_segment를 생성
SELECT CustomerID, CASE WHEN MX_Unique_YY >= 2 THEN 1 ELSE 0 END repurchase_segment
FROM
(SELECT CustomerID, MAX(Unique_YY) MX_Unique_YY
FROM
(SELECT CustomerID, StockCode, COUNT(DISTINCT SUBSTR(InvoiceDate, 1, 4)) Unique_YY
FROM dataset3
GROUP BY 1, 2) A
GROUP BY 1) A
GROUP BY 1;

-- 고객별 첫 구매일
SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY CustomerId;

-- 일자별 첫 구매 고객 수
SELECT MNDT, COUNT(DISTINCT CustomerID) BU
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY CustomerId) A
GROUP BY MNDT;







