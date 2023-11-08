-- when we are doing = and != then we also need to consider NULL's in the columns which might be ignored by this

select name from customer
where referee_id != 2 or referee_id is NULL