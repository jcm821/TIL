-- 조인해서 이름/주소/연락처 등을 검색
USE market_db;
SELECT * 
FROM buy INNER JOIN member
ON buy.mem_id = member.mem_id
WHERE buy.mem_id = 'GRL';

-- WHERE buy.mem_id = 'GRL'를 생략했을 경우
SELECT * 
FROM buy INNER JOIN member
ON buy.mem_id = member.mem_id;

-- 필요한 아이디/이름/구매 물품/주소/연락처만 추출하기
SELECT mem_id, mem_name, prod_name, addr, CONCAT(phone1, pthone2) '연락처'
FROM buy
INNER JOIN member
ON buy.mem_id = member.mem_id;

-- buy.mem_id로 수정한 명령어
SELECT buy.mem_id, mem_name, prod_name, addr, CONCAT(phone1, phone2) '연락처'
FROM buy
INNER JOIN member
ON buy.mem_id = member.mem_id;

-- SELECT 다음의 열(컬럼 이름)에도 모두 테이블_이름.열_이름 형식으로 작성
SELECT buy.mem_id, member.mem_name, buy.prod_name, member.addr, CONCAT(member.phone1, member.phone2) '연락처'
FROM buy
INNER JOIN member
ON buy.mem_id = member.mem_id;

-- 별칭을 사용한 구문
SELECT B.mem_id, M.mem_name, B.prod_name, M.addr, CONCAT(M.phone1, M.phone2) '연락처'
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id;

-- 전체 회원의 아이디/이름/구매한 제품/주소 출력
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id
ORDER BY M.mem_id;

-- DISTINCT문을 활용한 구문
SELECT DISTINCT M.mem_id, M.mem_name, M.addr
FROM buy B
INNER JOIN member M
ON B.mem_id = M.mem_id
ORDER BY M.mem_id;

-- 외부 조인을 이용하여 전체 회원의 구매 기록을 만들기
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM member M
LEFT OUTER JOIN buy B
ON M.mem_id = B.mem_id
ORDER BY M.mem_id;

-- RIGHT OUTER JOIN으로 동일하게 출력
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM buy B
RIGHT OUTER JOIN member M
ON M.mem_id = B.mem_id
ORDER BY M.mem_id;

-- 회원에게 가입만 하고, 한 번도 구매한 적이 없는 회원의 목록을 추출
SELECT DISTINCT M.mem_id, M.mem_name, B.prod_name, M.addr
FROM member M
LEFT OUTER JOIN buy B
ON M.mem_id = B.mem_id
WHERE B.prod_name IS NULL
ORDER BY M.mem_id;

-- 회원 테이블과 구매 테이블 상호 조인
SELECT *
FROM buy
CROSS JOIN member;

-- 샘플데이터를 이용하여 상호 조인
SELECT COUNT(*) '데이터 개수'
FROM sakila.inventory
CROSS JOIN world.city;

-- CREATE TABLE ~ SELECT문을 사용하여 대용량 테이블 생성







