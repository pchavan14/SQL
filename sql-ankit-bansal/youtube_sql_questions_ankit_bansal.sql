-- Reference -- https://www.youtube.com/watch?v=dOLBRfwzYcU&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E
--Problem 1st
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


--Problem 2nd
--https://www.youtube.com/watch?v=oGYinDMDfnA&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=3
-- write a sql to find total number of people present inside a hospital


with cte as
(
select emp_id , action , time , 
ROW_NUMBER() OVER (PARTITION BY emp_id ORDER BY time desc) as rn
from hospital
)
select count(*) as employee_numbers from cte where 
rn = 1 and action = 'in'

--approach 2

with cte as 
(
select emp_id ,
    max(case when action = 'in' then time end) as in_time,
    max(case when action = 'out' then time end) as out_time
from hospital
group by emp_id
)

select * from cte
where in_time > out_time or out_time is NULL


--Problem 3rd
--https://www.youtube.com/watch?v=PE5MZW1CxOI&list=PLBTZqjSKn0IfuIqbMIqzS-waofsPHMS0E&index=4

-- 1|2022-01-01|entire home,private room
-- 2|2022-01-02|entire home,shared room
-- 3|2022-01-02|private room,shared room
-- 4|2022-01-03|private room

-- string_split function in present in sql server which splits the comma seperated column into rows

select value from string_split('entire home,private room',',')

select value as room_type, count(*) as number_of_rooms from airbnb_searches
cross apply string_split(filter_room_types,',')

-- the below works in mysql , where locate shows the position of , and then we apply substring
SELECT room_1,
Count(room_1)
FROM   
(SELECT Substring(filter_room_types, 1,Locate(',', filter_room_types) - 1) As Room_1
        FROM   airbnb_searches
        UNION ALL
SELECT Substring(filter_room_types, Locate(',', filter_room_types) + 1) AS Room_1
        FROM   airbnb_searches
) AS tbl
GROUP  BY 1; 

-- Problem 4th
-- https://www.youtube.com/watch?v=Cbm6Hz_Yhwg

-- the 3rd highest salary in each department and in case there are less than 3 employees in each department,
-- then return employee details with lowest salary in that dep

with cte as
(
select emp_id , emp_name , salary, dep_id , dep_name , 
dense_rank() over (partition by dep_id order by salary desc) as rn,
count() over (partition by dep_id) as cnt -- this is IMP
from emp
)
select * from cte
where rn = 3 or (cnt < 3 and rn = cnt) -- instead of or we can use union as well




















