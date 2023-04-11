SET SERVEROUTPUT ON;
SET VERIFY OFF;


CREATE OR REPLACE PROCEDURE check_all_trains
IS
    
BEGIN

    FOR R IN (SELECT * FROM Train) LOOP
        DBMS_OUTPUT.PUT_LINE(R.Train_Name || ' Source: ' || R.Source || ' Destination: ' || R.Destination);
    END LOOP;
   
END;
/
EXEC check_all_trains;
commit;