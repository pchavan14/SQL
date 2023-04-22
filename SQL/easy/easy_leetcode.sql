-- customers who never ordered
/* Write your PL/SQL query statement below */

SELECT C.NAME  AS CUSTOMERS
FROM CUSTOMERS C
LEFT JOIN
ORDERS O
ON C.ID = O.customerId
WHERE O.ID IS NULL