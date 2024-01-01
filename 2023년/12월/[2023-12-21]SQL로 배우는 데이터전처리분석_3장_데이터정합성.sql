-- 예시 구문
INSERT INTO table_name (column1, column2, column3, ...) VALUES
(value1, value2, value3);

-- 여러 줄을 추가하고자 할 때
INSERT INTO table_name (column1, column2, column3, ...) VALUES
(value1, value2, value3, ...),
(value4, value5, value6, ...);

-- 예시 구문
DELETE FROM table_name
WHERE some_column = some_value;

-- 특정 조건에 대한 데이터 행 삭제
DELETE FROM table_name
WHERE 상품 번호 = 'a003';

-- 성별이 'f'인 데이터를 모두 삭제하게 될 경우
DELETE FROM PRODUCT
WHERE 성별 = 'f';

-- 예시 구문
UPDATE table_name
SET column_name = 'new_value'
WHERE condition;

-- 특정 조건의 데이터를 업데이트
UPDATE product
SET 원가 = 70000
WHERE 상품 번호 = 'a002';

UPDATE product
SET 원가 = 70000
카테고리 = '피트니스'
WHERE 상품 번호 = 'a002';

-- 취소가 'Y'인 데이터의 매출액에 -1을 곱하면 매출액을 음수로 변경
UPDATE product
SET 원가 = (-1)*원가
WHERE 취소 여부 = 'Y';

-- 2023.01.02에 위 쿼리를 활용
UPDATE product
SET 원가 = (-1)*원가
WHERE 취소 여부 = 'Y';
AND 판매 일자 = CURDATE() - 1;

-- 프로시저 생성 예시 구문
DELIMITER $$
CREATE PROCEDURE 프로시저 명()
BEGIN
쿼리;
END $$
DELIMITER ;

-- sales_minus라는 이름의 프로시저 생성
DELIMITER $$
CREATE PROCEDURE sales_minus()
BEGIN
UPDATE product
SET 원가 = (-1)*원가
WHERE 취소 여부 = 'Y';
AND 판매 일자 = CURDATE() - 1
END $$
DELIMITER ;

-- 기존 쿼리
SELECT 주문 번호
FROM DB.SALES
WHERE 취소 여부 = 'Y';

-- 뷰 사용 예시 구문
CREATE VIEW DB.view_name
AS
SELECT-STATEMENT;

-- cancel_prodno라는 뷰 생성
CREATE VIEW DB.cancel_prodno
AS
SELECT 주문 번호
FROM DB.SALES
WHERE 취소 여부 = 'Y';

-- 생성된 뷰는 테이블과 동일하게 사용 가능
SELECT *
FROM DB.cancel_prodno;










