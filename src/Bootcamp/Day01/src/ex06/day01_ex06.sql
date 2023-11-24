SELECT DISTINCT person_order.order_date AS action_date, person.name AS person_name
FROM person_order, person_visits, person
WHERE person_order.person_id = person_visits.person_id
AND person_order.order_date = person_visits.visit_date
AND person.id = person_order.person_id
ORDER BY 1, 2 DESC;