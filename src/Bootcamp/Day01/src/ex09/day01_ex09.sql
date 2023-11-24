SELECT name
FROM pizzeria pz
WHERE pz.id NOT IN (
    SELECT pizzeria_id
    FROM person_visits);

SELECT name
FROM pizzeria pz
WHERE NOT exists(
    SELECT pizzeria_id
    FROM person_visits pv
    WHERE pv.pizzeria_id = pz.id);