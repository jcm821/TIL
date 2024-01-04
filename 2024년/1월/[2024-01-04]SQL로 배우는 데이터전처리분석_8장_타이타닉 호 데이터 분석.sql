USE mydata;
-- 10개의 데이터만 출력하여 데이터 확인
SELECT * FROM dataset4 LIMIT 10;

-- PassengerId에 중복이 존재하는지 확인
SELECT COUNT(PassengerId) N_Passengers,
COUNT(DISTINCT PassengerId) N_D_Passengers
FROM dataset4;

-- 성별에 따른 승객 수와 생존자 수
SELECT Sex, COUNT(PassengerId) N_Passengers, SUM(Survived) N_Survived
FROM dataset4
GROUP BY 1;

-- 성별 탑승객 수와 생존자 수의 비중
SELECT Sex, COUNT(PassengerId) N_Passengers, SUM(Survived) N_Survived,
SUM(Survived)/COUNT(PassengerId) Survived_Ratio
FROM dataset4
GROUP BY 1;

-- 10세 단위로 연령을 나누어 확인
SELECT FLOOR(Age/10)*10 Ageband, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1;

-- 오름차순하여 결과 정리
SELECT FLOOR(Age/10)*10 Ageband, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1
ORDER BY 1;

-- 연령에 성별을 추가해 생존율 확인
SELECT FLOOR(Age/10)*10 Ageband, Sex, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1, 2
ORDER BY 2, 1;

-- 위 결과를 2개 테이블(남성, 여성)로 구분
-- 남성
SELECT FLOOR(Age/10)*10 Ageband, Sex, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1, 2
HAVING Sex = 'male';

-- 여성
SELECT FLOOR(Age/10)*10 Ageband, Sex, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1, 2
HAVING Sex = 'female';

-- 2개 테이블을 서브쿼리로 생성하고 조인
SELECT A.Ageband, A.Survived_Rate Male_Survived_Rate,
B.Survived_Rate Female_Survived_Rate,
B.Survived_Rate - A.Survived_Rate Survived_Rate_Diff
FROM
(SELECT FLOOR(Age/10)*10 Ageband, Sex, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1, 2
HAVING Sex = 'male') A
LEFT JOIN
(SELECT FLOOR(Age/10)*10 Ageband, Sex, COUNT(PassengerId) N_Passengers,
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY 1, 2
HAVING Sex = 'female') B
ON A.Ageband = B.Ageband
ORDER BY A.Ageband;

-- 객실 등급의 값 확인
SELECT DISTINCT Pclass
FROM dataset4;

-- 객실 등급별로 승객 수와 생존자 수, 생존율 계산
SELECT Pclass, COUNT(PassengerId) N_Passengers, 
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY Pclass
ORDER BY 1;

-- 객실 등급과 성별을 조합하여 생존율 확인
SELECT Pclass, Sex, COUNT(PassengerId) N_Passengers, 
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY Pclass, Sex
ORDER BY 2, 1;

-- 객실 등급과 연령, 성별을 조합하여 생존율 확인
SELECT Pclass, Sex, FLOOR(Age/10)*10 Ageband, COUNT(PassengerId) N_Passengers, 
SUM(Survived) N_Survived, SUM(Survived)/COUNT(PassengerId) Survived_Rate
FROM dataset4
GROUP BY Pclass, Sex, FLOOR(Age/10)*10
ORDER BY 2, 1;

-- 승선 항구별 승객 수
SELECT Embarked, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1
ORDER BY 1;

-- 승선 항구별, 성별 승객 수
SELECT Embarked, Sex, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2
ORDER BY 1, 2;

-- 승선 항구별 전체 승객 수
SELECT Embarked, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1;

-- 승선 항구별, 성별 승객 수
SELECT Embarked, Sex, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2;

-- 테이블 결합
SELECT A.Embarked, A.Sex, A.N_Passengers,
B.N_Passengers N_Passengers_Tot, A.N_Passengers/B.N_Passengers Passengers_Rat
FROM
(SELECT Embarked, Sex, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2) A
LEFT JOIN
(SELECT Embarked, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1) B
ON A.Embarked = B.Embarked;

-- 출발지와 목적지별 승객 수
SELECT Boarded, Destination, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2
ORDER BY 3 DESC;

-- 탑승객 수로 순위 설정
SELECT *,
ROW_NUMBER() OVER(ORDER BY N_Passengers DESC) RNK
FROM
(SELECT Boarded, Destination, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2) BASE;

-- 상위 5개 경로를 선택 이후 해당 경로를 테이블로 생성
CREATE TEMPORARY TABLE route AS
SELECT Boarded, Destination
FROM
(SELECT *,
ROW_NUMBER() OVER(ORDER BY N_Passengers DESC) RNK
FROM
(SELECT Boarded, Destination, COUNT(PassengerId) N_Passengers
FROM dataset4
GROUP BY 1, 2) BASE) BASE
WHERE RNK BETWEEN 1 AND 5;

-- 테이블 확인
SELECT * FROM route;

-- 생성한 경로에 해당하는 승객들의 이름 추출
SELECT Name_wiki, A.Boarded, A.Destination
FROM dataset4 A
INNER JOIN route B
ON A.Boarded = B.Boarded AND A.Destination = B.Destination;

-- Hometown별 탑승객 수와 탑승객 대비 생존율
SELECT Hometown, SUM(1) N_Passengers, SUM(Survived)/SUM(1) Survived_Ratio
FROM dataset4
GROUP BY 1;

-- 탑승객 수가 10명 이상이면서 생존율이 0.5 이상인 Hometown 출력
SELECT Hometown, SUM(1) N_Passengers, SUM(Survived)/SUM(1) Survived_Ratio
FROM dataset4
GROUP BY 1
HAVING SUM(Survived)/SUM(1) >= 0.5 AND SUM(1) >= 10;










