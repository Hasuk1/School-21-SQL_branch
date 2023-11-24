SELECT person_id, COUNT(*) AS count_of_visits FROM person_visits
GROUP BY 1 ORDER BY 2 DESC, 1;