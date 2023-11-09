-- 회원 테이블 정의 시에 선언한 SQL
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
mem_number INT NOT NULL,
...

-- 테이블을 만들고 첫 번째 열을 기본 키로 지정
USE market_db;
CREATE TABLE table1(
col1 INT PRIMARY KEY,
col2 INT,
col3 INT
);

-- SHOW INDEX문을 사용하여 인덱스 정보 확인
SHOW INDEX FROM table1;

-- 고유 키도 인덱스가 자동 생성된다
CREATE TABLE table2(
col1 INT PRIMARY KEY,
col2 INT UNIQUE,
col3 INT UNIQUE
);
SHOW INDEX FROM table2;

-- 클러스터형 인덱스 예시
USE market_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member
(mem_id CHAR(8),
mem_name VARCHAR(10),
mem_number INT,
addr CHAR(2)
);

-- 데이터 삽입
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;

-- 아이디를 기준으로 정렬 순서 변경
ALTER TABLE member
ADD CONSTRAINT
PRIMARY KEY (mem_id);
SELECT * FROM member;

-- mem_id열의 Primary Key를 제거하고, mem_name열을 Primary Key로 지정
ALTER TABLE member DROP PRIMARY KEY;
ALTER TABLE member
ADD CONSTRAINT
PRIMARY KEY(mem_name);
SELECT * FROM member;

-- 추가로 데이터를 입력하면 알아서 기준에 맞춰 정렬된다
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;

-- 보조 인덱스 예시
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8),
mem_name VARCHAR(10),
mem_number INT,
addr CHAR(2)
);

-- 데이터 입력
INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');
SELECT * FROM member;

-- mem_id열을 고유 키로 설정하고 내용 확인
ALTER TABLE member
ADD CONSTRAINT
UNIQUE(mem_id);
SELECT * FROM member;

-- mem_name열에 추가로 고유 키 지정
ALTER TABLE member
ADD CONSTRAINT
UNIQUE(mem_name);
SELECT * FROM member;

-- 데이터 추가 입력
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울');
SELECT * FROM member;








