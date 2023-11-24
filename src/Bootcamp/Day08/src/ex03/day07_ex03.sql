-- 1 Session --
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 2 Session --
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 1 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 2 Session --
UPDATE pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut';
COMMIT;

-- 1 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';
COMMIT;

-- 1 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';

-- 2 Session --
SELECT * FROM pizzeria WHERE name = 'Pizza Hut';