WITH date_series AS (
    SELECT day::date AS missing_date
    FROM GENERATE_SERIES(timestamp '2022-01-01', '2022-01-10', '1 day') AS day
)
SELECT ds.missing_date
FROM date_series ds
LEFT JOIN (
    SELECT DISTINCT visit_date
    FROM person_visits
    WHERE person_id IN (1, 2)
) fv ON ds.missing_date = fv.visit_date
WHERE fv.visit_date IS NULL
ORDER BY 1;
