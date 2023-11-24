DROP SCHEMA public CASCADE;
CREATE SCHEMA public

CREATE TABLE nodes
(
    point1 varchar NOT NULL,
    point2 varchar NOT NULL,
    cost int NOT NULL
);

INSERT INTO nodes
VALUES ('a','b',10), ('b','a',10),
       ('b','c',35), ('c','b',35),
       ('c','a',15), ('a','c',15),
       ('c','d',30), ('d','c',30),
       ('a','d',20), ('d','a',20),
       ('b','d',25), ('d','b',25);

WITH RECURSIVE min_cost_tours AS (
    WITH RECURSIVE tour AS (
        SELECT point1, point2, cost,
            1 AS r_level,
            ARRAY[point1] AS path,
            FALSE AS cycle,
            ARRAY[cost] AS costs
        FROM nodes n
        WHERE point1 = 'a'
        UNION ALL
        SELECT n.point1,
            n.point2,
            n.cost + t.cost AS cost,
            t.r_level + 1 AS r_level,
            t.path || n.point1 AS path,
            n.point1 = ANY (t.path) AS cycle,
            t.costs || n.cost AS costs
        FROM nodes n
        JOIN tour t ON t.point2 = n.point1
        WHERE NOT cycle
    )
    SELECT cost - costs[5] AS total_cost, path AS tour
    FROM tour
    WHERE r_level = 5 AND path[1] = path[5]
)
SELECT DISTINCT *
FROM min_cost_tours
WHERE total_cost = (SELECT min(total_cost) FROM min_cost_tours)
ORDER BY 1, 2;