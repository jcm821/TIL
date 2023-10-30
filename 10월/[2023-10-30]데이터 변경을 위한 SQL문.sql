-- 새로운 테이블 hongon1 생성 및 데이터 삽입
USE market_db;
CREATE TABLE hongong1 (toy_id INT, toy_name CHAR(4), age INT);
INSERT INTO hongong1 VALUES (1, '우디', 25);
SELECT * FROM hongong1;

-- NULL값을 삽입 하고 싶을 시
INSERT INTO hongong1 (toy_id, toy_name) VALUES (2, '버즈');
 
-- 열의 순서를 바꿔서 입력하기
 INSERT INTO hongong1 (toy_name, age, toy_id) VALUES ('제시', 20, 3);
 
-- 자동으로 증가하는 AUTO_INCREMENT
CREATE TABLE hongong2 (
toy_id INT AUTO_INCREMENT PRIMARY KEY,
toy_name CHAR(4),
age INT);

-- 데이터 입력
INSERT INTO hongong2 VALUES (NULL, '보핍', 25);
INSERT INTO hongong2 VALUES (NULL, '슬링키', 22);
INSERT INTO hongong2 VALUES (NULL, '렉스', 21);
SELECT * FROM hongong2;

-- 현재 어느 숫자까지 증가되었는지 확인
SELECT LAST_INSERT_ID();

-- AUTO_INCREMENT로 입력되는 다음 값을 변경하고자 할 때
ALTER TABLE hongong2 AUTO_INCREMENT=100;
INSERT INTO hongong2 VALUES (NULL, '재남', 35);
SELECT * FROM hongong2;

-- 처음부터 입력되는 값을 1000으로 지정, 다음값은 3씩 증가하도록 설정하는 방법
-- @@auto_increment_increment를 변경시켜야 함
CREATE TABLE hongong3 (
toy_id INT AUTO_INCREMENT PRIMARY KEY,
toy_name CHAR(4),
age INT);
ALTER TABLE hongong3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;

INSERT INTO hongong3 VALUES (NULL, '토마스', 20);
INSERT INTO hongong3 VALUES (NULL, '제임스', 23);
INSERT INTO hongong3 VALUES (NULL, '고든', 25);
SELECT * FROM hongong3;

SELECT COUNT(*) FROM world.city;
DESC world.city;
SELECT * FROM world.city LIMIT 5;

-- 도시이름과 인구를 가져오기
--  테이블 생성
CREATE TABLE city_popul (city_name CHAR(35), population INT);

-- world.city 테이블의 내용을 city_popul 테이블에 입력
INSERT INTO city_popul
SELECT Name, Population FROM world.city;
SELECT * FROM city_popul LIMIT 5;

-- city_popul테이블의 도시 이름 변경
USE market_db;
UPDATE city_popul
SET city_name = '서울'
WHERE city_name = 'Seoul';
SELECT * FROM city_popul WHERE city_name = '서울';

-- 한번에 여러 열의 값을 변경
-- 도시이릉과 인구 값을 모두 변경
UPDATE city_popul
SET city_name = '뉴욕', population = 0
WHERE city_name = 'New York';
SELECT * FROM city_popul WHERE city_name = '뉴욕';

-- 전체 테이블의 내용을 변경하게 되는  경우: 인구단위를 10000명 단위로 변경하고자 할 때
UPDATE city_popul
SET population = population / 10000;
SELECT * FROM city_popul LIMIT 5;













