DROP FUNCTION IF EXISTS "fnc_persons_male";
DROP FUNCTION IF EXISTS "fnc_persons_female";

CREATE OR REPLACE FUNCTION fnc_persons(pgender person.gender%TYPE DEFAULT 'female')
RETURNS TABLE (id bigint, name varchar, age integer, gender varchar, address varchar) AS
$$ 
	SELECT * FROM person WHERE gender = pgender;
$$
LANGUAGE SQL;
