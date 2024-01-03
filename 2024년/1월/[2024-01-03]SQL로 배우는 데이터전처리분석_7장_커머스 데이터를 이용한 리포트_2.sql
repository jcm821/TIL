USE mydata;
-- 고객별, 상품별 첫 구매 일자
SELECT CustomerID, StockCode, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1, 2;

-- 서브쿼리로 생성하고 순위 열을 생성
SELECT *,
ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY MNDT) RNK
FROM
(SELECT CustomerID, StockCode, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1, 2) A;

-- 순위 열의 값이 1인 조건을 생성
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY MNDT) RNK
FROM
(SELECT CustomerID, StockCode, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1, 2) A) A
WHERE RNK = 1;

-- 상품별 첫 구매 고객 수 집계
SELECT StockCode, COUNT(DISTINCT CustomerID) First_BU
FROM
(SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY CustomerID ORDER BY MNDT) RNK
FROM
(SELECT CustomerID, StockCode, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1, 2) A) A
WHERE RNK = 1) A
GROUP BY StockCode
ORDER BY 2 DESC;

SELECT * FROM dataset3;

-- 고객별 구매 일자의 중복 제거하고 카운트
SELECT CustomerID, COUNT(DISTINCT InvoiceDate) F_Date
FROM dataset3
GROUP BY 1;

-- 첫 구매 후 이탈한 고객 수를 계산
SELECT SUM(CASE WHEN F_Date = 1 THEN 1 ELSE 0 END) / SUM(1) Bounc_Rate
FROM
(SELECT CustomerID, COUNT(DISTINCT InvoiceDate) F_Date
FROM dataset3
GROUP BY 1) A;

-- 국가별 첫 구매 후 이탈 고객의 비중
SELECT Country, SUM(CASE WHEN F_Date = 1 THEN 1 ELSE 0 END) / SUM(1) Bounc_Rate
FROM
(SELECT CustomerID, Country, COUNT(DISTINCT InvoiceDate) F_Date
FROM dataset3
GROUP BY 1, 2) A
GROUP BY 1
ORDER BY Country;

-- 2011년도 상품별 판매 수량
SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011'
GROUP BY 1;

-- 2010년도 상품별 판매 수량
SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2010'
GROUP BY 1;

-- 2011년도 상품별 판매 수량 테이블에 2010년도 상품별 판매 수량 테이블 결합
SELECT *
FROM
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011'
GROUP BY 1) A
LEFT JOIN
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2010'
GROUP BY 1) B
ON A.StockCode = B.StockCode;

-- 상품코드, 2011년 판매 수량, 2010년 판매 수량을 구하고 2010년 대비 증가율 계산
SELECT A.StockCode, A.QTY, B.QTY, A.QTY/B.QTY-1 QTY_Increase_Rate
FROM
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011'
GROUP BY 1) A
LEFT JOIN
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2010'
GROUP BY 1) B
ON A.StockCode = B.StockCode;

-- 2010년 대비 2011년 증가율이 0.2 이상인 경우로 조건 생성
SELECT *
FROM
(SELECT A.StockCode, A.QTY QTY_2011, B.QTY QTY_2010, A.QTY/B.QTY-1 QTY_Increase_Rate
FROM
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011'
GROUP BY 1) A
LEFT JOIN
(SELECT StockCode, SUM(Quantity) QTY
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2010'
GROUP BY 1) B
ON A.StockCode = B.StockCode) BASE
WHERE QTY_Increase_Rate >= 1.2;

-- 2011년 주차별 매출액 계산
SELECT WEEKOFYEAR(InvoiceDate) WK,
SUM(Quantity*UnitPrice) Sales
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011'
GROUP BY 1
ORDER BY 1;

-- 각 고객을 신규 고객과 기존 고객으로 구별
SELECT CASE WHEN SUBSTR(MNDT, 1, 4) = '2011' THEN 'NEW' ELSE 'EXI' END New_EXI,
CustomerID
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1) A;

