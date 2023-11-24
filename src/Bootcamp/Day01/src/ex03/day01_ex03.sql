SELECT t1.order_date AS action_date, t1.person_id AS person_id
FROM person_order t1
INTERSECT ALL
SELECT t2.visit_date AS action_date, t2.person_id AS person_id
FROM person_visits t2
ORDER BY 1, 2 DESC;