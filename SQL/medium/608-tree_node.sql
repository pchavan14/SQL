/* Write your PL/SQL query statement below */

SELECT ID,
CASE 
    WHEN P_ID IS NULL THEN 'Root'
    WHEN ID NOT IN (SELECT DISTINCT P_ID FROM TREE WHERE p_id IS NOT NULL) THEN 'Leaf'
    ELSE 'Inner'
END AS Type
FROM TREE

