use market_db;
-- 데뷔 일자가 빠른 순서대로 조회 --
SELECT mem_id, mem_name, debut_date
FROM member
ORDER BY debut_date;

-- 내림차순 --
SELECT mem_id, mem_name, debut_date
FROM member
ORDER BY debut_date DESC;

-- 키가 164이상인 회원들을 내림차순으로 정렬 --
SELECT mem_id, mem_name, debut_date, height
FROM member
WHERE height >= 164
ORDER BY height DESC;

-- 여러개의 정렬기준, 평균 키가 큰 순서대로 정렬하되, 평균 키가 같으면 데뷔이ㅣㄹ자가 빠른 순서로 정렬 --
SELECT mem_id, mem_name, debut_date, height
FROM member
WHERE height >= 164
ORDER BY height DESC, debut_date ASC;

-- 회원 테이블을 조회 시, 전체 중 앞에서 3건만 조회 --
SELECT *
FROM member
LIMIT 3;

-- 중간부터 출력, 키가 큰 순으로 정렬하되, 3번째부터 2건만 조회하기 --
SELECT mem_name, height
FROM member
ORDER BY height DESC
LIMIT 3, 2;

-- 회원들의 지역을 중복없이 출력 --
SELECT DISTINCT addr
FROM member;

-- 각 회원별로 구매한 개수를 합쳐서 출력 -> 집계함수인 SUM()과 GROUP BY절 사용 --
-- GROUP BY로 회원별로 묶어준 후, SUM()함수로 구매한 개수를 합치면 된다. --
SELECT * FROM buy;
SELECT mem_id, sum(amount)
FROM buy
GROUP BY mem_id;

-- 별칭 사용 --
SELECT mem_id "회원 아이디" , sum(amount) "총 구매 개수"
FROM buy
GROUP BY mem_id;

-- 회원의 구매한 금액의 총합 가격(price) * 수량이고, 회원을 '회원 아이디'로 변경 --
SELECT mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM buy
GROUP BY mem_id;

-- 전체 회원이 구매한 물품 개수(amount)의 평균 --
SELECT AVG(amount) "평균 구매 횟수"
FROM buy;

-- 회원 별로 한 번 구매시 평균 몇 개를 구매했는지 조회 --
SELECT mem_id, AVG(amount) "평균 구매 횟수"
FROM buy
GROUP BY mem_id;

SELECT * FROM member;
-- 회원 테이블에서 연략처가 있는 회원의 수 카운트 --
SELECT COUNT(phone1) "연락처가 있는 회원"
FROM member;

-- 회원별 총 구매액 --
SELECT mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM buy
GROUP BY mem_id;

-- where절을 사용하여 조건을 제한할때 오류 발생 --
SELECT mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM buy
WHERE SUM(price * amount)> 1000
GROUP BY mem_id;

-- HAVING절을 사용하여 집계 함수에 대해 조건을 제한해 주면 된다 --
SELECT mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000;

-- 총 구매액이 큰 사용자부터 출력 --
SELECT mem_id "회원 아이디", SUM(price * amount) "총 구매 금액"
FROM buy
GROUP BY mem_id
HAVING SUM(price * amount) > 1000
ORDER BY SUM(price * amount) DESC;



















