select order_date, format('%s (age:%s)', name, age) as person_information
from person_order
INNER JOIN person ON person.id = person_order.person_id
ORDER BY order_date, 2;