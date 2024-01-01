USE instacart
-- 주문 건수에 따른 Rank 생성
SELECT *,
ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM
(SELECT user_id, COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1) A;

-- 전체 고객 수 계산
SELECT COUNT(DISTINCT user_id)
FROM
(SELECT user_id,
COUNT(DISTINCT order_id) F
FROM orders
GROUP BY
1) A;

-- 각 등수에 따른 분위수1
SELECT *,
CASE WHEN RNK BETWEEN 1 AND 316 THEN 'Quantile 1'
WHEN RNK BETWEEN 317 AND 632 THEN 'Quantile 2'
WHEN RNK BETWEEN 633 AND 948 THEN 'Quantile 3'
WHEN RNK BETWEEN 949 AND 1264 THEN 'Quantile 4'
WHEN RNK BETWEEN 1265 AND 1580 THEN 'Quantile 5'
WHEN RNK BETWEEN 1581 AND 1895 THEN 'Quantile 6'
WHEN RNK BETWEEN 1896 AND 2211 THEN 'Quantile 7'
WHEN RNK BETWEEN 2212 AND 2527 THEN 'Quantile 8'
WHEN RNK BETWEEN 2528 AND 2843 THEN 'Quantile 9'
WHEN RNK BETWEEN 2844 AND 3159 THEN 'Quantile 10' END quantile
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM
(SELECT user_id,
COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1) A) A;

-- 각 등수에 따른 분위수2
SELECT *,
CASE WHEN RNK <= 316 THEN 'Quantile 1'
WHEN RNK <= 632 THEN 'Quantile 2'
WHEN RNK <= 948 THEN 'Quantile 3'
WHEN RNK <= 1264 THEN 'Quantile 4'
WHEN RNK <= 1580 THEN 'Quantile 5'
WHEN RNK <= 1895 THEN 'Quantile 6'
WHEN RNK <= 2211 THEN 'Quantile 7'
WHEN RNK <= 2527 THEN 'Quantile 8'
WHEN RNK <= 2843 THEN 'Quantile 9'
WHEN RNK <= 3159 THEN 'Quantile 10' END quantile
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM
(SELECT user_id,
COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1) A) A;

-- 하나의 테이블로 생성해 user_id별 분위 수 정보 생성
CREATE TEMPORARY TABLE user_quantile AS
SELECT *,
CASE WHEN RNK BETWEEN 1 AND 316 THEN 'Quantile 1'
WHEN RNK BETWEEN 317 AND 632 THEN 'Quantile 2'
WHEN RNK BETWEEN 633 AND 948 THEN 'Quantile 3'
WHEN RNK BETWEEN 949 AND 1264 THEN 'Quantile 4'
WHEN RNK BETWEEN 1265 AND 1580 THEN 'Quantile 5'
WHEN RNK BETWEEN 1581 AND 1895 THEN 'Quantile 6'
WHEN RNK BETWEEN 1896 AND 2211 THEN 'Quantile 7'
WHEN RNK BETWEEN 2212 AND 2527 THEN 'Quantile 8'
WHEN RNK BETWEEN 2528 AND 2843 THEN 'Quantile 9'
WHEN RNK BETWEEN 2844 AND 3159 THEN 'Quantile 10' END quantile
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY F DESC) RNK
FROM
(SELECT user_id,
COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1) A) A;

-- 각 분위 수별 전체 주문 건수의 합 구하기
SELECT quantile, SUM(F) F
FROM user_quantile
GROUP BY 1;

-- 전체 주문 건수를 계산
SELECT SUM(F) FROM user_quantile;

-- 각 분위 수의 주문 건수를 전체 주문 건수로 나누기
SELECT quantile, SUM(F)/3220 F
FROM user_quantile
GROUP BY 1;

-- 상품별 재구매 비중과 주문 건수 계산
SELECT product_id, SUM(reordered)/SUM(1) Reorder_Rate,
COUNT(DISTINCT order_id) F
FROM order_products__prior
GROUP BY product_id
ORDER BY Reorder_Rate DESC;

-- HAVING을 이용하여 일정 건수 이하인 상품들 제외
SELECT A.product_id, SUM(reordered)/SUM(1) Reorder_Rate,
COUNT(DISTINCT order_id) F
FROM order_products__prior A
LEFT JOIN products B
ON A.product_id = B.product_id
GROUP BY product_id
HAVING COUNT(DISTINCT order_id) > 10;

-- HAVING을 사용하여 조건 생성
SELECT A.product_id, B.product_name,
COUNT(DISTINCT order_id) F
FROM order_products__prior A
LEFT JOIN products B
ON A.product_id = B.product_id
GROUP BY product_id, B.product_name
HAVING COUNT(DISTINCT order_id) > 10;

-- 어떤 상품들이 재구매율이 높은지 보기 위해 ptoducts테이블 join
SELECT A.product_id, B.product_name,
SUM(reordered)/SUM(1) Reorder_Rate,
COUNT(DISTINCT order_id) F
FROM order_products__prior A
LEFT JOIN products B
ON A.product_id = B.product_id
GROUP BY product_id, product_name
HAVING COUNT(DISTINCT order_id) > 10;

-- 상품별 재구매율을 계산하고, 가장 높은 순위를 매긴다
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY Ret_Ratio DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END)/COUNT(*) Ret_Ratio
FROM order_products__prior
GROUP BY 1) A) A;

-- 10분위 분석과 동일한 방법으로 각 상품을 10개의 그룹으로 나눈다
CREATE TEMPORARY TABLE product_repurchase_quantile AS
SELECT A.product_id,
CASE WHEN RNK <= 929 THEN 'Q_1'
WHEN RNK <= 1858 THEN 'Q_2'
WHEN RNK <= 2786 THEN 'Q_3'
WHEN RNK <= 3715 THEN 'Q_4'
WHEN RNK <= 4644 THEN 'Q_5'
WHEN RNK <= 5573 THEN 'Q_6'
WHEN RNK <= 6502 THEN 'Q_7'
WHEN RNK <= 7430 THEN 'Q_8'
WHEN RNK <= 8359 THEN 'Q_9'
WHEN RNK <= 9288 THEN 'Q_10' END RNK_GRP
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY Ret_Ratio DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END)/COUNT(*) Ret_Ratio
FROM order_products__prior
GROUP BY 1) A) A
GROUP BY 1, 2;

-- 생성한 테이블 확인
SELECT * FROM product_repurchase_quantile;

--  각 분위 수별로 재구매 소요 시간의 분산을 구하기
CREATE TEMPORARY TABLE order_products__pior2 AS
SELECT product_id, days_since_prior_order
FROM order_products__prior A
INNER JOIN orders B
ON A.order_id = B.order_id;

-- 결합한 테이블에서 분위수, 상품별 구매 소요 기간의 분산 계산

























