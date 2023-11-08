-- the pareto principle states that for many outcomes , roughly 80% of consequences comes from 20% of the causes ---

-- which 20% products are giving 80 % of sales --

-- Input --
product_id	product_sales
1	781.00
2	362.00
3	267.00
4	761.00
5	544.00
6	337.00
7	856.00
8	467.00
9	566.00
10	430.00
11	152.00

-- to get 80% of total sales we use below query --

select 0.80 * sum(product_sales) from product_sales

-- how to calculate running query in MySQL --

SELECT
    product_id,
    product_sales,
    (@running_total := @running_total + product_sales) AS running_total
FROM
    product_sales,
    (SELECT @running_total := 0) AS rt
ORDER BY product_sales desc

-- comparison query -- 

select * FROM
(
SELECT
    product_id,
    product_sales,
    (@running_total := @running_total + product_sales) AS running_total
FROM
    product_sales,
    (SELECT @running_total := 0) AS rt
ORDER BY product_sales desc) a 
where a.running_total <= (select 0.80 * sum(product_sales) from product_sales);

--- in Postgres SQL we can use SUM() windown function -- 
select 
product_id , 
product_sales,
SUM(product_sales) OVER (order by product_sales desc ) as running_total
from 
product_sales
order by 
product_sales DESC

