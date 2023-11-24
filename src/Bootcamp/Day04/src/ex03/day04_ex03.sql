SELECT generated_date AS missing_date
FROM v_generated_dates v
LEFT JOIN person_visits p ON v.generated_date = p.visit_date
WHERE p.visit_date IS NULL
ORDER BY 1;
