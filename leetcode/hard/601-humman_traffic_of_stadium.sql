-- when consecutive rows we can create a row_number and have a difference between these columns 

with cte as
(
SELECT * ,
ROW_NUMBER() OVER (ORDER BY visit_date) as rn,
id - ROW_NUMBER() OVER (ORDER BY visit_date) as grp
from stadium
where people >= 100
)

select id,visit_date, people from cte
where grp in 
(
select grp 
from cte
group by grp
having count(grp) >=3
)