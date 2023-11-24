CREATE OR REPLACE VIEW v_generated_dates AS
SELECT to_date(generate_series::text, 'YYYY-MM-DD') AS generated_date
FROM generate_series('2022-01-01'::date, '2022-01-31'::date, '1 day') AS generate_series;

SELECT *
FROM v_generated_dates;
