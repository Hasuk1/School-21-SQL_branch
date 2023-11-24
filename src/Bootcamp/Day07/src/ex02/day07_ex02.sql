WITH visits AS (
    SELECT pz.name, COUNT(pv.pizzeria_id) AS count, 'visit' AS action_type
    FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    GROUP BY 1 ORDER BY 2 DESC LIMIT 3
),
orders AS (
    SELECT pz.name, COUNT(po.menu_id) AS count, 'order' AS action_type
    FROM person_order po
    JOIN menu m ON po.menu_id = m.id
    JOIN pizzeria pz ON m.pizzeria_id = pz.id
    GROUP BY 1 ORDER BY 2 DESC LIMIT 3
)
SELECT * FROM visits
UNION ALL
SELECT * FROM orders
ORDER BY 3, 2 DESC;