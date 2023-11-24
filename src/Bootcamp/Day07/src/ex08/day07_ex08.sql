SELECT address, pz.name, COUNT(*) AS count_of_orders
FROM person p
JOIN person_order po on p.id = po.person_id
JOIN menu m on m.id = po.menu_id
JOIN pizzeria pz on pz.id = m.pizzeria_id
GROUP BY 1, 2 ORDER BY 1, 2;