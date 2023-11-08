select a.* 
from emp_salary a
join temp b
on a.dept_id = b.dept_id and a.salary = b.salary
order by a.dept_id

-- Left join is used for more optimizations in a SQL code 

with temp as
(
select dept_id , salary, count(salary)
from emp_salary
group by dept_id , salary
having count(salary) = 1
)

select a.* 
from emp_salary a
left join temp b
on a.dept_id = b.dept_id and a.salary = b.salary
where b.dept_id is NULL
order by a.dept_id

-- Inner join can be converted into left join based on needs

-- this can also be solve using CTE

with cte as 
(
select * , 
count(*) over (partition by salary , dept_id) as rn
from emp_salary
)

select * from cte 
where rn > 1