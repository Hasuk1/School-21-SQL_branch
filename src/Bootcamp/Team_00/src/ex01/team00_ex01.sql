WITH RECURSIVE min_max_cost_tours AS (
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
SELECT DISTINCT * FROM min_max_cost_tours ORDER BY 1, 2;