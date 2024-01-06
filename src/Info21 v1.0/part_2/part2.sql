-- CREATE PROCEDURE
CREATE OR REPLACE PROCEDURE CreateP2PExamination(Checked_Peer VARCHAR, Checking_Peer VARCHAR,Task_name VARCHAR,"state" status,"time" time)
LANGUAGE plpgsql AS $$
BEGIN
IF "state" = 0 THEN
    INSERT INTO Checks VALUES ((SELECT MAX(id) FROM Checks)+1, Checked_Peer, Task_name,current_date);
    INSERT INTO P2P VALUES ((SELECT MAX(id) FROM Checks), Checked_Peer,Checking_Peer, '0', "time");
ELSE
INSERT INTO P2P VALUES ((SELECT MAX(id) FROM Checks), Checked_Peer,Checking_Peer, "state", "time");
END IF;
END;
$$;



-- DROP PROCEDURE
DROP PROCEDURE CreateP2PExamination;


-- CREATE PROCEDURE
CREATE OR REPLACE PROCEDURE CreateVerterProcedure(Checked_Peer VARCHAR,Task_name VARCHAR,"state" status,"time" time)
LANGUAGE plpgsql AS $$
BEGIN
IF (
    SELECT P2P.id FROM P2P 
    join Checks
    ON Checks.id = P2P."Check"
    WHERE Checks.Task = Task_name AND P2P.checkingpeer == Checked_Peer AND P2P."State" = 1
    ORDER BY "Date"
    LIMIT 1 OFFSET -1
)IS NOT NULL THEN
    INSERT INTO Verter VALUES((SELECT MAX(id) FROM Checks),Checked_Peer,"state","time");
ELSE 
    INSERT INTO Verter VALUES((SELECT MAX(id) FROM Checks),Checked_Peer,'0',"time");
end IF;
END;
$$;


-- DROP PROCEDURE
DROP PROCEDURE CreateVerterProcedure;


-- CREATE FUNCTION
CREATE OR REPLACE FUNCTION funk_CheckUpdate()
RETURNS TRIGGER AS
$$
BEGIN
IF NEW."State" = '0' THEN
IF
(    SELECT TransferredPoints.id FROM TransferredPoints
    WHERE CheckingPeer = NEW.CheckingPeer AND CheckingPeer = (SELECT Checks.id FROM P2P join Checks ON Checks.id = P2P."Check")) IS NOT NULL THEN
    UPDATE TransferredPoints SET PointsAmount = PointsAmount+1  WHERE id = (SELECT TransferredPoints.id FROM TransferredPoints WHERE CheckingPeer = NEW.CheckingPeer AND CheckedPeer = (SELECT Checks.id FROM P2P join Checks ON Checks.id = P2P."Check"));
 ELSE 
    INSERT INTO TransferredPoints VALUES (NEW.CheckingPeer,(SELECT Checks.id FROM P2P join Checks ON Checks.id = P2P."Check"),'1');
END IF;
RETURN NEW;
ELSE
RETURN OLD;
END IF;
END;
$$ LANGUAGE plpgsql;
-- CREATE TRIGGER
CREATE OR REPLACE TRIGGER CheckUpdate AFTER UPDATE OF "State" ON P2P
FOR EACH ROW
EXECUTE FUNCTION funk_CheckUpdate();



-- DROP TRIGGER
DROP TRIGGER CheckUpdate ON P2P;
-- DROP FUNCTION
DROP FUNCTION funk_CheckUpdate();



CREATE OR REPLACE FUNCTION funk_XPCheck()
RETURNS TRIGGER AS
$$
BEGIN 
IF NEW.XPAmount <= (
    SELECT Tasks.MaxXP FROM XP
    JOIN Checks ON XP."Check" = Checks.id
    JOIN Tasks ON Tasks.Title = Checks.Task
    WHERE XP.id = NEW.id
    ) IS NOT NULL THEN
        IF (SELECT 1 FROM Checks JOIN XP ON XP."Check" = Checks.id WHERE Checks.id = NEW."Check") IS NOT NULL THEN
        INSERT INTO XP VALUES (NEW.id, NEW."Checks", NEW.XPAmount);
        RETURN NEW;
        END IF;
END IF;
END;
$$ LANGUAGE plpgsql;



-- CREATE TRIGGER
CREATE OR REPLACE TRIGGER XPCheck BEFORE UPDATE ON XP
FOR EACH ROW
EXECUTE FUNCTION funk_XPCheck();


-- DROP TRIGGER
DROP TRIGGER XPCheck ON XP;
-- DROP FUNCTION
DROP FUNCTION funk_XPCheck();
