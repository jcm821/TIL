-- 정수형 데이터 형식을 확인
USE market_db;
CREATE TABLE hongong4 (
tinyint_col TINYINT,
smallint_col SMALLINT,
int_col INT,
bigint_col BIGINT);

-- 각 영역의 최대값 입력
INSERT INTO hongong4 VALUES(127, 32767, 2147483647, 9000000000000000000);
SELECT * FROM hongong4;

-- 각 숫자에 1을 더해서 입력
INSERT INTO hongong4 VALUES(128, 32768, 2147483648, 9000000000000000000);

-- 열의 길이를 너무 크게 설정하여 나타난 오류
CREATE TABLE big_table(
data1 CHAR(256),
data2 VARCHAR(16384));

-- 넷플릭스와 같은 동영상 사이트의 테이블 구조
CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE movie
(movie_id	INT,
movie_title	VARCHAR(30),
movie_director	VARCHAR(20),
movie_star	VARCHAR(20),
movie_script	LONGTEXT,
movie_film	LONGBLOB
)	

-- 변수의 사용
USE market_db;
SET @myVar1 = 5;
SET @myVar2 = 4.25;

SELECT @myVar1;
SELECT @myVar1 + @myVar2;

SET @txt = '가수이름==> ';
SET @height = 166;
SELECT @txt, mem_name FROM member WHERE height > @height;

-- LIMIT에 변수 사용
SET @count = 3;
SELECT mem_name, height FROM member ORDER BY height LIMIT @count;

-- prepare, execute 예시구문
SET @count = 3;
PREPARE mySQL FROM 'SELECT mem_name, height FROM member ORDER BY height LIMIT ?';
EXECUTE mySQL USING @count;

-- CAST(), CONVERT()를 이용한 예시
SELECT AVG(price) AS '평균 가격' FROM buy;

-- CAST(), CONVERT()를 이용한 데이터 형 변환
-- CAST()
SELECT CAST(AVG(price) AS SIGNED) '평균 가격' FROM buy;
-- CONVERT()
SELECT CONVERT(AVG(price), SIGNED) '평균 가격' FROM buy;

-- 날짜데이터 형 변환
SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

-- 가격과 수량을 곱한 실제 구매액을 표시하는 SQL
SELECT num, CONCAT(CAST(price AS CHAR), 'X', CAST(amount AS CHAR), '=') 
AS '가격X수량', price*amount AS '구매액'
FROM buy;

-- 암시적인 변환의 예시
SELECT '100' + '200';

-- 문자형의 결합으로 만들기
SELECT CONCAT('100', '200');

-- 숫자와 문자를 CONCAT()함수로 연결
SELECT CONCAT(100, '200');
SELECT 100 + '200';










