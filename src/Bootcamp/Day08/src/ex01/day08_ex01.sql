-- 1 Session --
BEGIN;
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 2 Session --
BEGIN;
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 1 Session --
UPDATE pizzeria SET rating = 4 WHERE name = 'Pizza Hut';

-- 2 Session --
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';

-- 1 Session --
COMMIT;

-- 2 Session --
COMMIT;

-- 1 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 2 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';