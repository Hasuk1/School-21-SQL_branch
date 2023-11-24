SELECT m.pizza_name, pi.name AS pizzeria_name
FROM menu m
JOIN person_order po ON m.id = po.menu_id
JOIN pizzeria pi ON m.pizzeria_id = pi.id
JOIN person p ON po.person_id = p.id
WHERE p.name IN ('Denis', 'Anna')
ORDER BY 1, 2;
