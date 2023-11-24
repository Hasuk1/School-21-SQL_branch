SELECT pizza_name, name pizzeria_name, price
FROM pizzeria AS p
JOIN menu ON p.id = menu.pizzeria_id
WHERE pizza_name IN ('mushroom pizza','pepperoni pizza')
ORDER BY 1, 2;