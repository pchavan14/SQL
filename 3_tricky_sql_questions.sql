-- input table --
id      comment        translation
1       very good       [null]
2       good            [null]
3       cdcdcdcd        very bad

-- expected output--
id      final_comment
1       very good
2       good
3       very bad

--replace garbage values with meaningful values --

select 
case when translation is NULL then comment else translation end as output
from input_table

-- we can also use coalesce here --- 
select coalesce (translation , comment) as output
from input_table

-- the above select statement returns the first NOT NULL value -- 

