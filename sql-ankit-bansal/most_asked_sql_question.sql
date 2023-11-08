-- greatest() and least() functions in postgresql and max() and min() in SQL

-- sample table input---

source      destination     cost
Mumbai      Pune            500
Pune        Mumbai          500
Mumbai      Solapur         800
Solapur     Mumbai          800


-- expected output --

source      destination     cost
Mumbai      Pune            500
Mumbai      Solapur         800

-- Way 1 ----
SELECT MAX(source,destination) as source , MIN(source,destination) as destination , max(cost) as cost
from travel_costs
group by MAX(source,destination) , MIN(source,destination)


-- Way 2 ---
-- assign a rank to the table and then do self join -- 
-- row_number() over()  - this statement just gives row number to all rows of the tables and then do a self join

with cte as 
(
 select * , row_number() over() as rn
 from travel_costs
)

select distinct a.* from cte a join cte b
on a.source = b.destination
and a.destination = b.source -- very important condition to avoid duplicates in the output
and a.rn < b.rn

-- Way 3 ---
-- Using subquery ---

select * 
from travel a
where NOT EXISTS (s
elect * from travel b 
on a.source = b.destination 
and a.destination = b.source 
and a.destination  > b.destination)







