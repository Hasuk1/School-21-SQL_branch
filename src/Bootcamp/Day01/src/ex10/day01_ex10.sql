SELECT person.name AS person_name, menu.pizza_name AS pizza_name, pizzeria.name AS pizzeria_name
FROM person_order po
        INNER JOIN person ON person.id = po.person_id
        INNER JOIN menu ON menu.id = po.menu_id
        INNER JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
ORDER BY 1, 2, 3;