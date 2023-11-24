WITH andrey_pizzerias AS (
     SELECT DISTINCT pizzeria_id
     FROM person_visits
     WHERE person_id = 2
),
ordered_pizzerias AS (
    SELECT DISTINCT menu.pizzeria_id
    FROM person_order
    JOIN menu ON person_order.menu_id = menu.id
    WHERE person_order.person_id = 2
)

SELECT p.name AS pizzeria_name
FROM pizzeria p
WHERE p.id IN (SELECT pizzeria_id FROM andrey_pizzerias)
  AND p.id NOT IN (SELECT pizzeria_id FROM ordered_pizzerias);
