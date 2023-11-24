WITH visits AS (
    SELECT pz.name, COUNT(*) AS count, 'visits' AS action_type
    FROM person_visits pv
    RIGHT JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    GROUP BY pz.name
),
orders AS (
    SELECT pz.name, COUNT(po.menu_id) AS count, 'order' AS action_type
    FROM person_order po
    RIGHT JOIN menu m ON po.menu_id = m.id
    RIGHT JOIN pizzeria pz ON m.pizzeria_id = pz.id
    GROUP BY pz.name
)
SELECT name, SUM(count) AS total_count
FROM (
    SELECT * FROM visits
    UNION ALL
    SELECT * FROM orders
) AS combined_data
GROUP BY name
ORDER BY 2 DESC, 1;
