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
