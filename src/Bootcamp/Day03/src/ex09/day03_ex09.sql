INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
    COALESCE(MAX(id), 0) + 1,
    (SELECT id FROM person WHERE name = 'Denis'),
    (SELECT id FROM pizzeria WHERE name = 'Dominos'),
    '2022-02-24'
FROM person_visits;

INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
    COALESCE(MAX(id), 0) + 2,
    (SELECT id FROM person WHERE name = 'Irina'),
    (SELECT id FROM pizzeria WHERE name = 'Dominos'),
    '2022-02-24'
FROM person_visits;
