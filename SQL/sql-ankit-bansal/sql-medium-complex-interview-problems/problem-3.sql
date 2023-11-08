-- write a sql to find the total number of people present in a place with columns action (in and out) and times
-- for each employee max(in_time) > max(out_time)


-- key is to split one value into multiple columns 
with temp as 
(
 select emp_id ,
 case when action = 'in' then time end as intime,
 case when action = 'out' then time end as outtime
 from hospital
)

select emp_id  
from temp
group by emp_id
having max(intime) > max(outtime) or max(outtime) is NULL


