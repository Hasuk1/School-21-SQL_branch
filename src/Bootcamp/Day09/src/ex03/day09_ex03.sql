DROP TRIGGER IF EXISTS "trg_person_insert_audit" ON person;
DROP TRIGGER IF EXISTS "trg_person_update_audit" ON person;
DROP TRIGGER IF EXISTS "trg_person_delete_audit" ON person;

DROP FUNCTION
    IF EXISTS "fnc_trg_person_insert_audit",
    "fnc_trg_person_update_audit",
    "fnc_trg_person_delete_audit";

TRUNCATE person_audit;

CREATE OR REPLACE FUNCTION fnc_trg_person_audit()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
	BEGIN
	IF (TG_OP = 'INSERT') THEN
	    INSERT INTO "person_audit"
	    VALUES (now(), 'I', NEW.*);
	ELSEIF (TG_OP = 'UPDATE') THEN
	    INSERT INTO "person_audit"
	    VALUES (now(), 'U', OLD.*);
	ELSEIF (TG_OP = 'DELETE') THEN
	    INSERT INTO "person_audit"
	    VALUES (now(), 'D', OLD.*);
	END IF;
	RETURN NULL;
	END;
$$;
CREATE TRIGGER trg_person_audit
	AFTER INSERT OR UPDATE OR
	DELETE ON person FOR EACH ROW
	EXECUTE PROCEDURE fnc_trg_person_audit();

INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
