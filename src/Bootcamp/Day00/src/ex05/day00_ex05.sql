SELECT name
FROM person
WHERE id IN (
    SELECT person_id
    FROM person_order
    WHERE menu_id IN (13, 14, 18) AND order_date = '2022-01-07'
);
