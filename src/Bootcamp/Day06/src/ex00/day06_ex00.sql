CREATE TABLE person_discounts
( id BIGINT PRIMARY KEY,
  person_id   BIGINT NOT NULL,
  pizzeria_id BIGINT NOT NULL,
  discount    NUMERIC NOT NULL DEFAULT 0,
  CONSTRAINT fk_person_discounts_person_id FOREIGN KEY (person_id) REFERENCES person (id),
  CONSTRAINT fk_person_discounts_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES pizzeria (id)
  );

-- DROP TABLE person_discounts;