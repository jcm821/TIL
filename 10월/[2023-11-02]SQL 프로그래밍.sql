-- 스토어드 프로시저 구조
DELIMITER $$
CREATE PROCEDURE 스토어드_프로시저_이름()
BEGIN
이 부분에 SQL 프로그래밍 코딩
END $$
DELIMITER;
CALL 스토어드_프로시저_이름()

-- 기본 IF문의 형식
IF <조건식> THEN
SQL 문장들
END IF;

-- BEGIN ~ END구문의 예
DROP PROCEDURE IF EXISTS ifProc1;
DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
IF 100 = 100 THEN
        SELECT '100은 100과 같습니다.';
    END IF;
END $$
DELIMITER ;
CALL ifProc1;

-- IF ~ ELSE문 예시
DROP PROCEDURE IF EXISTS ifProc2;
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
	DECLARE myNum INT;
    SET myNum = 200;
    IF myNum = 100 THEN
		SELECT '100입니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc2();

-- IF문의 활용
DROP PROCEDURE IF EXISTS ifProc3;
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;
    DECLARE curDate DATE;
    DECLARE days INT;
    SELECT debut_date INTO debutDate
		FROM market_db.member
        WHERE mem_id = 'APN';
        
	SET curDATE = CURRENT_DATE();
    SET days = DATEDIFF(curDATE, debutDate);
    
    IF (days/365) >= 5 THEN
		SELECT CONCAT('데뷔한 지', days, '일이나 지났습니다. 핑순이들 축하합니다!');
	ELSE
		SELECT '데뷔한 지 ' + days + '일밖에 안되었네요. 핑순이들 화이팅~';
	END IF;
END $$
DELIMITER ;
CALL ifProc3();

-- CASE문 예시
DROP PROCEDURE IF EXISTS caseProc;
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT;
    DECLARE credit CHAR(1);
    SET point = 88;
    
    CASE
	WHEN point >= 90 THEN
		SET credit = 'A';
	WHEN point >= 80 THEN
		SET credit = 'B';
	WHEN point >= 70 THEN
		SET credit = 'C';
	WHEN point >= 60 THEN
		SET credit = 'D';
	ELSE
		SET credit = 'F';
	END CASE;
    SELECT CONCAT('취득점수==>', point), CONCAT('학점==>', credit);
END $$
DELIMITER ;
CALL caseProc();

-- 회원별로 총구맥 구하기
SELECT mem_id, SUM(price*amount) "총 구매액"
FROM buy
GROUP BY mem_id;

-- ORDER BY를 이용하여 총 구매액이 많은대로 정렬
SELECT mem_id, SUM(price*amount) "총 구매액"
FROM buy
GROUP BY mem_id
ORDER BY SUM(price*amount) DESC;

-- 내부조인을 사용하여 회원의 이름 출력
SELECT B.mem_id, M.mem_name, SUM(price*amount) "총 구매액"
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id
GROUP BY B.mem_id
ORDER BY SUM(price*amount) DESC;

-- 외부조인을 사용하여 구매하지 않은 회원의 이름과 아이디 출력
SELECT M.mem_id, M.mem_name, SUM(price*amount) "총 구매액"
FROM buy B
RIGHT OUTER JOIN member M
ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(price*amount) DESC;

-- CASE문을 사용하여 총 구매액에 따라 회원등급을 구분
CASE
WHEN (총구매액 >= 1500) THEN '최우수고객'
WHEN (총구매액 >= 1000) THEN '우수고객'
WHEN (총구매액 >= 1) THEN '일반고객'
ELSE '유령고객'
END

-- 전체 구문
SELECT M.mem_id, M.mem_name, SUM(price*amount) "총 구매액",
	CASE
		WHEN (SUM(price*amount) >= 1500) THEN '최우수고객'
		WHEN (SUM(price*amount) >= 1000) THEN '우수고객'
		WHEN (SUM(price*amount) >= 1) THEN '일반고객'
		ELSE '유령고객'
	END "회원등급"
FROM buy B
RIGHT OUTER JOIN member M
ON B.mem_id = M.mem_id
GROUP BY M.mem_id
ORDER BY SUM(price*amount) DESC;

-- WHILE문 예시: 1~100까지의 값을 모두 더하는 간단한 기능 구현
DROP PROCEDURE IF EXISTS whileProc;
DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    SET i = 1;
    SET hap = 0;
    
    WHILE (i <= 100) DO
		SET hap = hap + i;
        SET i = i + 1;
	END WHILE;
    SELECT '1부터 100까지의 합 ==>', hap;
END $$
DELIMITER ;
CALL whileProc();

-- WHILE문 응용, ITERATE, LEAVE문
DROP PROCEDURE IF EXISTS whileProc2;
DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
	DECLARE i INT;
    DECLARE hap INT;
    SET i = 1;
    SET hap = 0;
    
    myWhile:
    WHILE (i <= 100) DO
		IF (i%4 = 0) THEN
			SET i = i + 1;
            ITERATE myWhile;
		END IF;
        SET hap = hap + i;
        IF (hap > 1000) THEN
			LEAVE myWhile;
		END IF;
        SET i = i + 1;
	END WHILE;
    SELECT '1부터 100까지의 합(4의 배수 제외), 1000넘으면 종료 ==>', hap;
END $$
DELIMITER ;
CALL whileProc2();

-- 동적SQL: PREPARE와 EXECUTE 예제
use market_db;
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id = "BLK"';
EXECUTE myQuery;
DEALLOCATE PREPARE myQuery;

-- 동적 SQL 활용예시
DROP TABLE IF EXISTS gate_table;
CREATE TABLE gate_table (id INT AUTO_INCREMENT PRIMARY KEY, entry_time DATETIME);
SET @curDate = CURRENT_TIMESTAMP();
PREPARE myQuery FROM 'INSERT INTO gate_table VALUES(NULL, ?)';
EXECUTE myQuery USING @curDate;
DEALLOCATE PREPARE myQuery;
SELECT * FROM gate_table;






