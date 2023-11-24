DROP TABLE person_audit CASCADE;
CREATE TABLE person_audit
(
    created    timestamp with time zone DEFAULT current_timestamp NOT NULL,
    type_event char(1)                  DEFAULT 'I'               NOT NULL,
    row_id     bigint                                             NOT NULL,
    name       varchar,
    age        integer,
    gender     varchar,
    address    varchar,
    CONSTRAINT ch_type_event CHECK ( type_event IN ('I', 'U', 'D'))
);
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit()
RETURNS TRIGGER
LANGUAGE PLPGSQL AS $$
	BEGIN
	INSERT INTO "person_audit"
    VALUES(current_timestamp,'I', NEW.*);
    RETURN NULL;
    END;
$$;
CREATE TRIGGER trg_person_insert_audit
    AFTER INSERT ON person FOR EACH ROW
    EXECUTE PROCEDURE fnc_trg_person_insert_audit();

DELETE FROM person WHERE name = 'Damir';
INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

SELECT * FROM person_audit;
