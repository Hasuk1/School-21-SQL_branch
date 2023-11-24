CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit()
RETURNS TRIGGER 
LANGUAGE PLPGSQL AS $$ 
	BEGIN
	INSERT INTO "person_audit"
	VALUES (current_timestamp, 'U', OLD.*);
	RETURN NULL;
	END;
$$;

CREATE TRIGGER trg_person_update_audit
    AFTER UPDATE ON person FOR EACH ROW
    EXECUTE PROCEDURE fnc_trg_person_update_audit();

UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
SELECT * FROM person_audit;
