WITH info_ordered_table AS (
    SELECT DISTINCT pizzeria.name AS pizzeria_name, person.gender
    FROM person_order
    JOIN menu ON person_order.menu_id = menu.id
    JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
    JOIN person ON person_order.person_id = person.id
),
gender_counts AS (
    SELECT pizzeria_name, gender, COUNT(*) AS gender_count
    FROM info_ordered_table
    GROUP BY pizzeria_name, gender
),
gender_summary AS (
    SELECT pizzeria_name,
           MAX(CASE WHEN gender = 'male' THEN gender_count ELSE 0 END) AS male_count,
           MAX(CASE WHEN gender = 'female' THEN gender_count ELSE 0 END) AS female_count
    FROM gender_counts
    GROUP BY pizzeria_name
)
SELECT pizzeria_name
FROM gender_summary
WHERE (male_count = 0 AND female_count > 0) OR (female_count = 0 AND male_count > 0)
ORDER BY pizzeria_name;
