SELECT id, name, CASE
    WHEN age >= 10 AND age <=20 THEN '#1 interval'
    WHEN age > 20 AND age <24 THEN '#2 interval'
    ELSE '#3 interval'
END AS interval_info
FROM person
ORDER BY interval_info ASC;
