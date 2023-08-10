-- Finding new and repeat customers --

-- aggregation with the case statements --- 

order_id	customer_id	order_date	order_amount
    1	100	2022-01-01	2000
    2	200	2022-01-01	2500
    3	300	2022-01-01	2100
    4	100	2022-01-02	2000
    5	400	2022-01-02	2200
    6	500	2022-01-02	2700
    7	100	2022-01-03	3000
    8	400	2022-01-03	1000
    9	600	2022-01-03	3000

-- first step to create a cte and rank --
with cte as
(
select customer_id , 
order_date , 
row_number() over (partition by customer_id order by order_date asc) as rn 
from customer_orders
);

-- use the sum over case statement on cte -- 
select order_date , 
sum(case when rn = 1 then 1 else 0 end) as new_customer_count , 
sum(case when rn > 1 then 1 else 0 end) as repeat_customer_count
from cte
group by order_date

-- Output ---
order_date	new_customer_count	repeat_customer_count
2022-01-01	3	0
2022-01-02	2	1
2022-01-03	1	2

