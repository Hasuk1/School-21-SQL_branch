CREATE OR REPLACE VIEW v_symmetric_union AS
WITH pv_01_02 AS (
    SELECT person_id
    FROM person_visits
    WHERE visit_date = '2022-01-02'
),
pv_01_06 AS (
    SELECT person_id
    FROM person_visits
    WHERE visit_date = '2022-01-06'
)
SELECT person_id FROM pv_01_02
WHERE person_id NOT IN (SELECT person_id FROM pv_01_06)
UNION
SELECT person_id FROM pv_01_06
WHERE person_id NOT IN (SELECT person_id FROM pv_01_02)
ORDER BY 1;

SELECT *
FROM v_symmetric_union;