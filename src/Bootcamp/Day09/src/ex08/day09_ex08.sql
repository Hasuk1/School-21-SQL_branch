CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INT = 10)
RETURNS TABLE (fib INT) AS $$
WITH RECURSIVE r(a, b) AS (
    SELECT 0, 1
    UNION ALL
    SELECT b, a + b
    FROM r
    WHERE b < pstop
)
SELECT a FROM r;
$$ LANGUAGE SQL;

select * from fnc_fibonacci(1000);
select * from fnc_fibonacci();