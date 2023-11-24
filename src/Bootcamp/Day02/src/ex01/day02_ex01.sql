SELECT day::date AS missing_date
FROM GENERATE_SERIES(timestamp '2022-01-01', '2022-01-10', '1 day') day
LEFT JOIN (
    SELECT DISTINCT visit_date
    FROM person_visits
    WHERE person_id = 1 OR person_id = 2
) operation ON day::date = operation.visit_date
WHERE operation.visit_date IS NULL
ORDER BY 1;