CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr NUMERIC[])
RETURNS NUMERIC
 AS $$
    SELECT min(val)
    FROM unnest(arr) AS val;
$$ LANGUAGE SQL;

SELECT func_minimum(-1987318.131, -1.0, 5.0, 0, 4141.1);
