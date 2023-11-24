SELECT DISTINCT  name, rating
FROM pizzeria AS piz
LEFT JOIN person_visits AS pv ON piz.id = pv.pizzeria_id
WHERE pv.pizzeria_id IS NULL;