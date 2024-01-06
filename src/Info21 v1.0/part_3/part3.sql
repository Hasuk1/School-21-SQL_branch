
/* __1__ */

CREATE OR REPLACE FUNCTION TransferredPoints_reed()
RETURNS TABLE(Peer1 VARCHAR,Peer2 VARCHAR,SUMPointsAmount BIGINT)
LANGUAGE plpgsql
AS $$
BEGIN 
RETURN query
SELECT CheckingPeer AS Peer1,CheckedPeer AS Peer2, SUM(trash_table.PointsAmount) from  (
SELECT CheckingPeer,CheckedPeer,PointsAmount FROM TransferredPoints
union
SELECT CheckedPeer,CheckingPeer,-PointsAmount FROM TransferredPoints) AS trash_table
GROUP BY CheckingPeer,CheckedPeer;
end;
$$;

SELECT * from TransferredPoints_reed();

DROP FUNCTION TransferredPoints_reed();


/* __2__ */


CREATE OR REPLACE FUNCTION Peer_task_xp()
RETURNS TABLE (Peer VARCHAR,Task VARCHAR, XP int)
LANGUAGE plpgsql
AS $$
BEGIN
RETURN query
SELECT Checks.Peer,Checks.Task,XP.XPAmount FROM Checks
join XP ON XP."Check" = Checks.id
join VERTER ON VERTER."Check" = Checks.id
WHERE VERTER."State" = '1';
end;
$$;

SELECT * from Peer_task_xp();

DROP FUNCTION Peer_task_xp();


/* __3__ */

CREATE OR REPLACE FUNCTION date_dont_exite(input_day date default current_date)
RETURNS TABLE (Peers VARCHAR)
LANGUAGE plpgsql
AS $$ 
BEGIN
RETURN query
With one AS (
SELECT  Peer, "Time" FROM TimeTracking
Where TimeTracking."state" = '1' AND input_day = TimeTracking."Date"
),
two AS(
SELECT  Peer, "Time" FROM TimeTracking
Where TimeTracking."state" = '2' 
)
SELECT distinct one.Peer FROM one
join two on two.Peer = one.Peer
GROUP BY one.Peer
HAVING MAX(two."Time") - MIN(one."Time") > INTERVAL '23 hour' HOUR TO MINUTE;
end;
$$;


SELECT * from date_dont_exite('2020-09-01');

DROP FUNCTION date_dont_exite(input_day date);


/* __4__ */


CREATE OR REPLACE PROCEDURE part_4()
LANGUAGE plpgsql
AS $$ 
BEGIN
DROP TABLE IF EXISTS part_4_table;
    CREATE TEMPORARY TABLE part_4_table AS
SELECT Peer, SUM(test_table.PointsAmount) AS PointsChange FROM(
    SELECT TransferredPoints.CheckingPeer as Peer, SUM(PointsAmount) AS PointsAmount FROM TransferredPoints
    GROUP BY CheckingPeer,PointsAmount
    union
    SELECT TransferredPoints.CheckedPeer AS Peer, -SUM(PointsAmount) AS PointsAmount FROM TransferredPoints
    GROUP BY CheckedPeer,PointsAmount
    ) AS test_table
    GROUP BY Peer
    ORDER BY PointsChange DESC;
END;
$$;

CALL part_4();
SELECT * FROM part_4_table;

DROP PROCEDURE IF EXISTS part_4();

/* __5__ */

CREATE OR REPLACE PROCEDURE part_5()
LANGUAGE plpgsql
AS $$ 
BEGIN
    DROP TABLE IF EXISTS part_5_table;
    CREATE TEMPORARY TABLE part_5_table AS
    SELECT Peer, SUM(test_table.PointsChange) AS PointsChange FROM (
    SELECT peer1 AS Peer, SUM(sumpointsamount) AS PointsChange FROM TransferredPoints_reed()
    GROUP BY peer1,sumpointsamount
    union
    SELECT peer2 AS Peer, -SUM(sumpointsamount) AS PointsChange FROM TransferredPoints_reed()
    GROUP BY peer2,sumpointsamount
    ) AS test_table
    GROUP BY Peer
    ORDER BY PointsChange DESC;
    end;
    $$;

