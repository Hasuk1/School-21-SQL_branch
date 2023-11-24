CREATE OR REPLACE FUNCTION 
fnc_person_visits_and_eats_on_date(pperson person.name%TYPE DEFAULT 'Dmitriy',
                                   pprice menu.price%TYPE DEFAULT 500,
                                   pdate person_visits.visit_date%TYPE DEFAULT '2022-01-08')
RETURNS TABLE (pizzeria_name varchar) 
LANGUAGE PLPGSQL AS $$
    BEGIN
	RETURN QUERY (
        WITH p AS (
        SELECT id FROM person
        WHERE name = pperson
    ),
    v AS (
        SELECT person_id, pizzeria_id
        FROM person_visits
        WHERE visit_date = pdate
    ),
    m AS (
        SELECT pizzeria_id, pizza_name
        FROM menu
        WHERE price < pprice
    )
SELECT pz.name pizzeria_name
FROM p
    JOIN v ON p.id = v.person_id
    JOIN m ON v.pizzeria_id = m.pizzeria_id
    JOIN pizzeria pz ON m.pizzeria_id = pz.id);
    END;
$$ ;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
