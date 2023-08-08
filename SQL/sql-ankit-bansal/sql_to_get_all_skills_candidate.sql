


select candidate_id , count(candidate_id) from applications 
where skills in ('PowerBI','Python','SQL')
group by candidate_id
having count(candidate_id) = 3
order by candidate_id