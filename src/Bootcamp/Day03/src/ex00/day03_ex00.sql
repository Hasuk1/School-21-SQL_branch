SELECT m.pizza_name, m.price, pz.name AS pizzeria_name, pv.visit_date
FROM menu m
INNER JOIN person_visits pv ON m.pizzeria_id = pv.pizzeria_id
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
INNER JOIN person p ON pv.person_id = p.id
WHERE p.name = 'Kate' AND m.price BETWEEN 800 AND 1000
ORDER BY 1, 2, 3;
