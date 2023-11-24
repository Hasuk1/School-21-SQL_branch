DROP INDEX  idx_person_discounts_unique;
CREATE UNIQUE INDEX idx_person_discounts_unique ON person_discounts (person_id, pizzeria_id);

SET ENABLE_SEQSCAN = OFF;

EXPLAIN ANALYZE
SELECT p.name, person_id, pizzeria_id, discount
FROM person_discounts pd
JOIN person p ON pd.person_id = p.id
WHERE person_id = 2 OR person_id = 3 AND pizzeria_id = 1;