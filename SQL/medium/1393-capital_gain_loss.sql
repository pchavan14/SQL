--case statement can be used within a sum statement
--we can do row-level operations within aggregated functions during group by queries

--we do not need to have end as , can only end as we are already aliasing the column
SELECT STOCK_NAME , 
SUM
(
    CASE WHEN OPERATION = 'Buy' THEN -PRICE
    ELSE PRICE
    END 
)
AS CAPITAL_GAIN_LOSS
FROM STOCKS
GROUP BY STOCK_NAME