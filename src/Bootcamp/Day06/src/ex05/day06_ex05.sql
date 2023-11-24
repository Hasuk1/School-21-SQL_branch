COMMENT ON TABLE person_discounts IS
    'Таблица со скидками для клиентов в определенной пиццерии.'
    'Размер скидки зависит от количества посещений пиццерии.';

COMMENT ON COLUMN person_discounts.id IS 'Идентификатор скидки.';

COMMENT ON COLUMN person_discounts.person_id IS 'Идентификатор, кому назначена скидка.';

COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Идентификатор, в какой пиццерии действует скидка.';

COMMENT ON COLUMN person_discounts.discount IS 'Сумма скикди в процентах.';

SELECT obj_description('person_discounts'::regclass);
SELECT a.attname AS column_name, d.description AS column_comment
FROM pg_attribute a
JOIN pg_class c ON a.attrelid = c.oid
LEFT JOIN pg_description d ON c.oid = d.objoid AND a.attnum = d.objsubid
WHERE c.relname = 'person_discounts' AND d.description IS NOT NULL;