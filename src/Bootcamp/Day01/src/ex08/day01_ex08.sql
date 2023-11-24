SELECT order_date, format('%s (age:%s)', name, age) AS person_information
FROM person_order
    NATURAL JOIN (
        SELECT people.id AS person_id, name, age
        FROM person people) AS ppl
ORDER BY 1,2;