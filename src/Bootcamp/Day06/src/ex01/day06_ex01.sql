INSERT INTO person_discounts
SELECT
    ROW_NUMBER() OVER () AS id,
    amount.person_id,
    amount.pizzeria_id,
    COALESCE(
    CASE
        WHEN amount.orders = 1 THEN 10.5
        WHEN amount.orders = 2 THEN 22
    END,
    30
) AS discount
FROM (SELECT person_id, pizzeria_id, count(person_id) AS orders
      FROM person_order po
               JOIN menu m on po.menu_id = m.id
      GROUP BY person_id, pizzeria_id) AS amount;