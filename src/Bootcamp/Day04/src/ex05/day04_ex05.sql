CREATE OR REPLACE VIEW v_price_with_discount AS
SELECT p.name, pizza_name, price, (price * 0.9) AS discount_price
FROM person_order
         JOIN person p ON person_id = p.id
         JOIN menu m ON menu_id = m.id
ORDER BY 1, 2;

SELECT * FROM v_price_with_discount;
