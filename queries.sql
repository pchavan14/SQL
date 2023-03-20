--query to get the records present in table customers but not in table orders
select a.cust_code , b.cust_code from 
customer a
left join 
orders b
on a.cust_code = b.cust_code
where b.cust_code is NULL