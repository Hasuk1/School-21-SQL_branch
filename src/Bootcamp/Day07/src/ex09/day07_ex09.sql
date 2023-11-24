SELECT DISTINCT address,
                ROUND(age_max::numeric - (age_min::numeric / age_max::numeric), 2) AS formula,
                ROUND(age_avg::numeric, 2) AS average,
                ROUND(age_max::numeric - (age_min::numeric / age_max::numeric), 2) > age_avg::numeric AS comparison
FROM (
    SELECT address,
           MAX(age) AS age_max,
           MIN(age) AS age_min,
           AVG(age) AS age_avg
    FROM person
    GROUP BY address
) AS aggregated_data
ORDER BY address;