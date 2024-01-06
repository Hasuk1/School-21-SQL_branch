DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE IF NOT EXISTS Peer(
    Nickname VARCHAR PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS ADM(
    id SERIAL PRIMARY KEY,
    Task VARCHAR,
    Peer VARCHAR,
    CONSTRAINT peer_adm FOREIGN KEY (Peer) REFERENCES Peer(Nickname)
);


CREATE TABLE IF NOT EXISTS Penalty(
    id SERIAL PRIMARY KEY,
    ADM_id INT,
    Nickname VARCHAR NOT NULL,
    "Date" Date,
    CONSTRAINT adm_id_penalty FOREIGN KEY (ADM_id) REFERENCES ADM(id),
    CONSTRAINT nickname_penalty FOREIGN KEY (Nickname) REFERENCES Peer(Nickname)
);

insert into Peer VALUES ('Azat');
insert into Peer VALUES ('Misha');
insert into Peer VALUES ('Yana');
insert into Peer VALUES ('Nikita');
insert into Peer VALUES ('Chingis');
insert into Peer VALUES ('Timur');
insert into Peer VALUES ('Sanya');

insert into ADM VALUES (1,'Wash floor','Azat');
insert into ADM VALUES (2,'Wash iMac','Misha');
insert into ADM VALUES (3,'Push up','Yana');
insert into ADM VALUES (4,'Review of the chair','Nikita');
insert into ADM VALUES (5,'Wash iMac','Chingis');
insert into ADM VALUES (6,'Cleen stickers','Timur');
insert into ADM VALUES (7,'Wash floor','Sanya');
insert into ADM VALUES (8,'Bim-bim Bam-bam','Azat');

insert into Penalty VALUES (1,1,'Azat','10-10-2023');
insert into Penalty VALUES (2,2,'Misha','09-09-2023');
insert into Penalty VALUES (3,3,'Yana','08-08-2023');
insert into Penalty VALUES (4,4,'Nikita','07-07-2023');
insert into Penalty VALUES (5,5,'Chingis','06-06-2023');
insert into Penalty VALUES (6,6,'Timur','05-05-2023');
insert into Penalty VALUES (7,7,'Sanya','04-04-2023');


CREATE OR REPLACE FUNCTION test_func()
RETURNS TRIGGER AS
$$
BEGIN
        INSERT INTO Peer VALUES (NEW.Nickname);
        RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- CREATE TRIGGER
CREATE TRIGGER before_insert_peer BEFORE INSERT ON Peer
FOR EACH ROW
EXECUTE FUNCTION test_func();


/*___1___*/


CREATE OR REPLACE PROCEDURE part_one()
LANGUAGE plpgsql AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'public' AND table_name LIKE 'TableName%')
    LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || rec.table_name;
    END LOOP;
END;
$$;

-- CALL PROCEDURE
Call part_one();
-- DROP PROCEDURE
DROP PROCEDURE part_one();





/*___2___*/

CREATE OR REPLACE PROCEDURE part_two()
LANGUAGE plpgsql AS $$
BEGIN
DECLARE rec RECORD;
BEGIN
    FOR rec IN (
    SELECT 
    proname AS function_name, 
    pg_get_function_arguments(pg_proc.oid) AS function_arguments, 
    pg_get_function_result(pg_proc.oid) AS function_result 
FROM pg_proc 
    JOIN pg_namespace ON pg_namespace.oid = pg_proc.pronamespace 
WHERE pg_namespace.nspname = 'public' AND pg_proc.prokind = 'f' AND pg_proc.pronargs >= 0 AND pg_get_function_arguments(pg_proc.oid) != ''
)
LOOP
    RAISE NOTICE 'function_name: % ; function_arguments: % ; function_result: %', rec.function_name, rec.function_arguments, rec.function_result;
END LOOP;
END;
END;
$$;

-- CALL PROCEDURE
CALL part_two();
-- DROP PROCEDURE
DROP PROCEDURE part_two();


/*___3___*/

CREATE OR REPLACE PROCEDURE part_3()
LANGUAGE plpgsql
AS $$
DECLARE
    req RECORD;
BEGIN
    FOR req IN (SELECT trigger_name, event_object_schema AS trigger_schema, event_object_table AS trigger_table FROM information_schema.triggers)
    LOOP
        EXECUTE 'DROP TRIGGER IF EXISTS ' || req.trigger_name || ' ON ' || req.trigger_schema || '.'  || req.trigger_table || ' CASCADE';
    END LOOP;
END;
$$;

-- CALL PROCEDURE
CALL part_3();
-- DROP PROCEDURE
DROP PROCEDURE part_3();
/*___4___*/


Create OR REPLACE PROCEDURE part_4()
LANGUAGE plpgsql
AS $$
    DECLARE 
    req RECORD;
    BEGIN
    FOR req in(
SELECT
  proname AS obj_name,
  CASE
    WHEN prokind = 'p' THEN 'procedure'
    WHEN prokind = 'f' THEN 'function'
    ELSE 'unknown'
  END AS object_type
FROM
  pg_catalog.pg_proc
  JOIN pg_namespace ON pg_namespace.oid = pg_proc.pronamespace
WHERE
  pg_namespace.nspname = 'public'
  AND (pg_proc.prokind = 'f' OR pg_proc.prokind = 'p')
  AND pg_proc.pronargs >= 0
)
LOOP
    RAISE NOTICE 'obj_name: % ; object_type: % ', req.obj_name,req.object_type;
END LOOP;
end;
$$;

-- CALL PROCEDURE
CALL part_4();
-- DROP PROCEDURE
DROP PROCEDURE part_4();
