-- 테이블 조회
USE market_db;
SELECT mem_id, mem_name, addr FROM member;

-- 뷰를 만드는 형식
CREATE VIEW 뷰 이름
AS
SELECT 문;

SELECT 열_이름 FROM
뷰 이름
[WHERE 조건];

-- 회원 테이블의 아이디, 이름, 주소에 접근하는 뷰 생성
USE market_db;
CREATE VIEW v_member
AS
SELECT mem_id, mem_name, addr FROM member;

-- 뷰 확인
SELECT * FROM v_member;

-- 필요한 열만 보거나 조건식 사용
SELECT mem_name, addr FROM v_member
WHERE addr IN ('서울', '경기')

-- 앞선 예제에서 사용되었던 물건을 구매한 회원들에 대한 SQL문
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
CONCAT(M.phone1, M.phone2) '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- 위의 SQL문을 뷰로 만들어 사용
CREATE VIEW v_memberbuy
As
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr,
CONCAT(M.phone1, M.phone2) '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- 블랙핑크의 구매 기록 조회
SELECT * FROM v_memberbuy WHERE mem_name = '블랙핑크';

-- 뷰 생성 예제
USE market_db;
CREATE VIEW v_viewtest1
AS
SELECT B.mem_id 'Member ID', M.mem_name AS 'Member Name',
B.prod_name "Product Name", CONCAT(M.phone1, M.phone2) AS "Officce Phone"
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

SELECT DISTINCT `Member ID`, `Member Name` FROM v_viewtest1;

-- 뷰 수정 예시
ALTER VIEW v_viewtest1
AS
SELECT B.mem_id '회원 아이디', M.mem_name AS '회원 이름', B.prod_name "제품 이름",
CONCAT(M.phone1, M.phone2) AS "연락처"
FROM buy B
INNER JOIN member M
ON b.mem_id = M.mem_id;

SELECT DISTINCT `회원 아이디`, `회원 이름` FROM v_viewtest1;

-- 뷰의 삭제
DROP VIEW v_viewtest1;

-- 기존에 생성된 뷰에 대한 정보를 확인
USE market_db;
CREATE OR REPLACE VIEW v_viewtest2
AS
SELECT mem_id, mem_name, addr FROM member;

-- 뷰의 정보 확인
DESCRIBE v_viewtest2;

DESCRIBE member;

SHOW CREATE VIEW v_viewtest2;


-- 뷰를 통한 데이터 수정
UPDATE v_member SET addr = '부산' WHERE mem_id = 'BLK';

-- 데이터 입력
INSERT INTO v_member(mem_id, mem_name, addr) VALUES('BTS', '방탄소년단', '경기');

-- 지정한 범위로 뷰를 생성, 평균 키가 167 이상인 뷰를 생성
CREATE VIEW v_height167
AS
SELECT * FROM member WHERE height >= 167;
SELECT * FROM v_height167;

-- 뷰에서 키가 167미만인 데이터 삭제
DELETE FROM v_height167 WHERE height < 167;

-- 뷰에서 키가 167미만인 데이터 입력
INSERT INTO v_height167 VALUES('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');
SELECT * FROM v_height167;

-- WITH CHECK OPTION 사용 예시
ALTER VIEW v_height167
AS
SELECT * FROM member WHERE height >= 167
WITH CHECK OPTION;
INSERT INTO v_height167 VALUES('TOP', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01');

-- 복합 뷰의 예시
CREATE VIEW v_complex
AS
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- 뷰가 참조하는 테이블 삭제
DROP TABLE IF EXISTS buy, member;

SELECT * FROM v_height167;

-- CHECK TABLE문으로 뷰의 상태 확인
CHECK TABLE v_height167;





