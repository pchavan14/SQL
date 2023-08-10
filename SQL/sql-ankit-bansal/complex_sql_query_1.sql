-- Input table --

Team_1	Team_2	Winner
India	SL	India
SL	Aus	Aus
SA	Eng	Eng
Eng	NZ	NZ
Aus	India	India

-- Find number of matches , win and loses for each team -- 
-- first step to create a cte union all to get all teams --
with cte as 
(
select team_1 as team, case when winner = team_1 then 1 else 0 end as win_flag
from icc_world_cup
union all
select team_2 as team, case when winner = team_2 then 1 else 0 end as win_flag
from icc_world_cup
);

-- then later get all the required column values ---
select team,count(*) as no_matches_played , 
sum(win_flag) as wins , 
count(*) - sum(win_flag) as loses
from cte
group by team

-- output -- 
team	no_matches_played	wins	loses
India	2	2	0
SL	2	0	2
SA	1	0	1
Eng	2	1	1
Aus	2	1	1
NZ	1	1	0