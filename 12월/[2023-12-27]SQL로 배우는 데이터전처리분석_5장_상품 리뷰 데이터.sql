-- division name별 평균 평점
USE mydata
SELECT `Division Name`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- department별 평균 평점
SELECT 	`Department Name`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- Trend의 평점 3점 이하 리뷰
SELECT *
FROM dataset2
WHERE `Department Name` = 'Trend' AND Rating <= 3;

-- case when을 이용하여 연령을 10세 단위로 그룹핑
SELECT CASE WHEN Age between 0 and 9 then '0009'
WHEN Age between 10 and 19 then '1019'
WHEN Age between 20 and 29 then '2029'
WHEN Age between 30 and 39 then '3039'
WHEN Age between 40 and 49 then '4049'
WHEN Age between 50 and 59 then '5059'
WHEN Age between 60 and 69 then '6069'
WHEN Age between 70 and 79 then '7079'
WHEN Age between 80 and 89 then '8089'
WHEN Age between 90 and 99 then '9099' END AGEBAND,
AGE
FROM dataset2
WHERE `Department Name` = 'Trend' AND Rating <= 3;

-- floor를 사용하여 연령을 10세 단위로 그룹핑
SELECT FLOOR(Age/10)*10 AGEBAND, AGE
FROM dataset2
WHERE `Department Name` = 'Trend' AND Rating <= 3;

-- Trend의 평점 3점 이하 리뷰의 연령 분포
SELECT FLOOR(Age/10)*10 AGEBAND, COUNT(*) CNT
FROM dataset2
WHERE `Department Name` = 'Trend' AND Rating <= 3
GROUP BY 1
ORDER BY 2 DESC;

-- Trend의 전체 연령별 리뷰 수 분포
SELECT FLOOR(Age/10)*10 AGEBAND, COUNT(*) CNT
FROM dataset2
WHERE `Department Name` = 'Trend'
GROUP BY 1
ORDER BY 2 DESC;

-- 50대 3점 이하 Trend 리뷰
SELECT *
FROM dataset2
WHERE `Department Name` = 'Trend' AND Rating <= 3
AND Age between 50 and 59 LIMIT 10;

-- Department Name, Clothing Name별 평균 평점 계산
SELECT `Department Name`, `Clothing ID`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1, 2;

-- Department별 순위 생성
SELECT *, ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_Rate) RNK
FROM
(SELECT `Department Name`, `Clothing ID`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1, 2) A; 

-- 1~10위 데이터 조회
SELECT *
FROM
(SELECT *, ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_Rate) RNK
FROM
(SELECT `Department Name`, `Clothing ID`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1, 2) A) A
WHERE RNK <= 10;

-- Department별 평균 평점이 낮은 10개 상품
CREATE TEMPORARY TABLE stat AS
SELECT *
FROM
(SELECT *, ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_Rate) RNK
FROM
(SELECT `Department Name`, `Clothing ID`, AVG(Rating) AVG_Rate
FROM dataset2
GROUP BY 1, 2) A) A
WHERE RNK <= 10;

-- Bottoms의 평점이 낮은 10개 상품의 Clothing ID를 조회
SELECT `Clothing ID`
FROM stat
WHERE `Department Name` = 'Bottoms';

-- Clothing ID에 해당하는 리뷰 내용을 조회
SELECT *
FROM dataset2
WHERE `Clothing ID` IN
(SELECT `Clothing ID` FROM stat
WHERE `Department Name` = 'Bottoms')
ORDER BY `Clothing ID`;

-- Department별 가장 낮은 점수를 계산, Department Name과 연령으로 그룹핑한 뒤, 평점을 평균
SELECT `Department Name`, FLOOR(Age/10)*10 AGEBAND,
AVG(Rating) AVG_Rating
FROM dataset2
GROUP BY 1, 2;

-- 연령별로 생성한 점수를 기준으로 Rank를 계산
SELECT *,
ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_Rating) RNK
FROM
(SELECT `Department Name`, FLOOR(Age/10)*10 AGEBAND,
AVG(Rating) AVG_Rating
FROM dataset2
GROUP BY 1, 2) A;

-- Rank값이 1인 값을 조회
SELECT *
FROM
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_Rating) RNK
FROM
(SELECT `Department Name`, FLOOR(Age/10)*10 AGEBAND,
AVG(Rating) AVG_Rating
FROM dataset2
GROUP BY 1, 2) A) A
WHERE RNK = 1;

-- Size가 포함된 리뷰의 수를 구하기
SELECT `Review Text`,
CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END SIZE_YN
FROM dataset2;

-- count(*)를 이용하여 REVIEW Text 중 size가 포함된 리뷰의 수
SELECT sum(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
COUNT(*) N_TOTAL
FROM dataset2;

-- Large, Loose, Small, Tight로 상세히 나누어 확인
SELECT SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) N_TIGHT,
SUM(1) N_TOTAL
FROM dataset2;

-- 카테고리별로 해당 수치 확인
SELECT `Department Name`,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) N_TIGHT,
SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1;

-- 연령별로 나누어 수치 확인
SELECT FLOOR(Age/10)*10 AGEBAND, `Department Name`,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) N_TIGHT,
SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1, 2
ORDER BY 1, 2;

-- 세부 그룹의 비중을 구하기
SELECT FLOOR(Age/10)*10 AGEBAND, `Department Name`,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1) N_TIGHT,
SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1, 2
ORDER BY 1, 2;

-- 상품 ID별로 사이즈와 관련된 리뷰 수를 계산하고, 사이즈 타입별로 리뷰 수를 다시 집계
SELECT `Clothing ID`, SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE
FROM dataset2
GROUP BY 1;

-- 사이즈 타입을 추가하여 집계
SELECT `Clothing ID`, SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE_T,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1) N_TIGHT
FROM dataset2
GROUP BY 1;

-- 앞선 결과를 SIZE_STAT이라는 이름의 테이블에 저장
CREATE TABLE size_statsize_stat AS
SELECT `Clothing ID`, SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE_T,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1) N_SIZE,
SUM(CASE WHEN `Review Text` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1) N_LARGE,
SUM(CASE WHEN `Review Text` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1) N_LOOSE,
SUM(CASE WHEN `Review Text` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1) N_SMALL,
SUM(CASE WHEN `Review Text` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1) N_TIGHT
FROM dataset2
GROUP BY 1;

select * from size_stat;



