SET ENABLE_SEQSCAN TO OFF;

SELECT m.pizza_name, pz.name
FROM menu m JOIN pizzeria pz ON m.pizzeria_id = pz.id;
EXPLAIN ANALYZE
SELECT m.pizza_name, pz.name
FROM menu m JOIN pizzeria pz ON m.pizzeria_id = pz.id;