-- How to find duplicates in a given table
-- Whenever we have to find duplicates in a table we can do count(*) and group by on that column

-- count() expression also counts NULLS
select emp_id , count(1)
from employees
group by emp_id
having count(1) > 1

-- How to delete the duplicates (we can use a window function)

with cte as 
(
    select * ,
    row_number() over (partition by emp_id order by emp_id) as rn
    from employees
)

delete from cte 
where rn > 1

-- difference between union and union all
-- Union will remove all the duplicates and union all will have everything

-- employees who are not present in department table

-- this is a sub query so performance is not good , avoid it
select * from employees
where dept_id not in (select dept_id from departments)

--other way is left join (all the records are shown from left table and only matching records from right with others shown as NULL)

select employees.emp_id ,employees.dept_id , department.dept_id
from employees
left join
department
on employees.dept_id = department.dept_id
where department.dept_id is NULL

-- second highest salary in each dept
with cte as 
(
    select emp_id , dept_id 
    dense_rank() over (partition by dept_id order by salary desc) as rn -- we are using here dense rank as two employees can have similar salaries
    from employees
)
select emp_id, dept_id from cte where rn = 2

-- find all the transactions done by a person (ex . Shilpa) , query case sensitive names

select * from orders where upper(customer_name) = 'SHILPA'

-- self join table , manager salary > employee salary


-- difference between the types of joins

-- update query to swap gender or any other columns use case statement

update orders set customer_gender = case when customer_gender = 'Male' then 'Female'
                                         when customer_gender = 'Female' then 'Male' end








