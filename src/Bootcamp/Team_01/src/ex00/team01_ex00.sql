WITH
    bal AS (
        SELECT b.user_id, b.type, SUM(b.money) AS volume, b.currency_id
        FROM balance b
        GROUP BY b.user_id, b.type,  b.currency_id
),  cur AS (
        SELECT c.id, c.name, c.rate_to_usd
        FROM currency c
        JOIN (SELECT id, MAX(updated) AS updated FROM currency GROUP BY id) AS temp
    ON c.updated = temp.updated AND c.id = temp.id
),  total AS (
        SELECT
            COALESCE("user".name, 'not defined') AS name,
            COALESCE("user".lastname, 'not defined') AS lastname,
            bal.type,
            bal.volume,
            COALESCE(cur.name, 'not defined') AS currency_name,
            COALESCE(cur.rate_to_usd, 1) AS last_rate_to_usd,
            CAST(ROUND(bal.volume * COALESCE(cur.rate_to_usd, 1), 6) AS real) AS total_volume_in_usd
        FROM bal
        LEFT JOIN "user" ON "user".id = bal.user_id
        LEFT JOIN cur ON bal.currency_id = cur.id
        ORDER BY 1 DESC, 2, 3
)
SELECT * FROM total;