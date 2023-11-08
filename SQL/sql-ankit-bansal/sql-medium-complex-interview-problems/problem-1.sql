-- write a query to find no of gold medal per swimmer for swimmer 
-- who won only gold medals

-- Option 1 
with cte as 
(
select gold as player_name, count(*) as no_of_gold_won
from events
group by 1
)

select * from cte where player_name not in (
  select silver as player_name from events
  union all
  select bronze as player_name from events
)

-- Option 2

select gold as player_name, count(*) as no_of_gold_won
from events
where gold not in 
(
  select silver as player_name from events
  union all
  select bronze as player_name from events
)
group by 1

-- we have used union all instead of union because union executes slower as it 
-- checks for all duplicates

-- Option 3

with cte as 
(
select gold as player_name , 'gold' as medal_type from events
union all
select silver as player_name , 'silver' as medal_type from events
union all
select bronze as player_name , 'bronze' as medal_type from events
)

select player_name , count(*) as no_of_medals_won
from cte
group by player_name
having count(distinct medal_type) = 1 and min(medal_type) = 'gold'

-- here we have used distinct because the player might have won many gold medals



