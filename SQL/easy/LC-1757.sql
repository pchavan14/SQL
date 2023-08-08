-- to calculate percentage of certain products

-- percentage of certain products is equivalent to average , when both numerator and denominator are integer in division
-- the output is also integer which might come as 0 , to avoid it cast a certain number as decimal

SELECT 
(avg(case when low_fats = 'Y' then 1 else 0 end)) * 100 as  "percentage"
from products

SELECT 
cast(SUM(CASE WHEN low_fats = 'Y' THEN 1 ELSE 0 END) as FLOAT) / COUNT(*) AS ratio_low_fats
from products

-- these are two ways in which we can calculate percentage or average