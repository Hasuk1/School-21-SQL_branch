-- CREATE PROCEDURE CopyFromCSV
CREATE OR REPLACE PROCEDURE CopyFromCSV(Delim_etr CHAR(1),file_name VARCHAR , table_name VARCHAR )
LANGUAGE plpgsql AS $$
BEGIN EXECUTE 'COPY ' || table_name || ' FROM ' ||''''|| file_name || ''' DELIMITER '''|| Delim_etr ||'''' ||'CSV HEADER';
END;
$$;


-- TEST PROCEDURE
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/peers.csv', 'Peers');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/tasks.csv', 'Tasks');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/checks.csv', 'Checks');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/P2P.csv', 'P2P');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/verter.csv', 'Verter');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/transferred_points.csv', 'TransferredPoints');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/friends.csv', 'Friends');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/recommendations.csv', 'Recommendations');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/xp.csv', 'XP');
CALL CopyFromCSV(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/time_tracking.csv', 'TimeTracking');

-- DROP PROCEDURE
DROP PROCEDURE CopyFromCSV;


-- CREATE PROCEDURE CopyFromTable
CREATE OR REPLACE PROCEDURE CopyFromTable(Delim_etr CHAR(1),file_name VARCHAR , table_name VARCHAR )
LANGUAGE plpgsql AS $$
BEGIN EXECUTE 'COPY ' || table_name || ' TO ' || '''' || file_name || ''' DELIMITER ''' || Delim_etr || '''' || 'CSV HEADER';
end;
$$;


-- TEST PROCEDURE
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_peers.csv', 'Peers');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_tasks.csv', 'Tasks');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_checks.csv', 'Checks');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_P2P.csv', 'P2P');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_verter.csv', 'Verter');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_transferred_points.csv', 'TransferredPoints');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_friends.csv', 'Friends');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_recommendations.csv', 'Recommendations');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_xp.csv', 'XP');
CALL CopyFromTable(';', '/Users/perlabru/my-project/SQL2_Info21_v1.0-1/src/dataset_sql/test_data_time_tracking.csv', 'TimeTracking');


-- DROP PROCEDURE
DROP PROCEDURE CopyFromTable;