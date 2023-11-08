-- pivot the rows to columns and vice versa without using functions ---

select 
emp_id,
case when salary_component_type = 'salary' then val end as "salary",
case when salary_component_type = 'bonus' then val end as "bonus",
case when salary_component_type = 'hike_percent' then val end as "hike_percent"
from emp_compensation;

-- the above query will give below output

emp_id	salary	bonus	hike_percent
1	    10000		
1		        5000	
1			            10
2	    15000		
2		        7000	
2			            8
3	    12000		
3		        6000	
3			            7

-- but the sum with case and group by gives the expected output to convert from rows to columns --

select 
emp_id,
sum (case when salary_component_type = 'salary' then val end) as "salary",
sum(case when salary_component_type = 'bonus' then val end) as "bonus",
sum(case when salary_component_type = 'hike_percent' then val end) as "hike_percent"
from emp_compensation
group by emp_id;


-- create table from existing query ---
create table emp_compensation_pivot 
as
select 
emp_id,
sum (case when salary_component_type = 'salary' then val end) as "salary",
sum(case when salary_component_type = 'bonus' then val end) as "bonus",
sum(case when salary_component_type = 'hike_percent' then val end) as "hike_percent"
from emp_compensation
group by emp_id;

--- unpivot the table (from columns to rows ) using union---
select * from
(
select emp_id , 'salary' as salary_component_type, salary as val from  emp_compensation_pivot
union all
select emp_id , 'bonus' as salary_component_type, bonus as val from  emp_compensation_pivot
union all
select emp_id , 'hike_percent' as salary_component_type, hike_percent as val from  emp_compensation_pivot
)
order by emp_id



