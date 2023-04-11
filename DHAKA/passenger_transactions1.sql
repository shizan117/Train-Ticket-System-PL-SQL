SET SERVEROUTPUT ON;
SET VERIFY OFF;

CREATE OR REPLACE PROCEDURE passenger_transactions
IS
    passenger_active_status number := 0;
    passenger_id number := 0;
    
BEGIN
    FOR R IN (SELECT * FROM Passenger WHERE Passenger_active_status=1) LOOP
        passenger_active_status := 1;
        passenger_id := R.PID;
    END LOOP;

    IF (passenger_active_status = 1) THEN
        FOR R IN (SELECT Train.Train_Name, TicketBooked.TAmount FROM Train INNER JOIN TicketBooked ON Train.Train_no=TicketBooked.Train_no WHERE TicketBooked.PID=passenger_id) LOOP
            DBMS_OUTPUT.PUT_LINE(R.TAmount || ' tickets was booked on train ' || R.Train_Name);  
        END LOOP;
        FOR R IN (SELECT Train.Train_Name, TicketBooked.TAmount FROM Train@site2 INNER JOIN TicketBooked@site2 ON Train.Train_no=TicketBooked.Train_no WHERE TicketBooked.PID=passenger_id) LOOP
            DBMS_OUTPUT.PUT_LINE(R.TAmount || ' tickets was booked on train ' || R.Train_Name);  
        END LOOP;
        FOR R IN (SELECT Train.Train_Name, TicketBooked.TAmount FROM Train@site3 INNER JOIN TicketBooked@site3 ON Train.Train_no=TicketBooked.Train_no WHERE TicketBooked.PID=passenger_id) LOOP
            DBMS_OUTPUT.PUT_LINE(R.TAmount || ' tickets was booked on train ' || R.Train_Name);  
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('You must login first');    
    END IF;
END;
/

EXEC passenger_transactions;

commit;