CALL part_5();
SELECT * FROM part_5_table;

DROP PROCEDURE IF EXISTS part_5();

/* __6__ */

CREATE OR REPLACE PROCEDURE Popular_task_in_day()
LANGUAGE plpgsql
AS $$ 
BEGIN
DROP TABLE IF EXISTS part_6_table;
    CREATE TEMPORARY TABLE part_6_table AS
WITH Check_count AS (
    SELECT 
    tt1."Date" AS "Day", 
    tt1.Task, 
    COUNT(*) AS table_row, 
    ROW_NUMBER() OVER(PARTITION BY tt1."Date" ORDER BY COUNT(*)) AS Table_Date_top
    FROM Checks AS tt1
    GROUP BY tt1."Date",tt1.Task
) 
SELECT Check_count."Day", Check_count.Task FROM Check_count 
WHERE Check_count.Table_Date_top = 1;
END;
$$;

CALL Popular_task_in_day();
SELECT * FROM part_6_table;

DROP PROCEDURE IF EXISTS Popular_task_in_day();


/* __7__ */


CREATE OR REPLACE PROCEDURE blok_Task_all(task_bloc_name VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_7_table;
    CREATE TEMPORARY TABLE part_7_table AS
    WITH sub_string AS(
        SELECT Title FROM Tasks WHERE Title LIKE task_bloc_name || '%' ORDER BY Tasks DESC limit 1
    )
    SELECT Checks.Peer, Checks."Date" AS "Day" FROM Checks
    JOIN Verter ON Verter."Check" = Checks.id
    JOIN sub_string ON sub_string.Title = Checks.Task
    WHERE Verter."State" = '1'
    ORDER BY Checks."Date" DESC;
END;
$$;


CALL blok_Task_all('CPP');
SELECT * FROM part_7_table;

DROP PROCEDURE IF EXISTS blok_Task_all();

/* __8__ */

CREATE OR REPLACE PROCEDURE Friends_recommendations()
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_8_table;
CREATE TEMPORARY TABLE part_8_table AS
	SELECT Peer1 AS peer, Recommendations.RecommendedPeer FROM Friends
	JOIN Recommendations ON Friends.Peer1 = Recommendations.Peer
	GROUP BY Friends.peer1, Recommendations.RecommendedPeer
	ORDER BY count(*);
end;
$$;

CALL Friends_recommendations();
SELECT * FROM part_8_table;

DROP PROCEDURE IF EXISTS Friends_recommendations();


/* __9__ */


CREATE OR REPLACE PROCEDURE procent(Task_blok1 VARCHAR,Task_blok2 VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE Unique_peer INT;
BEGIN
Unique_peer :=(SELECT COUNT(Nickname) FROM Peers);
DROP TABLE IF EXISTS part_9_table;
CREATE TEMPORARY TABLE part_9_table AS
WITH 
Table1 AS(SELECT DISTINCT Peer FROM Checks WHERE Task LIKE Task_blok1 || '%'),
Table2 AS(SELECT DISTINCT Peer FROM Checks WHERE Task LIKE Task_blok2 || '%'),
Table3 AS(SELECT Table1.peer FROM Table1 JOIN Table2 ON Table1.Peer = Table2.Peer),
Table4 AS (SELECT Nickname FROM Peers WHERE Nickname NOT IN (SELECT peer FROM Table1 UNION SELECT peer FROM Table2))
SELECT 
ROUND((SELECT COUNT(*) FROM Table1)* 100/Unique_peer,0) AS StartedBlock1,
ROUND((SELECT COUNT(*) FROM Table2)* 100/Unique_peer,0) AS StartedBlock2,
ROUND((SELECT COUNT(*) FROM Table3)* 100/Unique_peer,0) AS StartedBothBlocks,
ROUND((SELECT COUNT(*) FROM Table4)* 100/Unique_peer,0) AS DidntStartAnyBlock;
END;
$$;

CALL procent('CPP','SQL');
SELECT * FROM part_9_table;

DROP PROCEDURE IF EXISTS procent(Task_blok1 VARCHAR,Task_blok2 VARCHAR);


/* __10__ */


CREATE OR REPLACE PROCEDURE bithday_checks()
LANGUAGE plpgsql
AS $$
DECLARE Unique_peer INT;
BEGIN
Unique_peer :=(SELECT COUNT(Nickname) FROM Peers);
DROP TABLE IF EXISTS part_10_table;
    CREATE TEMPORARY TABLE part_10_table AS
WITH
one AS (
    SELECT DISTINCT Peer FROM Checks
    JOIN Peers ON Peers.Nickname = Checks.Peer
    JOIN Verter ON Verter."Check" = Checks.id
    WHERE Peers.Birthday IN (SELECT "Date" FROM Checks) AND Verter."State" = '1'
    ),
two AS (
    SELECT DISTINCT Peer FROM Checks
    JOIN Peers ON Peers.Nickname = Checks.Peer
    JOIN Verter ON Verter."Check" = Checks.id
    WHERE Peers.Birthday IN (SELECT "Date" FROM Checks) AND Verter."State" = '2'
    )
SELECT 
ROUND((SELECT COUNT(*) FROM one)* 100/((SELECT COUNT(*) FROM one)+(SELECT COUNT(*) FROM two) ),0) AS table1,
ROUND((SELECT COUNT(*) FROM two)* 100/((SELECT COUNT(*) FROM one)+(SELECT COUNT(*) FROM two) ),0) AS table2;
END;
$$;


CALL bithday_checks();
SELECT * FROM part_10_table;

DROP PROCEDURE IF EXISTS bithday_checks();

/* __11__ */


CREATE OR REPLACE PROCEDURE fail_part_3_1_2(Task_1 VARCHAR,Task_2 VARCHAR,Task_3 VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_11_table;
    CREATE TEMPORARY TABLE part_11_table AS
WITH One AS(
    SELECT DISTINCT Peer FROM Checks
    JOIN Verter ON Verter."Check" = Checks.id
    WHERE Verter."State" = '1' AND Checks.Task = $1),
    Two AS(
    SELECT DISTINCT Peer FROM Checks
    JOIN Verter ON Verter."Check" = Checks.id
    WHERE Verter."State" = '1' AND Checks.Task = $2),
    Three AS(
    SELECT DISTINCT Peer FROM Checks
    JOIN Verter ON Verter."Check" = Checks.id
    WHERE Verter."State" = '1' AND Checks.Task = $3)
SELECT * FROM One 
INTERSECT
SELECT * FROM Two
EXCEPT
SELECT * FROM Three;
END;
$$;

CALL fail_part_3_1_2('C1','C2','A6');
SELECT * FROM part_11_table;

DROP PROCEDURE IF EXISTS fail_part_3_1_2(Task_1 VARCHAR,Task_2 VARCHAR,Task_3 VARCHAR);


/* __12__ */

CREATE OR REPLACE PROCEDURE recorsive_task()
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_12_table;
CREATE TEMPORARY TABLE part_12_table AS
WITH RECURSIVE PreviousTasks AS (
  SELECT Title, 0 AS PrevCount
  FROM Tasks
  WHERE ParentTask = 'None'
  UNION ALL
  SELECT t.Title, pt.PrevCount + 1
  FROM Tasks t
  JOIN PreviousTasks pt ON t.ParentTask = pt.Title 
)
SELECT Title, PrevCount
FROM PreviousTasks
ORDER BY PrevCount;
END;
$$;

CALL recorsive_task();
SELECT * FROM part_12_table;

DROP PROCEDURE IF EXISTS recorsive_task();

/* __13__ */


CREATE OR REPLACE PROCEDURE ex_13()
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_13_table;
CREATE TEMPORARY TABLE part_13_table AS
WITH data_table AS (
        SELECT Checks.id, Checks."Date", P2P."Time", 
        (P2P."State" = '1' AND 
        (Verter."State" = '1' OR Verter."State" IS NULL) AND
        (XP.XPAmount::float / Tasks.MaxXP::float) > 0.8) AS success_check
    FROM Checks
    LEFT JOIN P2P ON Checks.id = P2P."Check"
    LEFT JOIN Verter ON Checks.id = Verter."Check"
    LEFT JOIN XP on Checks.id = XP."Check"
    LEFT JOIN Tasks on Checks.task = Tasks.title
    WHERE (P2P."State" = '1' OR P2P."State" = '2') 
        AND (Verter."State" = '1' OR Verter."State" IS NULL OR Verter."State" = '2')
    ORDER BY "Date", "Time"
    )
    SELECT "Date"
    FROM data_table
    WHERE success_check = 'true'
    GROUP BY "Date";
    end;
    $$;

CALL ex_13();
SELECT * FROM part_13_table;

DROP PROCEDURE IF EXISTS ex_13();
/* __14__ */


CREATE OR REPLACE PROCEDURE top_peer()
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_14_table;
CREATE TEMPORARY TABLE part_14_table AS
WITH one AS (
    SELECT XPAmount, Checks.Peer,Checks.Task FROM XP
    JOIN Checks ON Checks.id = XP."Check"
    JOIN Verter ON Checks.id = Verter."Check"
    WHERE Verter."State" = '1'
    ORDER BY Checks.Task
)
SELECT one.peer,SUM(one.XPAmount) AS XP FROM one
GROUP BY peer
ORDER BY XP DESC
LIMIT 1;
END;
$$;


CALL top_peer();
SELECT * FROM part_14_table;

DROP PROCEDURE IF EXISTS top_peer();


/* __15__ */


CREATE OR REPLACE PROCEDURE check_time(time_ TIME,N INT)
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_15_table;
CREATE TEMPORARY TABLE part_15_table AS
with one as(
    SELECT  Peer, Count(*) AS sum_n FROM TimeTracking
    WHERE time_ > TimeTracking."Time" AND TimeTracking."state" = '1'
    GROUP BY Peer
)
SELECT Peer FROM one
WHERE sum_n >= N;
END;
$$;

CALL check_time('12:00:00',3);
SELECT * FROM part_15_table;

DROP PROCEDURE IF EXISTS check_time(time_ TIME,N INT);



/* __16__ */

    CREATE OR REPLACE PROCEDURE check_time_2(N INT, M INT)
    LANGUAGE plpgsql
    AS $$
    BEGIN
    DROP TABLE IF EXISTS part_16_table;
    CREATE TEMPORARY TABLE part_16_table AS
    WITH one AS (
        SELECT Peer,COUNT(*) AS outp, "Date" FROM TimeTracking
        WHERE TimeTracking."state" = '2' 
        GROUP BY Peer,"Date"
    )
    SELECT Peer FROM one
    WHERE one."Date" >= current_date - N AND one."Date" <= current_date AND one.outp > M;
    END;
    $$;

CALL check_time_2(400,3);
SELECT * FROM part_16_table;

DROP PROCEDURE IF EXISTS check_time_2(N INT,M INT);



/* __17__ */


CREATE OR REPLACE PROCEDURE part_17()
LANGUAGE plpgsql
AS $$
BEGIN
DROP TABLE IF EXISTS part_17_table;
CREATE TEMPORARY TABLE part_17_table AS
WITH 
one AS(
    SELECT EXTRACT(MONTH FROM "Date") AS Month, COUNT(*) AS counts FROM TimeTracking
    JOIN Peers ON TimeTracking.Peer = Peers.Nickname
    WHERE TimeTracking."state" = '1'
    GROUP BY Month
),
two AS(
    SELECT EXTRACT(MONTH FROM "Date") as  Month, count(*) AS COUNTS FROM TimeTracking
    JOIN Peers ON Peers.Nickname = TimeTracking.Peer
    WHERE TimeTracking."Time" < '12:00' AND TimeTracking."state" = '1'
    GROUP BY Month
)

SELECT
to_char(to_date(one.Month::text, 'MM'), 'Month') as Months,
ROUND((sum(two.counts)*100) / sum(one.counts), 0) AS EarlyEntries
FROM one
JOIN two ON one.Month = two.Month
GROUP BY one.Month
ORDER BY one.Month;
end;
$$;

CALL part_17();
SELECT * FROM part_17_table;

DROP PROCEDURE IF EXISTS part_17();