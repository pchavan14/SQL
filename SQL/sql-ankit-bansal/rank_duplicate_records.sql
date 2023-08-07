-- input --
id 
a 
a 
b 
c 
c 
c

-- expected output --
input output
a      DUP1
a      DUP1
b      NULL
c      DUP2
c      DUP2
c      DUP2

-- rank the duplicate records
-- if we use dense_rank , the b will be ranked as DUP2 and so on which is a incorrect outpt

with cte_dups as
(
select id from List
group by id
having count(1) > 1
),
cte_rank as (select id , rank() over (order by id) as rn from cte_dups)

select a.id as input , 'DUP' || b.rn as output
from List a
left join cte_rank b
on a.id = b.id

