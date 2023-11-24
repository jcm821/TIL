-- 스토어드 함수의 기본 형식
DELIMITER $$
CREATE FUNCTION 스토어드_함수_이름(매개변수)
	RETURNS 반환형식
BEGIN

	<프로그래밍 코드 작성부분>
    RETURN 반환값;
END $$
DELIMITER ;
SELECT 스토어드_함수_이름();

-- 스토어드 함수 생성 권한 허용
SET GLOBAL log_bin_trust_function_creators = 1;


-- 숫자 2개의 함계를 계산하는 스토어드 함수
USE market_db;
DROP FUNCTION IF EXISTS sumFunc;
DELIMITER $$
CREATE FUNCTION sumFunc(number1 INT, number2 INT)
	RETURNS INT
BEGIN
	RETURN number1 + number2;
END $$
DELIMITER ;

SELECT sumFunc(100, 200) AS '합계';

-- 데뷔 연도를 입력하면 활동 기간이 얼마나 되었는지 출력
DROP FUNCTION IF EXISTS calcYearFunc;
DELIMITER $$
CREATE FUNCTION calcYearFunc(dYear INT)
	RETURNS int
BEGIN
	DECLARE runYear INT;
    SET runYear = YEAR(CURDATE()) - dYear;
    RETURN runYear;
END $$
DELIMITER ;
SELECT calcYearFunc(2010) AS '활동 횟수';

-- SELECT ~ INTO ~를 이용하여 함수의 반환값을 각 변수에 저장 후, 그 차이를 계산해서 출력
-- 즉, 데뷔 연도와 활동 횟수 차이 출력
SELECT calcYearFunc(2007) INTO @debut2007;
SELECT calcYearFunc(2013) INTO @debut2013;
SELECT @debut2007-@debut2013 AS '2007과 2013 차이';

-- YEAR() 함수는 연도만 추출해주는 함수, calcYearFunc(연도)로 함수를 사용해서 각 회원별 활동 횟수 출력
SELECT mem_id, mem_name, calcYearFunc(YEAR(debut_date)) AS '활동 횟수'
FROM member;

-- 스토어드 함수의 내용 확인
SHOW CREATE FUNCTION 함수_이름;

-- 함수의 삭제
DROP FUNCTION calcYearFunc;

-- DEFAULT문을 사용해서 초기값을 0으로 설정
DECLARE memNumber INT;
DECLARE cnt INT DEFAULT 0;
DECLARE totNumber INT DEFAULT 0;

-- 행의 끝을 파악하기 위한 변수 endOfRow준비
DECLARE endOfRow BOOLEAN DEFAULT FALSE;

-- 커서 선언
DECLARE memberCursor CURSOR FOR
SELECT mem_number FROM member;

-- 반복 조건 선언
DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET endOfRow = TRUE;
    
-- 커서 열기
OPEN memberCursor;

-- 행 반복하기
cursor_loop: LOOP
이 부분 반복
END LOOP cursor_loop

-- 반복문을 빠져나갈 조건 필요
IF endOfRow THEN
	LEAVE cursor_loop;
END IF;

-- 반복할 부분을 전체 표현
cursor_loop: LOOP
	FETCH memberCursor INTO memNumber;
    
    IF endOfRow THEN
		LEAVE cursor_loop;
	END IF;
    
    SET cnt = cnt + 1;
    SET totNumber = totNumber + memNumber;
END LOOP cursor_loop;

-- 통합 코드
USE market_db;
DROP PROCEDURE IF EXISTS cursor_proc;
DELIMITER $$
CREATE PROCEDURE cursor_proc()
BEGIN
	DECLARE memNumber INT;
	DECLARE cnt INT DEFAULT 0;
	DECLARE totNumber INT DEFAULT 0;
	DECLARE endOfRow BOOLEAN DEFAULT FALSE;

	DECLARE memberCursor CURSOR FOR
		SELECT mem_number FROM member;

	DECLARE CONTINUE HANDLER
		FOR NOT FOUND SET endOfRow = TRUE;

	OPEN memberCursor;
    
    cursor_loop: LOOP
		FETCH memberCursor INTO memNumber;
    
		IF endOfRow THEN
			LEAVE cursor_loop;
		END IF;
    
		SET cnt = cnt + 1;
		SET totNumber = totNumber + memNumber;
	END LOOP cursor_loop;
    
	SELECT (totNumber/cnt) AS '회원의 평균 인원 수';
    
    CLOSE memberCursor;
END $$
DELIMITER ;





