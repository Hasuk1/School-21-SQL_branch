-- 1 Session --
BEGIN;
UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';
SELECT * FROM pizzeria;

-- 2 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 1 Session --
COMMIT;

-- 2 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';