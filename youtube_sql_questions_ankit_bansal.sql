-- Reference -- https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E

-- write a query to find no of gold medal per swimmer for swimmer who won only gold medals

-- 1|100m|2016|Amthhew Mcgarray|donald|barbara
-- 2|200m|2016|Nichole|Alvaro Eaton|janet Smith
-- 3|500m|2016|Charles|Nichole|Susana
-- 4|100m|2016|Ronald|maria|paula
-- 5|200m|2016|Alfred|carol|Steven
-- 6|500m|2016|Nichole|Alfred|Brandon
-- 7|100m|2016|Charles|Dennis|Susana
-- 8|200m|2016|Thomas|Dawn|catherine
-- 9|500m|2016|Thomas|Dennis|paula
-- 10|100m|2016|Charles|Dennis|Susana
-- 11|200m|2016|jessica|Donald|Stefeney
-- 12|500m|2016|Thomas|Steven|Catherine


-- approach first
select 
GOLD as "person_name",
count(*) as medals
from events
where GOLD not in 
( select SILVER 
from events
union all
select BRONZE
from events
)
group by GOLD

-- approach second
with cte as
(
select gold as player_name , 'gold' as medal_type
from events
union all
select silver, 'silver' as medal_type
from events
union all
select bronze, 'bronze' as medal_type
from events
)

select player_name ,count(*) as no_of_gold_medals
from cte
group by player_name 
having max(medal_type) = 'gold'




