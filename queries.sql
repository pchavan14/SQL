--query to get the records present in table customers but not in table orders
select a.cust_code , b.cust_code from 
customer a
left join 
orders b
on a.cust_code = b.cust_code
where b.cust_code is NULL

--sql query to get max count record in top ten records
with cte as
(
select cust_name , OUTSTANDING_AMT
from customer
order by OUTSTANDING_AMT desc
limit 10
)
select cust_name , count(OUTSTANDING_AMT)
from cte
group by cust_name
order by count(OUTSTANDING_AMT) desc
limit 1


--can use the CONNECT BY clause to retrieve all the employees in the hierarchy 
---starting from a particular manager
SELECT employee_name, level
FROM employees
WHERE employee_name <> 'Jane Doe'
START WITH employee_id = 2
CONNECT BY PRIOR employee_id = manager_id;

--remove duplicates from a table
with cte as
(
select * , row_number() over (partition by cust_code order by grade) as rn
from customer
)
select * from cte
where rn = 1
