-- 스토어드 프로시저 기본 형식
DELIMITTER $$
CREATE PROCEDURE 스토어드_프로시저_이름(IN 또는 OUT 매개변수)
BEGIN
<코드 작성 부분>
END $$
DELIMITER ;

-- 스토어드 프로시저 생성
USE market_db;
DROP PROCEDURE IF EXISTS user_proc;
DELIMITER $$
CREATE PROCEDURE user_proc()
BEGIN
    SELECT * FROM member;
END $$
DELIMITER ;

CALL user_proc();

-- 스토어드 프로시저 삭제
DROP PROCEDURE user_proc;


-- 입력 매개변수 지정 형식
IN 입력_매개변수_이름 데이터_형식

-- 입력 매개변수가 있는 스토어드 프로시저를 실행하기 위해서 괄호 안에 값 전달
CALL 프로시저_이름(전달 값);

-- 출력 매개변수 형식
OUT 출력_매개변수_이름 데이터_형식

-- 출력 매개변수가 있는 스토어드 프로시저를 실행
CALL 프로시저_이름(@변수명);
SELECT @변수명;

-- 입력 매개변수 활용
USE market_db;
DROP PROCEDURE IF EXISTS user_proc1;
DELIMITER $$
CREATE PROCEDURE user_proc1(IN userName VARCHAR(10))
BEGIN
  SELECT * FROM member WHERE mem_name = userName; 
END $$
DELIMITER ;

CALL user_proc1('에이핑크');

-- 2개의 입력 매개변수가 있는 스토어드 프로시저
DROP PROCEDURE IF EXISTS user_proc2;
DELIMITER $$
CREATE PROCEDURE user_proc2(
    IN userNumber INT, 
    IN userHeight INT  )
BEGIN
  SELECT * FROM member 
    WHERE mem_number > userNumber AND height > userHeight;
END $$
DELIMITER ;

CALL user_proc2(6, 165);

-- 출력 매개변수 활용
DROP PROCEDURE IF EXISTS user_proc3;
DELIMITER $$
CREATE PROCEDURE user_proc3(
	IN txtValue CHAR(10),
    OUT outValue INT	)
BEGIN
	INSERT INTO noTable VALUES(NULL, txtValue);
    SELECT MAX(id) INTO outValue FROM noTable;
END $$
DELIMITER ;

DESC noTable;

CREATE TABLE IF NOT EXISTS noTable(
id INT AUTO_INCREMENT PRIMARY KEY,
txt CHAR(10)
);

-- 스토어드 프로시저 호출
CALL user_proc3 ('테스트1', @myValue);
SELECT CONCAT('입력된 ID 값 ==>', @myValue);


-- IF ~ ELSE 문을 활용한 프로그래밍
DROP PROCEDURE IF EXISTS ifelse_proc;
DELIMITER $$
CREATE PROCEDURE ifelse_proc(
	IN memName VARCHAR(10)
)
BEGIN
	DECLARE debutYear INT;  -- 변수선언
    SELECT YEAR(debut_date) into debutYear FROM member
		WHERE mem_name = memName;
	IF (debutYear >= 2015) THEN
		SELECT '신인 가수네요. 화이팅 하세요.' AS '메시지';
	ELSE
		SELECT '고참 가수네요. 그동안 수고하셨어요.' AS '메시지';
	END IF;
END $$
DELIMITER ;

CALL ifelse_proc('오마이걸');

-- while문 활용한 스토어드 프로시저
DROP PROCEDURE IF EXISTS while_proc;
DELIMITER $$
CREATE PROCEDURE while_proc()
BEGIN
	DECLARE hap INT;
    DECLARE num INT;
    SET hap = 0;
    SET num = 1;
    
    WHILE (num <= 100) DO -- 100까지 반복
		SET hap = hap + num;
        SET num = num + 1; -- 숫자증가
	END WHILE;
    SELECT hap AS '1~100 합계';
END $$
DELIMITER ;

CALL while_proc();

-- 동적 SQL 활용
DROP PROCEDURE IF EXISTS dynamic_proc;
DELIMITER $$
CREATE PROCEDURE dynamic_proc(
	IN tableName VARCHAR(20)
)
BEGIN
	SET @sqlQuery = CONCAT('SELECT * FROM ', tableName);
    PREPARE myQuery FROM @sqlQuery;
    EXECUTE myQuery;
    DEALLOCATE PREPARE myQuery;
END $$
DELIMITER ;

CALL dynamic_proc ('member');







