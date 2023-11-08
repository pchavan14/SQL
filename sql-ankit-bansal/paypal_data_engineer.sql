

In summary, AND is used to specify conditions 
for the join itself, while WHERE is used to filter the 
result set after the join has been performed.

WITH employee_checkin_info AS (
    SELECT
        employeeid,
        COUNT(entry_details) AS total_entry,
        SUM(CASE WHEN entry_details = 'login' THEN 1 ELSE 0 END) AS totallogin,
        SUM(CASE WHEN entry_details = 'logout' THEN 1 ELSE 0 END) AS totallogout,
        MAX(CASE WHEN entry_details = 'login' THEN timestamp_details END) AS latestlogin,
        MAX(CASE WHEN entry_details = 'logout' THEN timestamp_details END) AS latestlogout
    FROM employee_checkin_details
    GROUP BY employeeid
)
SELECT
    eci.employeeid,
    ed.phone_number,
    total_entry,
    totallogin,
    totallogout,
    latestlogin,
    latestlogout
FROM employee_checkin_info eci
LEFT JOIN employee_details ed ON eci.employeeid = ed.employeeid
AND ed.isdefault = true;