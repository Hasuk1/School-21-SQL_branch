CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit() 
RETURNS TRIGGER 
LANGUAGE PLPGSQL AS $$ 
	BEGIN
	INSERT INTO "person_audit"
	VALUES (current_timestamp, 'D', OLD.*);
	RETURN NULL;
	END;
$$;
CREATE TRIGGER trg_person_delete_audit
    AFTER DELETE ON person FOR EACH ROW
    EXECUTE PROCEDURE fnc_trg_person_delete_audit();

DELETE FROM person WHERE id = 10;
SELECT * FROM person_audit;
