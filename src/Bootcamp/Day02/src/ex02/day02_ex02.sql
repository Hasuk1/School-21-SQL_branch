SELECT COALESCE(p.name, '-')  AS person_name, CASE
WHEN q1.visit_date IS NULL THEN 'null'
ELSE q1.visit_date::text
END AS visit_date,
COALESCE(pizzeria.name, '-') AS pizzeria_name
FROM person AS p
FULL JOIN (SELECT *
FROM person_visits AS pv
WHERE pv.visit_date BETWEEN '2022-01-01' AND '2022-01-03') q1
ON p.id = q1.person_id
FULL JOIN pizzeria
ON pizzeria_id = pizzeria.id
ORDER BY 1, 2, 3;
