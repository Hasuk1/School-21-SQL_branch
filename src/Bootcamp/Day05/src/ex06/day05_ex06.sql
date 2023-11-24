SET ENABLE_SEQSCAN TO ON;

EXPLAIN ANALYZE
SELECT
    m.pizza_name AS pizza_name, m.price AS price,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS pizzeria_rating
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY 1;

CREATE INDEX idx_1 ON pizzeria (rating);

SET ENABLE_SEQSCAN TO OFF;

EXPLAIN ANALYZE
SELECT
    m.pizza_name AS pizza_name, m.price AS price,
    max(rating) OVER (PARTITION BY rating ORDER BY rating ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS pizzeria_rating
FROM  menu m
INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id AND rating = 4.9
ORDER BY 1;

DROP INDEX idx_1;