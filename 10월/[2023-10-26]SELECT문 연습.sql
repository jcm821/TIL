-- 전체 열을 불러오기 --
USE market_db;
SELECT * FROM member;

-- 필요한 열을 불러오기 --
SELECT mem_name FROM member;

-- 여러 열을 불러오기 --
SELECT addr, debut_date, mem_name FROM member;

-- 열 이름의 별칭 --
SELECT addr 주소, debut_date '데뷔 일자' , mem_name FROM member;

-- 이름이 블랙핑크인 결과 출력 --
SELECT * FROM member WHERE mem_name = '블랙핑크';

-- 인원이 4명인 회원 출력 --
SELECT * FROM member WHERE mem_number = 4;

-- 평균 키가 162 이하인 회원 검색 --
SELECT mem_id, mem_name FROM member WHERE height <= 162;

-- AND연산자: 두 가지 이상의 조건 검색 - 평균 키가 165이상이면서 인원도 6명 초과인 회원 --
SELECT mem_name, height, mem_number FROM member WHERE height > 165 AND mem_number > 6;

-- OR연산자 사용 
SELECT mem_name, height, mem_number FROM member WHERE height > 165 OR mem_number > 6;

-- AND를 사용하여 평균 키가 163에서 165인 회원 조회 --
SELECT mem_name, height 
FROM member 
WHERE height >= 163 AND height <= 165;

-- BETWEEN AND 구문 사용 --
SELECT mem_name, height 
FROM member
WHERE height BETWEEN 163 AND 165;

-- OR를 사용하여 경기/전남/경남 중 한곳에 사는 회원을 검색 --
SELECT mem_name, addr
FROM member
WHERE addr = '경기' OR addr = '전남' OR addr = '경남';

SELECT mem_name, addr
FROM member
WHERE addr IN('경기', '전남', '경남');

-- LIKE를 사용하여 이름의 첫글자가 '우'로 시작하는 회원 검색 --
SELECT *
FROM member
WHERE mem_name LIKE '우%';

-- 언더바(_)를 사용하여 앞의 두글자는 상관없고 뒤는 '핑크'인 회원 검색 --
SELECT *
FROM member
WHERE mem_name LIKE '__핑크';

-- 에이핑크의 평균키 --
SELECT height
FROM member
WHERE mem_name = '에이핑크';

-- 164보다 키가 큰 회원을 조회 --
SELECT mem_name, height
FROM member
WHERE height > 164;

-- 서브쿼리 수행 --
SELECT mem_name, height
FROM member
WHERE height > (SELECT height FROM member WHERE mem_name = '에이핑크');

-- 키가 165이상이고 멤버 수가 4명 이상인 회원 -
SELECT *
FROM member
WHERE height >= 165 AND mem_number >= 4;

SELECT mem_name, height
FROM member
WHERE height >= 165 AND mem_number >= 4;

-- 그룹이 레드벨벳인 사람의 그룹명과 데뷔날짜 추출 --
SELECT * FROM member;
SELECT mem_name, debut_date
FROM member
WHERE mem_name = '레드벨벳';

-- 데뷔날짜가 2013-12-31에서 2016-03-01사이인 사람 --
SELECT *
FROM member
WHERE debut_date BETWEEN '2013-12-31' AND '2016-03-01';

SELECT *
FROM member
WHERE debut_date > '2013-12-31' AND debut_date < '2016-03-01';

-- 주소가 서울이거나 경기인 사람 --
SELECT *
FROM member
WHERE addr IN('서울', '경기');

SELECT * 
FROM member 
WHERE addr = '서울' OR addr = '경기';

-- 그룹명 중간에 '이'가 들어가는 사람 --
SELECT *
FROM member
WHERE mem_name LIKE '%이%';

-- 그룹명이 '소'로 시작하는 사람 --
SELECT *
FROM member
WHERE mem_name LIKE '소%';

SELECT *
FROM member
WHERE mem_name LIKE '소녀__';

-- 그룹명이 '잇'으로 시작하는 사람 --
SELECT * 
FROM member
WHERE mem_name LIKE '잇%';

SELECT * 
FROM member
WHERE mem_name LIKE '잇_';






