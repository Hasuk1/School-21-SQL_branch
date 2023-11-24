WITH info_visited_table AS (
    SELECT pv.person_id, pz.name AS pizzeria_name, p.gender
    FROM person_visits pv
    JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    JOIN person p ON pv.person_id = p.id
    ORDER BY pz.name
),

females AS (
    SELECT COUNT(*) AS number, pizzeria_name
    FROM info_visited_table
    WHERE gender = 'female'
    GROUP BY pizzeria_name
),

males AS (
    SELECT COUNT(*) AS number, pizzeria_name
    FROM info_visited_table
    WHERE gender = 'male'
    GROUP BY pizzeria_name
)

SELECT females.pizzeria_name
FROM males
JOIN females ON males.pizzeria_name = females.pizzeria_name
WHERE males.number <> females.number
ORDER BY females.pizzeria_name;
