SELECT id AS object_id, pizza_name AS object_name
FROM menu
UNION ALL
SELECT id AS object_id, name AS object_name
FROM person
ORDER BY 1 ASC, 2 ASC;