DROP MATERIALIZED VIEW IF EXISTS mv_dmitriy_visits_and_eats;

CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT pz.name
FROM person_visits
JOIN person p ON person_id = p.id
JOIN pizzeria pz ON pizzeria_id = pz.id
WHERE visit_date = '2022-01-08'
    AND p.name = 'Dmitriy'
    AND pz.name IN (
        SELECT pz.name
        FROM pizzeria pz
        JOIN menu m ON pz.id = m.pizzeria_id
        WHERE price < 800
    );

SELECT * FROM mv_dmitriy_visits_and_eats;