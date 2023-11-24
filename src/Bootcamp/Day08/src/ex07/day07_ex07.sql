-- 1 Session --
BEGIN;

-- 2 Session --
BEGIN;

-- 1 Session --
UPDATE pizzeria SET rating = 5 WHERE id = 1;

-- 2 Session --
UPDATE pizzeria SET rating = 3 WHERE id = 2;

-- 1 Session --
UPDATE pizzeria SET rating = 1 WHERE id = 2;

-- 2 Session --
UPDATE pizzeria SET rating = 2 WHERE id = 1;

-- 1 Session --
COMMIT;

-- 2 Session --
COMMIT;