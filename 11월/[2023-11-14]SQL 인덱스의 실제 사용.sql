-- 인덱스 생성
CREATE [UNIQUE] INDEX 인덱스_이름
ON 테이블_이름 (열_이름) [ASC | DESC]

-- 인덱스 제거
DROP INDEX 인덱스_이름 ON 테이블_이름

-- 인덱스 생성 문법
CREATE [UNIQUE | FULLTEXT | SPATIAL] INDEX index_mem_name
[index_type]
ON tbl_mem_name (key_part,...)
[index_option]
[algorithm_option|lock_option]

key_part: {col_mem_name [(length)] | (expr)} [ASC | DESC]

index_option:
KEY_BLOCK_SIZE [=] value
| index_type
| WITH PARSER parser_mem_name
| COMMENT 'string'
| {VISIBLE | INVISIBLE}

index_type:
USING{BTREE | HASH}

algorithm_option:
ALGORITHM [=] {DEFAULT | INPLACE | COPY}

lock_option:
LOCK [=] {DEFAULT | NONE | SHARED | EXCLUSIVE}

-- 실제 사용하는 문법
CREATE [UNIQUE] INDEX 인덱스_이름
On 테이블_이름 (열_이름) [ASC | DESC]

-- 인덱스 제거 문법
DROP INDEX 인덱스_이름 ON 테이블_이름

-- 인덱스 생성 실습
USE market_db;
SELECT * FROM member;

-- member에 어떤 인덱스가 설정되어 있는지 확인
SHOW INDEX FROM member;

-- 인덱스의 크기 확인
SHOW TABLE STATUS LIKE 'member';

-- 보조 인덱스 지정
CREATE INDEX idx_member_addr
ON member(addr);

-- 새로 생성된 인덱스 확인
SHOW INDEX FROM member;

-- 보조 인덱스가 추가되고 전체 인덱스의 크기를 다시 확인
SHOW TABLE STATUS LIKE 'member';

-- ANALYZE TABLE문으로 먼저 테이블을 분석/처리해줘야 한다
ANALYZE TABLE member;
SHOW TABLE STATUS LIKE 'member';

-- 인원수에 중복을 허용하지 않는 고유 보조 인덱스를 생성
CREATE UNIQUE INDEX idx_member_mem_number
ON member (mem_number);

-- 회원 이름에 고유 보조 인덱스 생성
CREATE UNIQUE INDEX idx_member_mem_name
ON member (mem_name);

-- 고유 보조 인덱스 확인
SHOW INDEX FROM member;

-- 고유 보조 인덱스로 인해서 중복된 값을 입력할 수 없는 경우
INSERT INTO member VALUES('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10');

-- 중복된 데이터가 많은 열에 인덱스 생성
SELECT * FROM 회원_테이블 WHERE 성별 = 'M';

-- 지금까지 만든 인덱스가 어느 열에 있는지 확인
ANALYZE TABLE member;
SHOW INDEX FROM member;

-- 전체 조회
SELECT * FROM member;

-- 인덱스가 있는 열 조회
SELECT mem_id, mem_name, addr FROM member;

-- 인덱스가 생성된 mem_name 값이 '에이핑크'인 행을 조회
SELECT mem_id, mem_name, addr FROM member
WHERE mem_name = '에이핑크';

-- 숫자의 범위로 조회
CREATE INDEX idx_member_mem_number
ON member(mem_number);
ANALYZE TABLE member;

-- 인원수가 7명 이상인 그룹의 이름과 인원수 조회
SELECT mem_name, mem_number
FROM member
WHERE mem_number >= 7;

-- 인원 수가 1명 이상인 회원 조회
SELECT mem_name, mem_number
FROM member
WHERE mem_number >= 1;

-- 인원수의 2배를 하면 14명 이상이 되는 회원의 이름과 인원수를 검색
SELECT mem_name, mem_number
FROM member
WHERE mem_number*2 >= 14;

-- 수정
SELECT mem_name, mem_number
FROM member
WHERE mem_number >= 14/2;


SHOW INDEX FROM member;

-- 보조 인덱스 제거
DROP INDEX idx_member_mem_name ON member;
DROP INDEX idx_member_addr ON member;
DROP INDEX idx_member_mem_number ON member;

-- Primary Key에 설정된 인덱스는 ALTER TABLE문으로만 제거할 수 있다
ALTER TABLE member
DROP PRIMARY KEY;

-- 외래 키 이름 확인
SELECT table_name, constraint_name
FROM information_schema.referential_constraints
WHERE constraint_schema = 'market_db';


-- 외래 키 인덱스 제거
ALTER TABLE buy
DROP FOREIGN KEY buy_ibfk_1;
ALTER TABLE member
DROP PRIMARY KEY;








