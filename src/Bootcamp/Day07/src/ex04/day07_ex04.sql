SELECT p.name, COUNT(*) AS count_of_visits
FROM person_visits pv
JOIN person p on p.id = pv.person_id
GROUP BY 1 HAVING COUNT(pv.pizzeria_id) > 3;