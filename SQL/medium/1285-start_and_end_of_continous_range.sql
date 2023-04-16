/* Write your PL/SQL query statement below */


WITH CTE AS 
(
    SELECT LOG_ID,
    ROW_NUMBER() OVER (order by log_id) as RN
    FROM LOGS
)

SELECT MIN(LOG_ID) AS START_ID , MAX(LOG_ID) AS END_ID
FROM CTE
GROUP BY LOG_ID - RN
ORDER BY START_ID