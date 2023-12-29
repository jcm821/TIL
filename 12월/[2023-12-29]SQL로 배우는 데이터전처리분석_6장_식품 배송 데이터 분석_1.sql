USE instacart
-- 주문 건수
SELECT COUNT(DISTINCT order_id) F
FROM orders;

-- 구매자 수
SELECT COUNT(DISTINCT user_id) BU
FROM orders;

-- 상품별 주문 건수 조회
SELECT *
FROM order_products__prior A
LEFT JOIN
products B
ON A.product_id = B.product_id;

-- product_name으로 데이터 그룹핑
SELECT B.product_name, COUNT(DISTINCT A.order_id) F
FROM order_products__prior A
LEFT JOIN
products B
ON A.product_id = B.product_id
GROUP BY 1;

-- order_products__prior의 product_id별로 가장 먼저 담긴 경우에는 1을 출력
SELECT product_id,
CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END F_1st
FROM order_products__prior;

-- 상품별로 장바구니에 가장 먼저 담긴 건수를 계산
SELECT product_id,
SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
FROM order_products__prior
GROUP BY 1;

-- F_1st로 데이터에 순서 정립
SELECT *,
ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
FROM order_products__prior
GROUP BY 1) A;

-- WHERE절에 조건을 추가해 RNK가 1-10사이인 데이터만 출력
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY F_1st DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
FROM order_products__prior
GROUP BY 1) A) BASE
WHERE RNK BETWEEN 1 AND 10;

-- ORDER BY를 이용하여 상위10개의 데이터 호출
SELECT product_id,
SUM(CASE WHEN add_to_cart_order = 1 THEN 1 ELSE 0 END) F_1st
FROM order_products__prior
GROUP BY 1
ORDER BY 2 DESC LIMIT 10;

-- 시간별 주문 건수
SELECT order_hour_of_day,
COUNT(DISTINCT order_id) F
FROM orders
GROUP BY 1
ORDER BY 1;

-- 첫 구매 후 다음 구매까지 걸린 평균 일수
SELECT AVG(days_since_prior_order) AVG_Recency
FROM orders
WHERE order_number = 2;

-- 주문 건당 평균 구매 상품
SELECT COUNT(product_id) / COUNT(DISTINCT order_id) UPT
FROM order_products__prior;

-- 인당 평균 주문 건수
SELECT COUNT(order_id) / COUNT(DISTINCT user_id) UPT
FROM orders;

-- 상품별 재구매율 계산
SELECT product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END) / COUNT(*) Ret_Ratio
FROM order_products__prior
GROUP BY 1;

-- 재구매율로 랭크(순위) 열 생성
SELECT *,
ROW_NUMBER() OVER(ORDER BY Ret_Ratio DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END) / COUNT(*) Ret_Ratio
FROM order_products__prior
GROUP BY 1) A;

-- Top 10(재구매율) 상품 추출
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY Ret_Ratio DESC) RNK
FROM
(SELECT product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END) / COUNT(*) Ret_Ratio
FROM order_products__prior
GROUP BY 1) A) A
WHERE RNK BETWEEN 1 AND 10;

-- Department별 재구매율이 가장 높은 상품 10개
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY Ret_Ratio DESC) RNK
FROM
(SELECT C.department, A.product_id,
SUM(CASE WHEN reordered = 1 THEN 1 ELSE 0 END) / COUNT(*) Ret_Ratio
FROM order_products__prior A
LEFT JOIN
products B
ON A.product_id = B.product_id
LEFT JOIN
departments C
ON B.department_id = C.department_id
GROUP BY 1, 2) A) A
WHERE RNK BETWEEN 1 AND 10;

-- 주문 건수에 따른 Rank를 생성
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








