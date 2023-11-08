-- customer bought a certain product (Photoshop), but the revenue will be excluding that product --

select * from adobe_transactions
where product = 'Photoshop' ; -- here I will lose the data even with !=

-- by using in operator 
select customer_id, sum(revenue) from adobe_transactions
where customer_id in 
(
    select customer_id from adobe_transactions
    where product = 'Photoshop'
)
and product!='Photoshop'
group by customer_id

-- by using exists operator (co-related query)

select customer_id, sum(revenue) from adobe_transactions a
where customer_id exists
(
    select 1 from adobe_transactions b
    where product = 'Photoshop' and a.customer_id = b.customer_id
)
and product!='Photoshop'
group by customer_id

exists - this opeartor returns TRUE is the subquery return one or more records

Corelated vs nested queries - With a normal nested subquery, the inner SELECT query runs
 first and executes once, returning values to be used by the main query. 
 A correlated subquery, however, executes once for each candidate row considered by the outer query. 
 In other words, the inner query is driven by the outer query.