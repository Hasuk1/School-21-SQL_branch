-- 1 Session --
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 2 Session --
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- 1 Session --
SELECT sum(rating) FROM pizzeria;

-- 2 Session --
UPDATE pizzeria SET rating = 5 WHERE name = 'Pizza Hut';
COMMIT;

-- 1 Session --
SELECT sum(rating) FROM pizzeria;
COMMIT;

-- 1 Session --
SELECT sum(rating) FROM pizzeria;

-- 2 Session --
SELECT sum(rating) FROM pizzeria;