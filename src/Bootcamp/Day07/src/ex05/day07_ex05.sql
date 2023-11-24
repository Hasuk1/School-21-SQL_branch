SELECT DISTINCT name
FROM person_order po
JOIN person p ON p.id = person_id
ORDER BY 1;