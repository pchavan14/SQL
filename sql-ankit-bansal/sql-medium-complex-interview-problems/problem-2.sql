-- write a query to find business day between create date and resolved date excluding weekends and public holidays
-- different MySQL date functions 

datepart(day,'2022-01-23') -- 23 ( it gives the 23rd day)
datepart(week, '2022-01-23') -- 5 (it gives the 5th week)

dateadd(day,2,'2022-01-23') -- 2022-01-25

datediff(day,'2022-01-23','2022-01-26') -- days difference between these two days

datediff(day,'2022-01-23','2022-01-26') - 2*datediff(week,'2022-01-23','2022-01-26') -- subtract the holidays from the dates and only give the business days

-- calcualte age from date of birth 
getdate() - todays date 

datediff(year,dob,getdate()) 