-- 간단한 트리거
USE market_db;
CREATE TABLE IF NOT EXISTS trigger_table (id INT, txt VARCHAR(10));
INSERT INTO trigger_table VALUES(1, '레드벨벳');
INSERT INTO trigger_table VALUES(2, '잇지');
INSERT INTO trigger_table VALUES(3, '블랙핑크');

-- 테이블에 트리거 부착
DROP TRIGGER IF EXISTS myTrigger;
DELIMITER $$
CREATE TRIGGER myTrigger
	# DELETE문이 발생된 이후에 작동하라는 의미
	AFTER DELETE
    ON trigger_table
	# 각 행마다 적용
    FOR EACH ROW
BEGIN
# 트리거에서 실제로 작동할 부분
SET @msg = '가수 그룹이 삭제됨' ;  -- 트리거 실행 시 작동되는 코드들
END $$
DELIMITER ;

-- INSERT, UPDATE문 사용
SET @msg = '';
INSERT INTO trigger_table VALUES(4, '마마무');
SELECT @msg;
UPDATE trigger_table SET txt = '블핑' WHERE id = 3;
SELECT @msg;

-- DELETE문을 테이블에 적용
DELETE FROM trigger_table WHERE id = 4;
SELECT @msg;

-- 고객 테이블에 입력된 회원의 정보가 변경될 때 변경한 사용자, 시간, 변경 전의 데이터 등을 기록하는 트리거
USE market_db;
CREATE TABLE singer (SELECT mem_id, mem_name, mem_number, addr FROM member);

-- 변경되기 전의 데이터를 저장할 백업 테이블 미리 생성
CREATE TABLE backup_singer
(mem_id CHAR(8) NOT NULL,
mem_name VARCHAR(10) NOT NULL,
mem_number INT NOT NULL,
addr CHAR(2) NOT NULL,
modType CHAR(2),  -- 변경된 타입, '수정' 또는 '삭제'
modDate DATE,  -- 변경된 날짜
modUser VARCHAR(30)  -- 변경한 사용자
);

-- 변경과 삭제가 발생할 때 작동하는 트리거를 singer 테이블에 부착 -> 변경이 발생했을 때 작동하는 singer_updateTrg 생성
DROP TRIGGER IF EXISTS singer_updateTrg;
DELIMITER $$
CREATE TRIGGER singer_updateTrg
	AFTER UPDATE
    ON singer
    FOR EACH ROW
BEGIN
	INSERT INTO backup_singer VALUES(OLD.mem_id, OLD.mem_name,
		OLD.mem_number, OLD.addr, '수정', CURDATE(), CURRENT_USER() );
END $$
DELIMITER ;

-- 삭제가 발생했을 때 작동하는 singer_deleteTrg 트리거 생성
DROP TRIGGER IF EXISTS singer_deleteTrg;
DELIMITER $$
CREATE TRIGGER singer_deleteTrg  -- 트리거 이름
	AFTER DELETE  -- 삭제 후 작동하도록 지정
    ON singer  -- 트리거를 부착할 테이블
    FOR EACH ROW
BEGIN
	INSERT INTO backup_singer VALUES(OLD.mem_id, OLD.mem_name,
		OLD.mem_number, OLD.addr, '삭제', CURDATE(), CURRENT_USER() );
END $$
DELIMITER ;

-- 데이터 변경
UPDATE singer SET addr = '영국' WHERE mem_id = 'BLK';
DELETE FROM singer WHERE mem_number >= 7;

-- 백업 데이터 조회
SELECT * FROM  backup_singer;

-- 테이블의 모든 행 데이터 삭제













