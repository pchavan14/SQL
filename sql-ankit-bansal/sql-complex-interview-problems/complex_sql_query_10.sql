-- contagious dates ---

-- input -- 

date_value	state
2019-01-01	success
2019-01-02	success
2019-01-03	success
2019-01-04	fail
2019-01-05	fail
2019-01-06	success

-- the trick to solve this question is getting a common value to group by the records by dates -- 
-- when we have to group continous dates together we can subtract continous number from it --

-- we subtracted each row number days from the date column ---

SELECT *,
       ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value ASC) AS rn,
       DATE_SUB(date_value, INTERVAL ROW_NUMBER() OVER (PARTITION BY state ORDER BY date_value ASC) DAY) AS group_date
FROM tasks
ORDER BY date_value ASC;

