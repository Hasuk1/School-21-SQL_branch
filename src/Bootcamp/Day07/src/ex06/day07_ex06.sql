SELECT name,
       COUNT(name) AS count_of_orders,
       ROUND(AVG(price), 2) AS average_price,
       MAX(price) AS max_price,
       MIN(price) AS min_price
FROM person_order po
JOIN menu m on m.id = menu_id
JOIN pizzeria pz on pz.id = m.pizzeria_id
GROUP BY 1 ORDER BY 1;