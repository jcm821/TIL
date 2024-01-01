-- 기본 키 설정
USE naver_db;
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL
);

-- 테이블의 정보확인
DESCRIBE member;

-- PRIMARY KEY를 지정하는 다른 방법
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL,
PRIMARY KEY (mem_id)
);

-- ALTER TABLE에서 설정하는 제약 조건
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL
);
ALTER TABLE member
ADD CONSTRAINT
PRIMARY KEY (mem_id);

-- 기본 키에 이름 저장하기
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL,
CONSTRAINT PRIMARY KEY PK_member_mem_id (mem_id)
);

-- CREATE TABLE에서 설정하는 외래 키 제약조건
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL
);

CREATE TABLE buy
(num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
num_id CHAR(8) NOT NULL,
prod_name CHAR(6) NOT NULL,
FOREIGN KEY(mem_id) REFERENCES member(mem_id)
);

-- 기준 테이블의 열 이름과 참조 테이블의 열 이름
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL
);

CREATE TABLE buy
(num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
user_id CHAR(8) NOT NULL,
prod_name CHAR(6) NOT NULL,
FOREIGN KEY(user_id) REFERENCES member(mem_id)
);

-- ALTER TABLE에서 설정하는 외래 키 제약조건
DROP TABLE IF EXISTS buy;
CREATE TABLE buy
(num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
mem_id CHAR(8) NOT NULL,
prod_name CHAR(6) NOT NULL
);
ALTER TABLE buy
ADD CONSTRAINT
FOREIGN KEY(mem_id)
REFERENCES member(mem_id);

-- 데이터 삽입
INSERT INTO member VALUES('BLK', '블랙핑크', 163);
INSERT INTO buy VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy VALUES(NULL, 'BLK', '맥북');

-- 내부 조인 사용
SELECT M.mem_id, M.mem_name, B.prod_name
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- BLK의 아이디를 PINK로 변경
UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK';

-- 삭제도 수행해본다
DELETE FROM member WHERE mem_id = 'BLK';

-- 테이블 재생성하고 ALTER TABLE문을 수행
DROP TABLE IF EXISTS buy;
CREATE TABLE buy
(num INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
mem_id CHAR(8) NOT NULL,
prod_name CHAR(6) NOT NULL
);
ALTER TABLE buy
ADD CONSTRAINT
FOREIGN KEY(mem_id) REFERENCES member(mem_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- 구매 테이블에 데이터 다시 입력
INSERT INTO buy VALUES(NULL, 'BLK', '지갑');
INSERT INTO buy VALUES(NULL, 'BLK', '맥북');

-- 이젠 회원 테이블의 PINK로 변경하면 오류가 발생하지 않을 것이다
UPDATE member SET mem_id = 'PINK' WHERE mem_id = 'BLK';

-- 내부 조인 사용
SELECT M.mem_id, M.mem_name, B.prod_name
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- PINK가 탈퇴한 것으로 가정하고 기준 테이블에서 삭제 수행
DELETE FROM member WHERE mem_id = 'PINK';

SELECT * FROM buy;

-- 고유 키 제약조건
DROP TABLE IF EXISTS buy, member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL,
email CHAR(30) NULL UNIQUE
);

-- 데이터 입력
INSERT INTO member VALUES('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO member VALUES('TWC', '트와이스', 167, NULL);
INSERT INTO member VALUES('APN', '에이핑크', 164, 'pink@gmail.com');

-- CHECK 조건 수행
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL CHECK (height >= 100),
phone1 CHAR(3) NULL
);

INSERT INTO member VALUES('BLK', '블랙핑크', 163, NULL);
INSERT INTO member VALUES('TWC', '트와이스', 99, NULL);


-- ALTER문으로 제약조건을 추가
ALTER TABLE member
ADD CONSTRAINT
CHECK(phone1 IN ('02', '031', '032', '054', '055', '061'));

INSERT INTO member VALUES('TWC', '트와이스', 167, '02');
INSERT INTO member VALUES('OMY', '오마이걸', 167, '010');

-- 기본값 정의
DROP TABLE IF EXISTS member;
CREATE TABLE member
(mem_id CHAR(8) NOT NULL PRIMARY KEY,
mem_name VARCHAR(10) NOT NULL,
height TINYINT UNSIGNED NULL DEFAULT 160,
phone1 CHAR(3) NULL
);













