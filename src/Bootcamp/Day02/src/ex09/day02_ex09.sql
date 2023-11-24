SELECT DISTINCT p.name
FROM person p
INNER JOIN person_order po ON p.id = po.person_id
INNER JOIN menu m ON po.menu_id = m.id
WHERE p.gender = 'female' AND m.pizza_name = 'cheese pizza' AND p.id IN (
    SELECT DISTINCT po2.person_id
    FROM person_order po2
    INNER JOIN menu m2 ON po2.menu_id = m2.id
    WHERE m2.pizza_name = 'pepperoni pizza'
);
