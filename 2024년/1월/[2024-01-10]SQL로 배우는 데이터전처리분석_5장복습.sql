use mydata;
select `Division Name`, avg(Rating)
from dataset2
group by 1
order by 2 desc;

select `Department Name`, avg(Rating)
from dataset2
group by 1
order by 2 desc;

select *
from dataset2
where `Department Name` = 'Trend' and Rating <= 3;

select case when Age between 0 and 9 then '0009'
when Age between 10 and 19 then '1019'
when Age between 20 and 29 then '2029'
when Age between 30 and 39 then '3039'
when Age between 40 and 49 then '4049'
when Age between 50 and 59 then '5059'
when Age between 60 and 69 then '6069'
when Age between 70 and 79 then '7079'
when Age between 80 and 89 then '8089'
when Age between 90 and 99 then '9099' end Ageband,
Age
from dataset2
where `Department Name` = 'Trend'
and Rating <= 3;

select floor(Age/10)*10 Ageband, Age
from dataset2
where `Department Name` = 'Trend'
and Rating <= 3;

select floor(Age/10)*10 Ageband, count(*) Cnt
from dataset2
where `Department Name` = 'Trend'
and Rating <= 3
group by 1
order by 2 desc;

select floor(Age/10)*10 Ageband, count(*) Cnt
from dataset2
where `Department Name` = 'Trend'
group by 1
order by 2 desc;

select *
from dataset2
where `Department Name` = 'Trend' and Rating <= 3
and Age between 50 and 59 limit 10;

select `Department Name`, `Clothing ID`, avg(Rating) Avg_Rate
from dataset2
group by 1, 2;

select *,
row_number() over(partition by `Department Name` order by Avg_Rate) Rnk
from
(select `Department Name`, `Clothing ID`, avg(Rating) Avg_Rate
from dataset2
group by 1, 2) A;

select *
from
(select *,
row_number() over(partition by `Department Name` order by Avg_Rate) Rnk
from
(select `Department Name`, `Clothing ID`, avg(Rating) Avg_Rate
from dataset2
group by 1, 2) A) A
where Rnk <= 10;

create temporary table stat as
select *
from
(select *,
row_number() over(partition by `Department Name` order by Avg_Rate) Rnk
from
(select `Department Name`, `Clothing ID`, avg(Rating) Avg_Rate
from dataset2
group by 1, 2) A) A
where Rnk <= 10;

select `Clothing ID`
from stat
where `Department Name` = 'Bottoms';

select *
from dataset2
where `Clothing ID` in
(select `Clothing ID`
from stat
where `Department Name` = 'Bottoms')
order by `Clothing ID`;

select `Department name`, floor(Age/10)*10 Ageband,
avg(Rating) Avg_Rating
from dataset2
group by 1, 2;

select *,
row_number() over(partition by Ageband order by Avg_Rating) Rnk
from
(select `Department name`, floor(Age/10)*10 Ageband,
avg(Rating) Avg_Rating
from dataset2
group by 1, 2) A;

select *
from
(select *,
row_number() over(partition by Ageband order by Avg_Rating) Rnk
from
(select `Department name`, floor(Age/10)*10 Ageband,
avg(Rating) Avg_Rating
from dataset2
group by 1, 2) A) A
where Rnk = 1;

select `Review Text`, case when `Review Text` like '%size%' then 1 else 0 end Size_YN
from dataset2;

select sum(case when `Review Text` like '%size%' then 1 else 0 end) N_Size,
count(*) N_Total
from dataset2;

select sum(case when `Review Text` like '%size%' then 1 else 0 end) N_Size,
sum(case when `Review Text` like '%large%' then 1 else 0 end) N_Large,
sum(case when `Review Text` like '%loose%' then 1 else 0 end) N_Loose,
sum(case when `Review Text` like '%small%' then 1 else 0 end) N_Small,
sum(case when `Review Text` like '%tight%' then 1 else 0 end) N_Tight,
sum(1) N_Total
from dataset2;

select `Department Name`,
sum(case when `Review Text` like '%size%' then 1 else 0 end) N_Size,
sum(case when `Review Text` like '%large%' then 1 else 0 end) N_Large,
sum(case when `Review Text` like '%loose%' then 1 else 0 end) N_Loose,
sum(case when `Review Text` like '%small%' then 1 else 0 end) N_Small,
sum(case when `Review Text` like '%tight%' then 1 else 0 end) N_Tight,
sum(1) N_Total
from dataset2
group by 1;

select floor(Age/10)*10 Ageband, `Department Name`,
sum(case when `Review Text` like '%size%' then 1 else 0 end) N_Size,
sum(case when `Review Text` like '%large%' then 1 else 0 end) N_Large,
sum(case when `Review Text` like '%loose%' then 1 else 0 end) N_Loose,
sum(case when `Review Text` like '%small%' then 1 else 0 end) N_Small,
sum(case when `Review Text` like '%tight%' then 1 else 0 end) N_Tight,
sum(1) N_Total
from dataset2
group by 1, 2
order by 1, 2;

select floor(Age/10)*10 Ageband, `Department Name`,
sum(case when `Review Text` like '%size%' then 1 else 0 end)/sum(1) N_Size,
sum(case when `Review Text` like '%large%' then 1 else 0 end)/sum(1) N_Large,
sum(case when `Review Text` like '%loose%' then 1 else 0 end)/sum(1) N_Loose,
sum(case when `Review Text` like '%small%' then 1 else 0 end)/sum(1) N_Small,
sum(case when `Review Text` like '%tight%' then 1 else 0 end)/sum(1) N_Tight
from dataset2
group by 1, 2
order by 1, 2;

SELECT `Clothing ID`, SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE
FROM dataset2
GROUP BY 1;

create table size_stat as
SELECT `Clothing ID`,
SUM(CASE WHEN `Review Text` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE_T,
sum(case when `Review Text` like '%large%' then 1 else 0 end)/sum(1) N_Large,
sum(case when `Review Text` like '%loose%' then 1 else 0 end)/sum(1) N_Loose,
sum(case when `Review Text` like '%small%' then 1 else 0 end)/sum(1) N_Small,
sum(case when `Review Text` like '%tight%' then 1 else 0 end)/sum(1) N_Tight
from dataset2
group by 1;

select * from size_stat;