-- 신규, 기존으로 구분되게 설정했으므로 해당 테이블을 매출 테이블에 조인
SELECT A.CustomerID, B.NEW_EXI, A.InvoiceDate, A.UnitPrice, A.Quantity
FROM dataset3 A
LEFT JOIN
(SELECT CASE WHEN SUBSTR(MNDT, 1, 4) = '2011' THEN 'NEW' ELSE 'EXI' END New_EXI,
CustomerID
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1) A) B
ON A.CustomerID = B.CustomerID
WHERE SUBSTR(A.InvoiceDate, 1, 4) = '2011';

-- 조인 결과를 월, 신규/기존으로 구분해 매출 집계
SELECT B.NEW_EXI, SUBSTR(A.InvoiceDate, 1, 7) MM,
SUM(A.UnitPrice*A.Quantity) Sales
FROM dataset3 A
LEFT JOIN
(SELECT CASE WHEN SUBSTR(MNDT, 1, 4) = '2011' THEN 'NEW' ELSE 'EXI' END New_EXI,
CustomerID
FROM
(SELECT CustomerID, MIN(InvoiceDate) MNDT
FROM dataset3
GROUP BY 1) A) B
ON A.CustomerID = B.CustomerID
WHERE SUBSTR(A.InvoiceDate, 1, 4) = '2011'
GROUP BY 1, 2;

-- 기존 고객 리스트
SELECT CustomerID
FROM dataset3
GROUP BY 1
HAVING MIN(SUBSTR(InvoiceDate, 1, 4)) = '2010';

-- 기존 고객들의 2011년 구매 내역 조회
SELECT *
FROM dataset3
WHERE CustomerID IN
(SELECT CustomerID
FROM dataset3
GROUP BY 1
HAVING MIN(SUBSTR(InvoiceDate, 1, 4)) = '2010')
AND SUBSTR(InvoiceDate, 1, 4) = '2011';

-- 고객별로 첫 구매 월 계산
SELECT CustomerID, SUBSTR(InvoiceDate, 1, 7) MM
FROM
(SELECT *
FROM dataset3
WHERE CustomerID IN
(SELECT CustomerID
FROM dataset3
GROUP BY 1
HAVING MIN(SUBSTR(InvoiceDate, 1, 4)) = '2010')
AND SUBSTR(InvoiceDate, 1, 4) = '2011') A
GROUP BY 1;

-- 첫 구매 월로 그룹핑한 뒤 CustomerID 집계
SELECT MM, COUNT(CustomerID) N_Customers
FROM
(SELECT CustomerID, SUBSTR(InvoiceDate, 1, 7) MM
FROM
(SELECT *
FROM dataset3
WHERE CustomerID IN
(SELECT CustomerID
FROM dataset3
GROUP BY 1
HAVING MIN(SUBSTR(InvoiceDate, 1, 4)) = '2010')
AND SUBSTR(InvoiceDate, 1, 4) = '2011') A
GROUP BY 1, 2) A
GROUP BY 1
ORDER BY 1;

-- 기존 고객 수 계산
SELECT COUNT(*) N_Customers
FROM
(SELECT CustomerID FROM dataset3
GROUP BY 1
HAVING MIN(SUBSTR(InvoiceDate, 1, 4)) = '2010') A;

-- Retention Rate: 2010년 구매자 중 2011년에 구매한 고객의 비율로 계산
SELECT COUNT(B.CustomerID)/COUNT(A.CustomerID) Retention_Rate
FROM
(SELECT DISTINCT CustomerID
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2010') A
LEFT JOIN
(SELECT DISTINCT CustomerID
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011') B
ON A.CustomerID = B.CustomerID;

-- AMV 계산
SELECT SUM(UnitPrice*Quantity)/COUNT(DISTINCT CustomerID) AMV
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011';

-- 2011년도 구매자 수 계산
SELECT COUNT(DISTINCT CustomerID) N_BU
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011';

-- 2011년 매출액
SELECT SUM(UnitPrice*Quantity) Sales_2011
FROM dataset3
WHERE SUBSTR(InvoiceDate, 1, 4) = '2011';




