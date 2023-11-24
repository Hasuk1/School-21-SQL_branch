INSERT INTO person_order(id, person_id, menu_id, order_date)
SELECT (
    SELECT max(id) FROM person_order) + gener_id,
    id,
    (SELECT id FROM menu WHERE pizza_name = 'greek pizza'),
    '2022-02-25'::date
FROM person
JOIN generate_series(1, ( SELECT count(*) FROM person)) AS gener_id ON gener_id = person.id