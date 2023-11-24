WITH OrderedPizzas AS (
    SELECT DISTINCT m.pizza_name, m.price, pz.name AS pizzeria_name
    FROM menu m
    INNER JOIN person_order po ON m.id = po.menu_id
    INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
)
SELECT m.pizza_name, m.price, pz.name AS pizzeria_name
FROM menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
WHERE (m.pizza_name, m.price, pz.name) NOT IN (
SELECT *
FROM OrderedPizzas)
ORDER BY m.pizza_name, m.price;
