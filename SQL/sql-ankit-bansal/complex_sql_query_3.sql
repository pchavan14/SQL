name	address	email	floor	resources
A	Bangalore	A@gmail.com	1	CPU
A	Bangalore	A1@gmail.com	1	CPU
A	Bangalore	A2@gmail.com	2	DESKTOP
B	Bangalore	B@gmail.com	2	DESKTOP
B	Bangalore	B1@gmail.com	2	DESKTOP
B	Bangalore	B2@gmail.com	1	MONITOR


-- how many times the person visited the floor ---
-- go step by step create multiple cte's and join them later to get final output -- 

-- below we got the floor visits for each person --
select name , floor , count(floor) as no_of_floor_visit
from entries
group by name , floor

-- to get the maximum number of visits we can use rank function , which can have count() value)
with floor_visit as 
(
select name , floor , count(floor) as no_of_floor_visit,
rank() over (partition by name order by count(floor) desc) as rn 
from entries
group by name , floor
)

select name , floor 
from floor_visit
where rn = 1

-- the above select gives which floor was visited the most --- 

-- to get the distinct resources used -- 
select name , count(1) as total_visits,group_concat(distinct resources SEPARATOR ',') as resources_used
from entries
group by name

--  query with multiple cte's ---
with floor_visit as 
(
select name , floor , count(floor) as no_of_floor_visit,
rank() over (partition by name order by count(floor) desc) as rn 
from entries
group by name , floor
),
total_visits as
(
select name , count(1) as total_visits,group_concat(distinct resources SEPARATOR ',') as resources_used
from entries
group by name
)

-- join condition to get required columns --
select fv.name , fv.floor as most_visited_floor, tv.total_visits, tv.resources_used
from floor_visit fv 
inner join total_visits tv 
on fv.name = tv.name
and fv.rn = 1;

--  we can use distinct inside group_concat() function itself to avoid duplicate records ---

-- final query -- 
with floor_visit as 
(
select name , floor , count(floor) as no_of_floor_visit,
rank() over (partition by name order by count(floor) desc) as rn 
from entries
group by name , floor
),
total_visits as
(
select name , count(1) as total_visits,group_concat(distinct resources SEPARATOR ',') as resources_used
from entries
group by name
)
select fv.name , fv.floor as most_visited_floor, tv.total_visits, tv.resources_used
from floor_visit fv 
inner join total_visits tv 
on fv.name = tv.name
and fv.rn = 1;


