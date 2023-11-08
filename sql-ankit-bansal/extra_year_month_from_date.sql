-- EXTRACT() used in Oracle and postgres
--- YEAR() used in SQL

select YEAR(event_date) from events 
select EXTRACT(MONTH FROM event_date) from events

-- we can use YEAR , MONTH and DAY

-- TO_CHAR() function is available in POSTGRES , in my SQL we have date_format()

select MONTH(event_date) , date_format(event_date , '%M') from events

select EXTRACT(MONTH from event_date),TO_CHAR(event_date,'Month') from events


